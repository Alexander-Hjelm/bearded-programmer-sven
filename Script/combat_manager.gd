class_name CombatManager extends Node2D

# Registered characters by team id. Type: <int, Array<Character>>
var _characters_by_team: Dictionary

# Visual node representations of characters. Type: <Character, Node2D>
var _visual_character_representations: Dictionary

# Attack timer for each character, determines when they are to attack next.
# Type: <Character, float>
var _character_timers: Dictionary

func _init():
	# Initialize team structures
	_characters_by_team[0] = []
	_characters_by_team[1] = []

func create_combat_encounter(characters_team_0: Array, characters_team_1: Array):
	for character in characters_team_0:
		register_character(character, 0)
	for character in characters_team_1:
		register_character(character, 1)

func register_character(character: Character, team: int):
	_characters_by_team[team].append(character)
	# Instantiate the AnimatedActor resource
	var resource_path: String = character.get_resource_path()
	var character_node = load(resource_path).instance()
	add_child(character_node)
	_visual_character_representations[character] = character_node
	
	# Set root position of the character node
	if team == 0:
		character_node.transform.origin = get_node("/root/MainScene/Team0StartPos").transform.origin
	elif team == 1:
		character_node.transform.origin = get_node("/root/MainScene/Team1StartPos").transform.origin
	reset_character_timer(character)

func tick():
	for character in _characters_by_team[0]:
		tick_character(character, 0)
	for character in _characters_by_team[1]:
		tick_character(character, 1)

func tick_character(character: Character, team: int):
	_character_timers[character] = _character_timers[character] - 1.0
	if _character_timers[character] <= 0.0:
		# TODO: if the active character is in team 0, show ui
		
		# AI: Pick a random character on the other team to attack
		var other_team: int = 0
		if team == 0:
			other_team = 1
		var rand_index = randi()%len(_characters_by_team[other_team])
		var target_character: Character = _characters_by_team[other_team][rand_index]
		attack(character, target_character, target_character.get_weapon())
		reset_character_timer(character)

func reset_character_timer(character: Character):
	_character_timers[character] = 100.0 - character.get_current_value_for_stat("speed")

func attack(src_character: Character, target_character: Character, item: Item):
	print(src_character.get_name() + " attacked " + target_character.get_name())
	# Apply weapon item effects + pass along the element attack of the weapon element on the src character
	var element = item.get_element()
	var src_element_attack: float = src_character.get_element_attack(element)
	for effect in item.get_inflicted_effects():
		target_character.add_effect(effect, item.get_element(), src_element_attack)

	print(target_character.get_name() + " now has hp: " + str(target_character.get_current_value_for_stat("hp")))
	