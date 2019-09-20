extends Node2D

export var is_activated = true

export var has_random_atk_fx = false
export (PackedScene) var attack_fx_1
export (PackedScene) var attack_fx_2
export (PackedScene) var attack_fx_3
var current_atk_fx
export (PackedScene) var hurt_fx
export var attack_left = false

var state

enum anim_state_types {IDLE, ATTACK, HURT, DEATH, BOOSTSTAT, LOWERSTAT}

# Set the animation state
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
		anim_state_types.BOOSTSTAT:
			pass
		anim_state_types.LOWERSTAT:
			pass

# Update a given stat on the visual label node
func set_stat(stat_name: String, value: float):
	pass

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
	get_tree().get_root().add_child(atk_fx_instance)


func show_hurt_fx():
	var hurt_fx_instance = hurt_fx.instance
	add_child(hurt_fx_instance)