extends StaticBody2D

var _label_timer: Timer

func _ready():
	$Area2D.connect("body_entered", self, "_on_body_enter")
	$Label.visible = false
	
	_label_timer = Timer.new()
	_label_timer.connect("timeout",self,"_hide_label") 
	_label_timer.one_shot = true
	add_child(_label_timer)

func _on_body_enter(body):
	if body.name == "OverworldPlayer":
		game_manager.restore_player_hp()
		$Label.visible = true
		$AudioStreamPlayer2D.play()
		_label_timer.start(1.0)

func _hide_label():
	$Label.visible = false