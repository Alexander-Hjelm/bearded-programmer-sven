class_name OverworldEnemy extends OverworldActor

var _follow_target: Node2D

func _ready():
	$Area2DBig.connect("body_enter", self, "_on_body_enter_big")
	$Area2DSmall.connect("body_enter", self, "_on_body_enter_small")

func _process(delta):
	if _follow_target != null:
		# Character movement
		var v: Vector2 = _follow_target.transform.origin - transform.origin
		v = v.normalized()
		set_velocity(v.x, v.y)

func _on_body_enter_big(body):
	if body.name == "PlayerOverworld":
		_follow_target = body

func _on_body_enter_small(body):
	if body.name == "PlayerOverworld":
		# TODO: Start combat encounter here
		pass