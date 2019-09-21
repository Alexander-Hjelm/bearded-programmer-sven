extends Control


onready var timer_progress = $TimerPanel/TimeProgressBar
onready var player_hp_current_progressbar = $PlayerPanel/HpProgressBar
onready var player_hp_current_label = $PlayerPanel/HpProgressBar/CurrentHP
onready var player_hp_current_max_label = $PlayerPanel/HpProgressBar/MaxHP
onready var input_popup_menu = $InputPopUpMenu
onready var input_attack_button = $InputPopUpMenu/InputBGPanel/AttackButton
onready var input_inventory_button = $InputPopUpMenu/InputBGPanel/InventoryButton

# Item button resource for iventory
onready var item_button_resource = preload("res://Scenes/UI/ItemButton.tscn")

#
#func _init():
#	Global.HUD = self

enum AttackMode {
	WITH_ITEM,
	WITH_WEAPON
}

var _queued_attack: bool = false
var _queued_attack_mode: int
var _queued_attack_item_name: String


func _ready():
	$InputPopUpMenu/InputBGPanel/AttackButton.connect("pressed", self,"attack_enemy")
	$InputPopUpMenu/InputBGPanel/InventoryButton.connect("pressed", self,"show_inventory")
	
	$BadGuyPanel/EnemyTeamLabel1.connect("pressed", self, "on_monster_label_clicked", [0])
	$BadGuyPanel/EnemyTeamLabel2.connect("pressed", self, "on_monster_label_clicked", [1])
	$BadGuyPanel/EnemyTeamLabel3.connect("pressed", self, "on_monster_label_clicked", [2])
	$BadGuyPanel/EnemyTeamLabel4.connect("pressed", self, "on_monster_label_clicked", [3])
	$BadGuyPanel/EnemyTeamLabel5.connect("pressed", self, "on_monster_label_clicked", [4])
	$BadGuyPanel/EnemyTeamLabel6.connect("pressed", self, "on_monster_label_clicked", [5])
	
	inactivate_player_input()


func activate_player_input(): #Activate Player Input
	input_popup_menu.show()
	input_attack_button.disabled = false
	input_inventory_button.disabled = false


func inactivate_player_input(): #Inactivate Player Input
	input_popup_menu.hide()
	input_attack_button.disabled = true
	input_inventory_button.disabled = true


func update_player_HUD_timer(player_timer : int, player_timer_done : bool): #sends player timer data and sets player input true/false
	timer_progress.value = player_timer
	if player_timer_done:
		activate_player_input()
	else:
		inactivate_player_input()


func set_player_names(player_name : String):
	$PlayerPanel/PlayerTeamLabel.text = str(player_name)


func set_enemy_name(enemy_index: int, enemy_name : String):
	get_node("BadGuyPanel/EnemyTeamLabel" + str(enemy_index)).text = enemy_name
	get_node("BadGuyPanel/EnemyTeamLabel" + str(enemy_index)).visible = true


func update_player_HUD_stats(player_hp, player_hp_max): ## Update player hp
	player_hp_current_progressbar.value = player_hp
	player_hp_current_label.text = str(player_hp)
	player_hp_current_max_label.text = str(player_hp_max)


func attack_enemy():
	_queued_attack = true
	_queued_attack_mode = AttackMode.WITH_WEAPON
	
	$BadGuyPanel/PickEnemyLabel.visible = true
	
	# Hide the inventory, in case it is open
	get_node("InventoryPanel").visible = false
	inactivate_player_input()


func show_inventory():
	# Clear all old inventory buttons
	for item_button in get_node("InventoryPanel/VBoxContainer").get_children():
		item_button.queue_free()
	
	# Generate new inventory buttons from item database
	for item in item_database.items.keys():
		if inventory.has_item(item):
			var num_of_items: int = inventory.get_number_of_items(item)
			var item_button_instance: Button = item_button_resource.instance()
			get_node("InventoryPanel/VBoxContainer").add_child(item_button_instance)
			item_button_instance.text = str(num_of_items) + "x " + item
			item_button_instance.connect("pressed", self, "item_button_clicked", [item])
	
	# Finally, show the inventory
	get_node("InventoryPanel").visible = true


func item_button_clicked(item_name: String):
	var item: Item = item_database.items[item_name]
	match item.get_item_type():
		Item.ItemType.CONSUMABLE:
			combat_manager.use_item_on_player(item_name)
		Item.ItemType.OFFENSIVE:
			$BadGuyPanel/PickEnemyLabel.visible = true
			_queued_attack = true
			_queued_attack_mode = AttackMode.WITH_ITEM
			_queued_attack_item_name = item_name
			

	# Finally, hide the inventory
	get_node("InventoryPanel").visible = false
	
	inactivate_player_input()


func on_monster_label_clicked(monster_index: int):
	if not _queued_attack:
		return
	_queued_attack = false
	match _queued_attack_mode:
		AttackMode.WITH_ITEM:
			combat_manager.use_item_on_enemy(_queued_attack_item_name, monster_index)
		AttackMode.WITH_WEAPON:
			combat_manager.player_attack(monster_index)
	
	$BadGuyPanel/PickEnemyLabel.visible = false


func show_pop_up_message(text):
	$MessagePanel/MessagePanelAnim.play("Popup Long Show Message")
	$MessagePanel/MessageText.text = str(text)
