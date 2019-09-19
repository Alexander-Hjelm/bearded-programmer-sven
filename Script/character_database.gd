class_name CharacterDatabase extends Node2D

# Available items. Type: <String, Item>
var characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new("Bearded Programmer Sven",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
		},
		{
			"Weapon": "Player Weapon"
		}
	),
	# Segfault
	"Segfault": Character.new("Segfault",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
		},
		{
			"Feet": "Segway",
			"Weapon": "Segfault Weapon"
		}
	),
	# Stack Overflow
	"Stack Overflow": Character.new("Stack Overflow",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
		},
		{
			"Body": "Trash Can",
			"Weapon": "Stack Overflow Weapon"
		}
	),
	# Blue Screen of Death
	"Blue Screen of Death": Character.new("Blue Screen of Death",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
		},
		{
			"Head": "Monitor",
			"Weapon": "Blue Screen of Death Weapon"
		}
	)
}