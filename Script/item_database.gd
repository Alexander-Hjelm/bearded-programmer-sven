class_name ItemDatabase

# Available items. Type: <String, Item>
const _items : Dictionary = {
	# Bubba cola. A consumable that gives a +5 hp boost
	"Bubba Cola": Item.new("Bubba Cola",
		[
			Effect({"hp": 5.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE
	)
}

static func get_item_by_name(name: String) -> Item:
	return _items[name]