class_name AnimatedActor extends Node2D

export var monster_name = ""

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

enum morphstate_monster {SEG, TV, STACK, NOMERGE}
export (morphstate_monster) var monster_merge_type

export var play_standard_encounter_music = false

func _ready():
	if play_standard_encounter_music:
		DaMusicManager.play_combat_music_1()

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
		anim_state_types.DEATH:
			$FXMovementAnim.play("mov_death")
			set_merge_on_sven()

# Update a given stat on the visual label node
func set_stat(stat_name, value):
	$Pos/StatLabel.text = str(stat_name) + str(value)


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


func set_merge_on_sven():
	if not monster_merge_type == morphstate_monster.NOMERGE:
		HUD.show_pop_up_message("You merged with the %s" % monster_name)
		match monster_merge_type:
			morphstate_monster.SEG:
				Global.has_seg = true
			morphstate_monster.TV:
				Global.has_tv = true
			morphstate_monster.STACK:
				Global.has_stack = true
		
		if Global.has_seg:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.SEG)
			if Global.has_stack:
				Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.SEGSTACK)
			if Global.has_tv:
				Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.SEGTV)
		
		if Global.has_stack:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.STACK)
			if Global.has_tv:
				Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.STACKTV)
		
		if Global.has_tv:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.TV)
		
		if Global.has_tv and Global.has_stack and Global.has_seg:
			Global.sven_the_bad_programmer.change_morph_state(Global.sven_morph_state_types.FULLMORPH)

