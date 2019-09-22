extends "res://Scenes/Actor/AnimatedActor.gd"


var game_end_screen = load("res://Scenes/UI/GameCompleted.tscn")

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


func create_end_scene():
	var end_scene_instance = game_end_screen.instance()
	get_tree().get_root().add_child(end_scene_instance)