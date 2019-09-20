extends Node2D

var _tick_delta: float = 0.05
var _tick_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	# Test combat encounter
	var player_character: Character = character_database.characters["Bearded Programmer Sven"]
	var segfault_character: Character = character_database.characters["Segfault"]
	combat_manager.create_combat_encounter([player_character], [segfault_character])
	
	# Create the timer that executes tick
	_tick_timer = Timer.new()
	_tick_timer.connect("timeout",self,"_on_tick") 
	add_child(_tick_timer)
	_tick_timer.start(_tick_delta)

func _on_tick():
	combat_manager.tick()
	_tick_timer.start(_tick_delta)