extends Control


onready var timer_progress = $TimerPanel/TimeProgressBar
onready var player_hp_current_progressbar = $PlayerPanel/HpProgressBar
onready var player_hp_current_label = $PlayerPanel/HpProgressBar/CurrentHP
onready var player_hp_current_max_label = $PlayerPanel/HpProgressBar/MaxHP
onready var input_popup_menu = $InputPopUpMenu
onready var input_attack_button = $InputPopUpMenu/InputBGPanel/AttackButton
onready var input_dosomething_button = $InputPopUpMenu/InputBGPanel/DoSomething ### Add Functionality here... :P

#
#func _init():
#	Global.HUD = self


func _ready():
	$InputPopUpMenu/InputBGPanel/AttackButton.connect("pressed", self,"attack_enemy")
	inactivate_player_input()


func activate_player_input(): #Activate Player Input
	input_popup_menu.show()
	input_attack_button.disabled = false
	input_dosomething_button.disabled = false


func inactivate_player_input(): #Inactivate Player Input
	input_popup_menu.hide()
	input_attack_button.disabled = true
	input_dosomething_button.disabled = true


func update_player_HUD_timer(player_timer : int, player_timer_done : bool): #sends player timer data and sets player input true/false
	timer_progress.value = player_timer
	if player_timer_done:
		activate_player_input()
	else:
		inactivate_player_input()


func set_player_names(player_name : String):
	$PlayerPanel/PlayerTeamLabel.text = str(player_name)


func set_enemy_names(enemy_name : String):
	$BadGuyPanel/EnemyTeamLabel.text = enemy_name


func update_player_HUD_stats(player_hp, player_hp_max): ## Update player hp
	player_hp_current_progressbar.value = player_hp
	player_hp_current_label.text = str(player_hp)
	player_hp_current_max_label.text = str(player_hp_max)


func attack_enemy():
	inactivate_player_input()
	combat_manager.player_attack()