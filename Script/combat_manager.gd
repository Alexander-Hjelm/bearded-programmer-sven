class_name CombatManager extends Node2D

signal combat_over_win # Emitted when all enemies have died
signal combat_over_fail # Emitted when all players and allies have died

# Registered characters by team id. Type: <int, Array<Character>>
var _characters_by_team: Dictionary

# Visual node representations of characters. Type: <Character, Node2D>
var _visual_character_representations: Dictionary

# Attack timer for each character, determines when they are to attack next.
# Type: <Character, float>
var _character_timers: Dictionary

# The target character which is to be attacked
# Must be queued to that the attacking character can access it after the Hurt animation has played
var _queued_target_character: Character

# Is ticking currently active? If not, no actors will be able to attack
# and no character timers will be updated
var _ticking_active: bool = true

# Timer that enforces a wait period between 2 actors Attack and Hurt animations
var _hurt_timer: Timer

# Has any of the combat_over signals been emitted during this encounter?
# Used to ensure that a given signal is only emitted once per combat encounter
var _combat_over_signal_emitted: bool = false

func _init():
	# Initialize team structures
	_characters_by_team[0] = []
	_characters_by_team[1] = []
	
	# Initialize hurt timer
	_hurt_timer = Timer.new()
	_hurt_timer.one_shot = true
	add_child(_hurt_timer)
	_hurt_timer.connect("timeout", self, "on_hurt_timer_timeout")

# Create a new combat encounter. The battle starts here!
func create_combat_encounter(characters_team_0: Array, characters_team_1: Array):
	# Clear up any old character references
	for character_node in _visual_character_representations.values():
		if str(character_node) != "[Deleted Object]":
			character_node.queue_free()
			
	# Initialize teams
	_characters_by_team[0] = []
	_characters_by_team[1] = []
	_visual_character_representations.clear()
	
	# Register all characters in the corect team
	for character in characters_team_0:
		register_character(character, 0)
	for character in characters_team_1:
		register_character(character, 1)
	
	_combat_over_signal_emitted = false

# Register a character at the beginning of a combat encounter
func register_character(character: Character, team: int):
	# Add the character to the correct team
	_characters_by_team[team].append(character)
	
	# Instantiate the AnimatedActor resource
	var resource_path: String = character.get_resource_path()
	var character_node = load(resource_path).instance()
	_visual_character_representations[character] = character_node
	
	# Set root position of the character node
	if team == 0:
		get_node("/root/MainScene/Team0StartPos").add_child(character_node)
	elif team == 1:
		get_node("/root/MainScene/Team1StartPos").add_child(character_node)
	
	# Set ticking timer to 0 for the new character
	reset_character_timer(character)

# The main heartbeat of the Combat cycle.
func tick():
	# Call tick_character for all characters, but only if ticking is active
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

# Tick routing for a single character
func tick_character(character: Character, team: int):
	# Update the Timer
	_character_timers[character] = _character_timers[character] - 1.0
	
	# Update HUD Timer
	if team == 0:
		HUD.update_player_HUD_timer(100 - 100*_character_timers[character]/character.get_current_value_for_stat("speed"), false)
	
	# Has the timer depleted?
	if _character_timers[character] <= 0.0:
		var other_team: int = 0
		if team == 0:
			other_team = 1
		
		if team == 0:
			# If the active character is in team 0, show ui and disable ticking
			HUD.activate_player_input()
			_ticking_active = false
		else:
			# If the active character is in team 1, let the AI decide
			# AI: Pick a random character on the other team to attack
			var rand_index = randi()%len(_characters_by_team[other_team])
			var target_character: Character = _characters_by_team[other_team][rand_index]
			attack(character, target_character, character.get_weapon())
			reset_character_timer(character)

# External entry for attacking with the player, called from the player UI
func player_attack():
	var player_character: Character = _characters_by_team[0][0]
	var target_character: Character = _characters_by_team[1][0]
	attack(player_character, target_character, player_character.get_weapon())
	reset_character_timer(player_character)

# Reset a character's timer to a max value that depends on the character's speed stat
func reset_character_timer(character: Character):
	_character_timers[character] = 100.0 - character.get_current_value_for_stat("speed")

# Attack a character with another character, using an item
func attack(src_character: Character, target_character: Character, item: Item):
	print(src_character.get_name() + " attacked " + target_character.get_name())
	
	# Apply weapon item effects + pass along the element attack of the weapon element on the src character
	var element = item.get_element()
	var src_element_attack: float = src_character.get_element_attack(element)
	
	# The HUD should be notified if the effect has raised or lowered any stats
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
	
	# Disable ticking until the Hurt animation has played
	_ticking_active = false

# Called after Attak, after the Hurt animation has played
func on_hurt_timer_timeout():
	# Play hurt animation on the queued target character
	var animated_actor = _visual_character_representations[_queued_target_character]
	animated_actor.change_anim_state(AnimatedActor.anim_state_types.HURT)
	
	# Update the animated actor with new stats
	for stat in _queued_target_character.get_stat_keys():
		animated_actor.set_stat(stat, _queued_target_character.get_current_value_for_stat(stat))
	
	# Enabled ticking again
	_ticking_active = true
	
	print(_queued_target_character.get_name() + " now has hp: " + str(_queued_target_character.get_current_value_for_stat("hp")))
	
	# If the character's hp is <= 0, kill it
	if(_queued_target_character.get_current_value_for_stat("hp") <= 0.0):
		animated_actor.change_anim_state(AnimatedActor.anim_state_types.DEATH)
		_characters_by_team[0].erase(_queued_target_character)
		_characters_by_team[1].erase(_queued_target_character)
		print(_queued_target_character.get_name() + " has died")
	
	# Dereference the queued target character just in case
	_queued_target_character = null	

# Send a "Boost Stat" message to the HUD
func send_boost_stat_message(character: Character):
	_visual_character_representations[character].change_anim_state(AnimatedActor.anim_state_types.BOOSTSTAT)

# Send a "Lower Stat" message to the HUD
func send_lower_stat_message(character: Character):
	_visual_character_representations[character].change_anim_state(AnimatedActor.anim_state_types.LOWERSTAT)


func keep_track_of_svens_morph_state(_active_combat_encounter):
	match _active_combat_encounter:
		0:
			pass
		1:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.SEG)
			print(Global.sven_the_bad_programmer)
			print(Global.sven_current_morph_state)
		2:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.SEGSTACK)
			print(Global.sven_current_morph_state)
		3:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.FULLMORPH)
			print(Global.sven_current_morph_state)
		4:
			Global.you_merged_with_godot = true
			Global.sven_the_bad_programmer.change_anim_state(Global.sven_the_bad_programmer.DEATH)