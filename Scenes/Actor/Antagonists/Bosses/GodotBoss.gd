extends "res://Scenes/Actor/AnimatedActor.gd"


func _init():
	Global.godot_boss = self


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
			$SpriteAnim.play("hurt")
		anim_state_types.BOOSTSTAT:
			pass
		anim_state_types.LOWERSTAT:
			pass
		anim_state_types.DEATH:
			$FXMovementAnim.play("mov_death")