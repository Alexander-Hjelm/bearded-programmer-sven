class_name CombatManager

# Registered characters by team id. Type: <int, Array<Character>>
var _characters_by_team: Dictionary

# Visual node representations of characters. Type: <Character, Node2D>
var _visual_character_representations: Dictionary

# Attack timer for each character, determines when they are to attack next.
# Type: <Character, float>
var _character_timers: Dictionary

func _init():
	# Initialize team structures
	characters_by_team[0] = []
	characters_by_team[1] = []

func create_combat_encounter(characters_team_0: Array, characters_team_1: Array):
	for character in characters_team_0:
		register_character(character)
	for character in characters_team_1:
		register_character(character)

func register_character(character: Character, team: int):
	characters_by_team[team].append(character)
	var character_visual_node = Node2D.new().instance()
	add_child(character_visual_node)
	visual_character_representations[character] = character_visual_node
	reset_character_timer(character)

func tick():
	for character in characters_by_team[0]:
		tick_character(character, 0)
	for character in characters_by_team[1]:
		tick_character(character, 1)

func tick_character(character: Character, team: int):
	_character_timers[character] = _character_timers[character] - 1.0
	if _character_timers[character] <= 0.0:
		#TODO: it's that character's turn to attack
		
		# AI: Pick a random character on the other team to attack
		var other_team: int = 0
		if team == 0:
			other_team = 1
		var rand_index = randi()%len(_characters_by_team[other_team])
		var target_character: Character = _characters_by_team[other_team][rand_index]
		attack(character, target_character, target_character.get_weapon())
		reset_character_timer(character)

func reset_character_timer(character: Character):
	character_timers[character] = 100.0 - character.get_current_value_for_stat("speed")

func attack(src_character: Character, target_character: Character, item: Item):
	pass

# TODO: if the active character is in team 1, show ui
#	( apply weapon item effects + pass along the element attack of the weapon element on the src character
# TODO: Each weapon has an element associated to it
# TODO: Enforce that every character has a weapon

# DONE
# TODO: manage registered characters by team
# TODO: Entry for registering a character
# TODO: Entry function for creating characters on teams by name reference
# TODO: for each registered character, maintain a reference to the visual node
# TODO: for each character, maintain a timer
# TODO: central clock, decrease every character's timer
# TODO: if any character's timer becomes < 0.0, set that character as the active character
# TODO: if the active character is in team 2, attack a random character from team 1
