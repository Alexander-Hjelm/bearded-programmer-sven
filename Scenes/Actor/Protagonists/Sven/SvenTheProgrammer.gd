extends "res://Scenes/Actor/AnimatedActor.gd"

var morph_explo = preload("res://Scenes/FX/Smoke/MorphExplo.tscn")

func _init():
	Global.sven_the_bad_programmer = self


func _ready():
	change_morph_state(Global.sven_current_morph_state)


func change_anim_state(new_state):
	state = new_state
	match state:
		anim_state_types.IDLE:
			pass
		anim_state_types.ATTACK:
			if attack_left:
				$FXMovementAnim.play("mov_attack_left")
			else:
				$FXMovementAnim.play("mov_attack_right")
		anim_state_types.HURT:
			$FXMovementAnim.play("mov_hurt")
			if Global.sven_current_morph_state == Global.sven_morph_state_types.HUMAN:
				$SpriteAnim.play("human_hurt")
		anim_state_types.BOOSTSTAT:
			pass
		anim_state_types.LOWERSTAT:
			pass
		anim_state_types.DEATH:
			$FXMovementAnim.play("mov_death")


func change_morph_state(new_morph_state):
	Global.sven_current_morph_state = new_morph_state
	match Global.sven_current_morph_state:
		Global.sven_morph_state_types.HUMAN:
			$SpriteAnim.play("human_idle")
		Global.sven_morph_state_types.SEG:
			$SpriteAnim.play("seg")
		Global.sven_morph_state_types.SEGTV:
			$SpriteAnim.play("segtv")
		Global.sven_morph_state_types.SEGSTACK:
			$SpriteAnim.play("segstack")
		Global.sven_morph_state_types.STACK:
			$SpriteAnim.play("stack")
		Global.sven_morph_state_types.STACKTV:
			$SpriteAnim.play("stacktv")
		Global.sven_morph_state_types.TV:
			$SpriteAnim.play("tv")
		Global.sven_morph_state_types.FULLMORPH:
			$SpriteAnim.play("fullmorph")
	create_morph_explosion()


func create_morph_explosion():
	var morphexplo_instance = morph_explo.instance()
	add_child(morphexplo_instance)


func show_attack_fx():
	if has_random_atk_fx:
		randomize()
		var rolldice = randi() % 2 + 1
		match rolldice:
			1: current_atk_fx = attack_fx_1
			2: current_atk_fx = attack_fx_2
			3: current_atk_fx = attack_fx_3
	else:
		current_atk_fx = attack_fx_1
	
	var atk_fx_instance = current_atk_fx.instance()
	if attack_left:
		atk_fx_instance.set_direction(atk_fx_instance.DIRECTION_LEFT)
	$attackFXPOS.add_child(atk_fx_instance)


func show_hurt_fx():
	var hurt_fx_instance = hurt_fx.instance()
	add_child(hurt_fx_instance)
	$Pos/LabelAnim.play("LabelAnimRed")