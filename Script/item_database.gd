class_name ItemDatabase

# Available items. Type: <String, Item>
var _items : Dictionary = {
	# Bubba cola. A consumable that gives a +5 hp boost
	"Bubba Cola": Item.new("Bubba Cola",
		[
			Effect({"hp": 5.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE
	),
	# Segway, feet item used by the segfault
	"Segway": Item.new("Segway",
		[
			Effect({"speed": 0.2}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Trash can, body item used by the Stack Overflow
	"Trash can": Item.new("Trash can",
		[
			Effect({"element_resist_software": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Monitor, head item used by the Blue Screen of Death
	"Monitor": Item.new("Monitor",
		[
			Effect({"element_resist_software": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	)
}

static func get_item_by_name(name: String) -> Item:
	return _items[name]