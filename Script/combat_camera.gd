class_name CombatCamera extends Camera2D

#var _zoom_overworld: float = 2.0
#var _zoom_combat: float = 1.0
#var _last_overworld_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.combat_camera = self
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func set_position_and_zoom_combat():
#	_last_overworld_pos = transform.origin
#	transform.origin = OS.get_screen_size()/2
#	zoom = Vector2(1.0,1.0)*_zoom_combat

#func set_position_and_zoom_overworld():
#	transform.origin = _last_overworld_pos
#	zoom = Vector2(1.0,1.0)*_zoom_overworld