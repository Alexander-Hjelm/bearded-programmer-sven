class_name OverworldPlayer extends OverworldActor

func _ready():
	Global.overworld_player = self

func _process(delta):
	# Character movement
	var vx = 0.0
	var vy = 0.0
	if Input.is_action_pressed("ui_up"):
		vy -= 1.0
	if Input.is_action_pressed("ui_down"):
		vy += 1.0
	if Input.is_action_pressed("ui_right"):
		vx += 1.0
	if Input.is_action_pressed("ui_left"):
		vx -= 1.0
	
	set_velocity(vx, vy)
	