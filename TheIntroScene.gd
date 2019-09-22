extends Node2D


var is_restart_game = false


func _ready():
	if is_restart_game:
		$TheCanvas/TheIntro/TheIntroAnim.play("IntroDone")

func _on_Button_button_up():
	DaMusicManager.play_overworld_music()
	queue_free()
	#get_tree().change_scene("res://Overworld.tscn")
