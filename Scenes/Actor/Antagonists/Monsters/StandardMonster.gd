extends "res://Scenes/Actor/AnimatedActor.gd"


func show_hurt_fx():
	var hurt_fx_instance = hurt_fx.instance()
	add_child(hurt_fx_instance)
	$Pos/LabelAnim.play("LabelAnimRed")