class_name ItemDatabase extends Node2D

# Available items. Type: <String, Item>
var items : Dictionary = {
	# Bubba cola. A consumable that gives a +5 hp boost
	"Bubba Cola": Item.new("Bubba Cola", ElementDatabase.Element.glitch,
		[
			Effect.new({"hp": 5.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE
	),
	# Segway, feet item used by the segfault
	"Segway": Item.new("Segway", ElementDatabase.Element.glitch,
		[
			Effect.new({"speed": 0.2}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Trash Can, body item used by the Stack Overflow
	"Trash Can": Item.new("Trash Can", ElementDatabase.Element.glitch,
		[
			Effect.new({"element_resist_software": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Monitor, head item used by the Blue Screen of Death
	"Monitor": Item.new("Monitor", ElementDatabase.Element.glitch,
		[
			Effect.new({"element_resist_software": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Player Weapon, default weapon for the player
	"Player Weapon": Item.new("Player Weapon", ElementDatabase.Element.glitch,
		[
			Effect.new({"hp": -5.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Segfault Weapon, default weapon for the Segfault
	"Segfault Weapon": Item.new("Segfault Weapon", ElementDatabase.Element.glitch,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Stack Overflow Weapon, default weapon for the Stack Overflow
	"Stack Overflow Weapon": Item.new("Stack Overflow Weapon", ElementDatabase.Element.software,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Blue Screen of Death Weapon, default weapon for the Blue Screen of Death
	"Blue Screen of Death Weapon": Item.new("Blue Screen of Death Weapon", ElementDatabase.Element.software,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Blue Screen of Death Weapon, default weapon for the Blue Screen of Death
	"Your Anus": Item.new("Your Anus", ElementDatabase.Element.software,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	),
	# Godot Fisting Weapon, default weapon for the Godot Boss
	"Godot Fisting Weapon": Item.new("Godot Fisting Weapon", ElementDatabase.Element.software,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE
	)
	
}