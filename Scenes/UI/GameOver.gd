extends Node2D

export (PackedScene) var intro_scene


func game_over():
	$CanvasLayer/MainGame/Button.disabled = false
	Overworld.hide()
	CombatScene.hide()
	show()
	DaMusicManager.stop_all_music()

func _on_Button_pressed():
	$AnimationPlayer.play("quit")
	
	
	#var intro_scene_instance = intro_scene.instance()
	#intro_scene_instance.is_restart_game = true
	#get_tree().get_root().add_child(intro_scene_instance)
	#$CanvasLayer/MainGame/Button.disabled = true
	#queue_free()
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "quit":
		get_tree().quit()
