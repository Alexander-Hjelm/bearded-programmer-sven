extends Node2D

func _on_Button_button_up():
	DaMusicManager.play_overworld_music()
	queue_free()
	#get_tree().change_scene("res://Overworld.tscn")
