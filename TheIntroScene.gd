extends Node2D


var is_restart_game = false


func _input(event):
	if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("ui_accept"):
		$TheCanvas/TheIntro/TheIntroAnim.play("IntroDone")

func _ready():
	if is_restart_game:
		$TheCanvas/TheIntro/TheIntroAnim.play("IntroDone")

func _on_Button_button_up():
	DaMusicManager.play_overworld_music()
	queue_free()
	#get_tree().change_scene("res://Overworld.tscn")
