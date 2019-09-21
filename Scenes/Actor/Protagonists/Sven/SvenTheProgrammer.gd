extends "res://Scenes/Actor/AnimatedActor.gd"

enum morph_state_types {HUMAN,SEG, SEGTV, SEGSTACK, STACK, STACKTV, TV, FULLMORPH}
var morph_state


func _ready():
	change_morph_state(morph_state_types.HUMAN)


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
			if morph_state == morph_state_types.HUMAN:
				$SpriteAnim.play("human_hurt")
		anim_state_types.BOOSTSTAT:
			pass
		anim_state_types.LOWERSTAT:
			pass


func change_morph_state(new_morph_state):
	morph_state = new_morph_state
	match morph_state:
		morph_state_types.HUMAN:
			$SpriteAnim.play("human_idle")
		morph_state_types.SEG:
			$SpriteAnim.play("seg")
		morph_state_types.SEGTV:
			$SpriteAnim.play("segtv")
		morph_state_types.SEGSTACK:
			$SpriteAnim.play("segstack")
		morph_state_types.STACK:
			$SpriteAnim.play("stack")
		morph_state_types.STACKTV:
			$SpriteAnim.play("stacktv")
		morph_state_types.TV:
			$SpriteAnim.play("tv")
		morph_state_types.SEG:
			$SpriteAnim.play("fullmorph")


#func _input(event):
#	if Input.is_key_pressed(KEY_U):
#		change_anim_state(anim_state_types.ATTACK)
#		change_morph_state(morph_state_types.SEG)
#	if Input.is_key_pressed(KEY_H):
#		change_anim_state(anim_state_types.HURT)


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