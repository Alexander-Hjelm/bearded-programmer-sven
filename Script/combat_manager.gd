class_name CombatManager extends Node2D

signal combat_over_win
signal combat_over_fail

# Registered characters by team id. Type: <int, Array<Character>>
var _characters_by_team: Dictionary

# Visual node representations of characters. Type: <Character, Node2D>
var _visual_character_representations: Dictionary

# Attack timer for each character, determines when they are to attack next.
# Type: <Character, float>
var _character_timers: Dictionary

var _queued_target_character: Character

var _ticking_active: bool = true
var _hurt_timer: Timer
var _combat_over_signal_emitted: bool = false

func _init():
	# Initialize team structures
	_characters_by_team[0] = []
	_characters_by_team[1] = []
	
	_hurt_timer = Timer.new()
	_hurt_timer.one_shot = true
	add_child(_hurt_timer)
	_hurt_timer.connect("timeout", self, "on_hurt_timer_timeout")

func create_combat_encounter(characters_team_0: Array, characters_team_1: Array):
	# Clear up any old character references
	for character_node in _visual_character_representations.values():
		if str(character_node) != "[Deleted Object]":
			character_node.queue_free()
	_characters_by_team[0] = []
	_characters_by_team[1] = []
	_visual_character_representations.clear()
	
	for character in characters_team_0:
		register_character(character, 0)
	for character in characters_team_1:
		register_character(character, 1)
	
	# Interface with HUD
	
	
	_combat_over_signal_emitted = false

func register_character(character: Character, team: int):
	_characters_by_team[team].append(character)
	# Instantiate the AnimatedActor resource
	var resource_path: String = character.get_resource_path()
	var character_node = load(resource_path).instance()
	#add_child(character_node)
	_visual_character_representations[character] = character_node
	
	# Set root position of the character node
	if team == 0:
		get_node("/root/MainScene/Team0StartPos").add_child(character_node)
		#character_node.transform.origin = get_node("/root/MainScene/Team0StartPos").transform.origin
	elif team == 1:
		get_node("/root/MainScene/Team1StartPos").add_child(character_node)
		#character_node.transform.origin = get_node("/root/MainScene/Team1StartPos").transform.origin
	reset_character_timer(character)

func tick():
	for character in _characters_by_team[0]:
		if not _ticking_active:
			return
		tick_character(character, 0)
	for character in _characters_by_team[1]:
		if not _ticking_active:
			return
		tick_character(character, 1)
	
	# Update HUD
	var player_hp: float = _characters_by_team[0][0].get_current_value_for_stat("hp")
	var player_hp_max: float = _characters_by_team[0][0].get_base_value_for_stat("hp")
	HUD.update_player_HUD_stats(player_hp, player_hp_max)
	
	# If there are no more enemies left, notify the game manager that the fight has ended
	if not _combat_over_signal_emitted:
		if len(_characters_by_team[0]) == 0:
			_combat_over_signal_emitted = true
			emit_signal("combat_over_fail")
		if len(_characters_by_team[1]) == 0:
			_combat_over_signal_emitted = true
			emit_signal("combat_over_win")

func tick_character(character: Character, team: int):
	_character_timers[character] = _character_timers[character] - 1.0
	
	# Update HUD Timer
	if team == 0:
		HUD.update_player_HUD_timer(100 - 100*_character_timers[character]/character.get_current_value_for_stat("speed"), false)
	
	if _character_timers[character] <= 0.0:
		var other_team: int = 0
		if team == 0:
			other_team = 1
		
		if team == 0:
			# If the active character is in team 0, show ui
			HUD.activate_player_input()
			_ticking_active = false
		else:
			# AI: Pick a random character on the other team to attack
			var rand_index = randi()%len(_characters_by_team[other_team])
			var target_character: Character = _characters_by_team[other_team][rand_index]
			attack(character, target_character, character.get_weapon())
			reset_character_timer(character)

func player_attack():
	var player_character: Character = _characters_by_team[0][0]
	var target_character: Character = _characters_by_team[1][0]
	attack(player_character, target_character, player_character.get_weapon())
	reset_character_timer(player_character)

func reset_character_timer(character: Character):
	_character_timers[character] = 100.0 - character.get_current_value_for_stat("speed")

func attack(src_character: Character, target_character: Character, item: Item):
	print(src_character.get_name() + " attacked " + target_character.get_name())
	# Apply weapon item effects + pass along the element attack of the weapon element on the src character
	var element = item.get_element()
	var src_element_attack: float = src_character.get_element_attack(element)
	
	var stats_raised: int = 0
	for effect in item.get_inflicted_effects():
		stats_raised = stats_raised + target_character.add_effect(effect, item.get_element(), src_element_attack)
	
	if stats_raised > 0:
		send_boost_stat_message(target_character)
	elif stats_raised < 0:
		send_lower_stat_message(target_character)
	
	# Play attack animation on the associated visual node
	_visual_character_representations[src_character].change_anim_state(AnimatedActor.anim_state_types.ATTACK)
	_queued_target_character = target_character
	_hurt_timer.set_wait_time(1.0)
	_hurt_timer.start()
	
	_ticking_active = false

func on_hurt_timer_timeout():
	var animated_actor = _visual_character_representations[_queued_target_character]
	animated_actor.change_anim_state(AnimatedActor.anim_state_types.HURT)
	
	# Update the animated actor with new stats
	for stat in _queued_target_character.get_stat_keys():
		animated_actor.set_stat(stat, _queued_target_character.get_current_value_for_stat(stat))
	
	_ticking_active = true
	
	print(_queued_target_character.get_name() + " now has hp: " + str(_queued_target_character.get_current_value_for_stat("hp")))
	
	# If the character's hp is <= 0, kill it
	if(_queued_target_character.get_current_value_for_stat("hp") <= 0.0):
		animated_actor.change_anim_state(AnimatedActor.anim_state_types.DEATH)
		_characters_by_team[0].erase(_queued_target_character)
		_characters_by_team[1].erase(_queued_target_character)
		print(_queued_target_character.get_name() + " has died")
	
	_queued_target_character = null	

func send_boost_stat_message(character: Character):
	_visual_character_representations[character].change_anim_state(AnimatedActor.anim_state_types.BOOSTSTAT)

func send_lower_stat_message(character: Character):
	_visual_character_representations[character].change_anim_state(AnimatedActor.anim_state_types.LOWERSTAT)