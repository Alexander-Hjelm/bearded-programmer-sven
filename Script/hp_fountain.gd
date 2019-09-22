extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered", self, "_on_body_enter")

func _on_body_enter(body):
	if body.name == "OverworldPlayer":
		game_manager.restore_player_hp()