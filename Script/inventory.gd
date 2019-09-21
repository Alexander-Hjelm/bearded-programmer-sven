class_name Inventory extends Node2D

# A dictionary representing how many of each item type is currently in the player inventory
var _items: Dictionary = {}

func _init():
	for item_name in item_database.items.keys():
		_items[item_name] = 0

# Get an integer representing how many of this item we have
func get_number_of_items(item: String) -> int:
	if _items.has(item):
		return _items[item]
	else:
		print("Error: tried to get item: " + item + " from inventory, but that item does not exist")
		return -1

# Check if we have any of this item
func has_item(item: String) -> bool:
	if _items.has(item):
		return _items[item] > 0
	else:
		print("Error: tried to get item: " + item + " from inventory, but that item does not exist")
		return false

# Add an item
func add_item(item: String):
	if _items.has(item):
		_items[item] = _items[item] + 1
	else:
		print("Error: tried to add item: " + item + " to inventory, but that item does not exist")

# Remove an item. This will only remove one of the item, and not erase all items of that type
func remove_item(item: String):
	if _items.has(item):
		_items[item] = _items[item] - 1
	else:
		print("Error: tried to remove item: " + item + " from inventory, but that item does not exist")