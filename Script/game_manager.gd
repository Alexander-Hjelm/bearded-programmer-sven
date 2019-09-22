extends Node2D

# A ticking timer that controls the heartbeat of the combat manager
var _tick_delta: float = 0.05
var _tick_timer: Timer

# A timer that enforces a wait time after the combat encounter is won/lost
var _battle_over_wait: float = 1.0
var _battle_over_timer: Timer

# All possible combat encounters that will play out, in order
#var _combat_encounters: Array = [
#	[character_database.get_character("Segfault"),
#		character_database.get_character("Segfault")],
#	[character_database.get_character("Stack Overflow")],
#	[character_database.get_character("Blue Screen of Death")],
#	[character_database.get_character("Godot Boss")]
#]

enum _sven_morph_states {HUMAN,SEG, SEGTV, SEGSTACK, STACK, STACKTV, TV, FULLMORPH}

# Which combat encounter are we currently on?
#var _active_combat_encounter: int = 0

var _player_character: Character

var _overworld_running: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	CombatScene.visible = false
	
	# Spawn up the first combat encounter
	_player_character = character_database.get_character("Bearded Programmer Sven")
	#combat_manager.create_combat_encounter([_player_character], _combat_encounters[_active_combat_encounter])
	#_active_combat_encounter = _active_combat_encounter + 1
	
	combat_manager.connect("combat_over_win", self, "_on_combat_win")
	combat_manager.connect("combat_over_fail", self, "_on_combat_fail")
	
	# Create the timer that executes tick
	_tick_timer = Timer.new()
	_tick_timer.connect("timeout",self,"_on_tick") 
	add_child(_tick_timer)
	#_tick_timer.start(_tick_delta)
	
	# Create the timer that enforces a wait period after the combat encounter is won/lost
	_battle_over_timer = Timer.new()
	_battle_over_timer.connect("timeout",self,"_on_battle_over") 
	_battle_over_timer.one_shot = true
	add_child(_battle_over_timer)
	
	HUD.hide_combat_hud()
	
	_overworld_running = true

func start_combat_encounter(enemy_names: Array):
	var enemy_characters: Array = []
	for enemy_name in enemy_names:
		enemy_characters.append(character_database.get_character(enemy_name))
	combat_manager.create_combat_encounter([_player_character], enemy_characters)
	_tick_timer.start(_tick_delta)
	HUD.show_combat_hud()
	CombatScene.visible = true
	Overworld.visible = false
	_overworld_running = false

# Tick the combat manager
func _on_tick():
	combat_manager.tick()
	_tick_timer.start(_tick_delta)

# The battle was won
func _on_combat_win():
	# Wait for a short period to allow all death animations to play out
	_battle_over_timer.start(_battle_over_wait)

# The battle was lost
func _on_combat_fail():
	pass

func _on_battle_over():
	# The battle was won, go back to the overworld
	_tick_timer.stop()
	HUD.hide_combat_hud()
	CombatScene.visible = false
	Overworld.visible = true
	_overworld_running = true

func is_overworld_running() -> bool:
	return _overworld_running