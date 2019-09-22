class_name ItemDatabase extends Node2D

# Available items. Type: <String, Item>
var items : Dictionary = {
	### CONSUMABLES ###
	# Bubba cola. A consumable that gives a +5 hp boost
	"Bubba Cola": Item.new("Bubba Cola", ElementDatabase.Element.NONE,
		[
			Effect.new({"hp": 5.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"Restores +5 hp. A small can of fizz that will keep you going through the night."
	),
	# Extra RAM
	"Extra RAM": Item.new("Extra RAM", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_resist_memory": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises resistance against memory eneimes by +10. Now you can stream twice as much hent... sorry, anime! ... sorry, web series"
	),
	# Linux Virtual Machine
	"Linux Virtual Machine": Item.new("Linux Virtual Machine", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_resist_OS": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises resistance against OS eneimes by +10. Let's do your work in a protected enivronment!"
	),
	# Unit Test Suite
	"Unit Test Suite": Item.new("Unit Test Suite", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_resist_glitch": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises resistance against glitch eneimes by +10. The more the merrier!"
	),
	# BloatKiller (TM)
	"BloatKiller (TM)": Item.new("BloatKiller (TM)", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_attack_memory": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises attack power against memory eneimes by +10. BloatKiller is a registered 10/10-stars app and totally not a scam!"
	),
	# Distro Upgrade
	"Distro Upgrade": Item.new("Distro Upgrade", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_attack_OS": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises attack power against OS eneimes by +10. Next install Gentoo! Huehuehuehue..."
	),
	# Debugger
	"Debugger": Item.new("Debugger", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_attack_glitch": 10.0}, true, 0)
		],
		Item.ItemType.CONSUMABLE,
		"PERMANENTLY raises attack power against glitch eneimes by +10. But only if you can figure out the compile flags."
	),
	### OFFENSIVE ###
	# Canary bird. 
	"Canary Bird": Item.new("Canary Bird", ElementDatabase.Element.memory,
		[
			Effect.new({"hp": -5.0}, true, 0)
		],
		Item.ItemType.OFFENSIVE,
		"Does extra damage to Memory enemies. SQUAWK SQUAWK!."
	),
	# Registry cleaner. 
	"Registry Cleaner": Item.new("Registry Cleaner", ElementDatabase.Element.OS,
		[
			Effect.new({"hp": -5.0}, true, 0)
		],
		Item.ItemType.OFFENSIVE,
		"Does extra damage to OS enemies. A portable Roomba that sucks you regfiles squeaky clean!"
	),
	# Registry cleaner. 
	"Bugzapper": Item.new("Bugzapper", ElementDatabase.Element.glitch,
		[
			Effect.new({"hp": -5.0}, true, 0)
		],
		Item.ItemType.OFFENSIVE,
		"Does extra damage to glitch enemies. Zip Zap ZoppidyBap!"
	),
	### CHARACTER EQUIPPABLES ###
	# Segway, feet item used by the segfault
	"Segway": Item.new("Segway", ElementDatabase.Element.glitch,
		[
			Effect.new({"speed": 20}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Trash Can, body item used by the Stack Overflow
	"Trash Can": Item.new("Trash Can", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_resist_memory": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Monitor, head item used by the Blue Screen of Death
	"Monitor": Item.new("Monitor", ElementDatabase.Element.NONE,
		[
			Effect.new({"element_resist_OS": 20.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Player Weapon, default weapon for the player
	"Player Weapon": Item.new("Player Weapon", ElementDatabase.Element.NONE,
		[
			Effect.new({"hp": -5.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Segfault Weapon, default weapon for the Segfault
	"Segfault Weapon": Item.new("Segfault Weapon", ElementDatabase.Element.glitch,
		[
			Effect.new({"hp": -1.4}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Stack Overflow Weapon, default weapon for the Stack Overflow
	"Stack Overflow Weapon": Item.new("Stack Overflow Weapon", ElementDatabase.Element.memory,
		[
			Effect.new({"hp": -1.8}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Blue Screen of Death Weapon, default weapon for the Blue Screen of Death
	"Blue Screen of Death Weapon": Item.new("Blue Screen of Death Weapon", ElementDatabase.Element.OS,
		[
			Effect.new({"hp": -1.8}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Blue Screen of Death Weapon, default weapon for the Blue Screen of Death
	"Your Anus": Item.new("Your Anus", ElementDatabase.Element.NONE,
		[
			Effect.new({"hp": -1.0}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	),
	# Godot Fisting Weapon, default weapon for the Godot Boss
	"Godot Fisting Weapon": Item.new("Godot Fisting Weapon", ElementDatabase.Element.glitch,
		[
			Effect.new({"speed": 10}, true, 0)
		],
		Item.ItemType.EQUIPPABLE,
		""
	)
	
}