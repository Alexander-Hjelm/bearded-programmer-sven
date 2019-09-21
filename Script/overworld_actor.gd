extends RigidBody2D
class_name OverworldActor # Needed for inheritance

export var speed = 1.0

var animated_sprite

func _ready():
	animated_sprite = get_node("AnimatedSprite")

func set_velocity(vx, vy):	
	# Animation
	if abs(vx) > 0.1 and not abs(vy) > 0.1:
		animated_sprite.play("walkSide")
	elif (vy) > 0.1:
		animated_sprite.play("walkDown")
	elif (vy) < -0.1:
		animated_sprite.play("walkUp")
	if abs(vy) < 0.1 and abs(vx) < 0.1:
		animated_sprite.play("idle")
	
	set_linear_velocity(speed*Vector2(vx, vy).normalized())
	
	if vx < 0.0:
		animated_sprite.flip_h = true
	elif vx > 0.0:
		animated_sprite.flip_h = false