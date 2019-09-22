extends Node2D

export (PackedScene) var intro_scene

func game_over():
	$CanvasLayer/MainGame/Button.disabled = false
	show()

func _on_Button_pressed():
	var intro_scene_instance = intro_scene.instance()
	intro_scene_instance.is_restart_game = true
	get_tree().get_root().add_child(intro_scene_instance)
	$CanvasLayer/MainGame/Button.disabled = true
	queue_free()
