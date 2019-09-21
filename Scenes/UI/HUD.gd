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


func _ready():
	$InputPopUpMenu/InputBGPanel/AttackButton.connect("pressed", self,"attack_enemy")
	$InputPopUpMenu/InputBGPanel/InventoryButton.connect("pressed", self,"show_inventory")
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


func set_enemy_names(enemy_name : String):
	$BadGuyPanel/EnemyTeamLabel.text = str(enemy_name)


func update_player_HUD_stats(player_hp, player_hp_max): ## Update player hp
	player_hp_current_progressbar.value = player_hp
	player_hp_current_label.text = str(player_hp)
	player_hp_current_max_label.text = str(player_hp_max)


func attack_enemy():
	inactivate_player_input()
	combat_manager.player_attack()
	
	# Hide the inventory, in case it is open
	get_node("InventoryPanel").visible = false


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
			combat_manager.use_item_on_enemy(item_name, 0)

	# Finally, hide the inventory
	get_node("InventoryPanel").visible = false
	
	inactivate_player_input()