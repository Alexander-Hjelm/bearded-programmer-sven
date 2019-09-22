extends Node2D


func _input(event):
	if Input.is_key_pressed(KEY_U):
		restart()


func restart():
	get_tree().reload_current_scene()