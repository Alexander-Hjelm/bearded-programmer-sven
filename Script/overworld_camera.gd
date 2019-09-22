class_name OverworldCamera extends Camera2D

func _ready():
	Global.overworld_camera = self
	

func _process(delta):
	var follow_target = Global.overworld_player
	transform.origin = follow_target.transform.origin