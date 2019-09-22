class_name OverworldEnemy extends OverworldActor

export(Array, String) var enounter_enemy_names = []

var _follow_target: Node2D

func _ready():
	$Area2DBig.connect("body_entered", self, "_on_body_enter_big")
	$Area2DSmall.connect("body_entered", self, "_on_body_enter_small")

func _process(delta):
	if _follow_target != null:
		# Character movement
		var v: Vector2 = _follow_target.transform.origin - transform.origin
		v = v.normalized()
		set_velocity(v.x, v.y)

func _on_body_enter_big(body):
	print("_on_body_enter_big" + " " + str(body))
	if body.name == "OverworldPlayer":
		_follow_target = body

func _on_body_enter_small(body):
	if body.name == "OverworldPlayer":
		game_manager.start_combat_encounter(enounter_enemy_names)
		DaMusicManager.play_encounter_sfx()
		queue_free()