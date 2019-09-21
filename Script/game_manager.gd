extends Node2D

# A ticking timer that controls the heartbeat of the combat manager
var _tick_delta: float = 0.05
var _tick_timer: Timer

# A timer that enforces a wait time after the combat encounter is won/lost
var _battle_over_wait: float = 1.0
var _battle_over_timer: Timer

# All possible combat encounters that will play out, in order
var _combat_encounters: Array = [
	[character_database.characters["Segfault"]],
	[character_database.characters["Stack Overflow"]],
	[character_database.characters["Blue Screen of Death"]],
	[character_database.characters["Godot Boss"]]
]

enum _sven_morph_states {HUMAN,SEG, SEGTV, SEGSTACK, STACK, STACKTV, TV, FULLMORPH}

# Which combat encounter are we currently on?
var _active_combat_encounter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Spawn up the first combat encounter
	var player_character: Character = character_database.characters["Bearded Programmer Sven"]
	combat_manager.create_combat_encounter([player_character], _combat_encounters[_active_combat_encounter])
	_active_combat_encounter = _active_combat_encounter + 1
	
	combat_manager.connect("combat_over_win", self, "_on_combat_win")
	combat_manager.connect("combat_over_fail", self, "_on_combat_fail")
	
	# Create the timer that executes tick
	_tick_timer = Timer.new()
	_tick_timer.connect("timeout",self,"_on_tick") 
	add_child(_tick_timer)
	_tick_timer.start(_tick_delta)
	
	# Create the timer that enforces a wait period after the combat encounter is won/lost
	_battle_over_timer = Timer.new()
	_battle_over_timer.connect("timeout",self,"_on_battle_over") 
	_battle_over_timer.one_shot = true
	add_child(_battle_over_timer)

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
	# The battle was won, create the next combat encounter
	if _active_combat_encounter < _combat_encounters.size():
		var player_character: Character = character_database.characters["Bearded Programmer Sven"]
		combat_manager.keep_track_of_svens_morph_state(_active_combat_encounter)
		combat_manager.create_combat_encounter([player_character], _combat_encounters[_active_combat_encounter])
		_active_combat_encounter = _active_combat_encounter + 1