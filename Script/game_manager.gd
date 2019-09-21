extends Node2D

var _tick_delta: float = 0.05
var _tick_timer: Timer

var _battle_over_wait: float = 1.0
var _battle_over_timer: Timer

var _combat_encounters: Array = [
	[character_database.characters["Segfault"]],
	[character_database.characters["Stack Overflow"]],
	[character_database.characters["Blue Screen of Death"]]
]

var _active_combat_encounter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Test combat encounter
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


func _on_tick():
	combat_manager.tick()
	_tick_timer.start(_tick_delta)

func _on_combat_win():
	_battle_over_timer.start(_battle_over_wait)

func _on_combat_fail():
	pass

func _on_battle_over():
	var player_character: Character = character_database.characters["Bearded Programmer Sven"]
	combat_manager.create_combat_encounter([player_character], _combat_encounters[_active_combat_encounter])
	_active_combat_encounter = _active_combat_encounter + 1