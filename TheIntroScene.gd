extends Node2D


var is_restart_game = false
var wtf = false

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


func _on_WTFButton_pressed():
	if wtf == false:
		$TheCanvas/TheIntro/TheIntroAnim.play("WTF")
		wtf = true
		$TheCanvas/MainGame/Button/WTFButton/UISound.play()
	else:
		$TheCanvas/TheIntro/TheIntroAnim.play("IntroDone")
		wtf = false
