class_name CharacterDatabase extends Node2D

# Available items. Type: <String, Item>
var characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new("Bearded Programmer Sven",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_resist_glitch": 10.0,
			"element_attack_glitch": 100.0
		},
		{
			"Weapon": "Player Weapon"
		}
	),
	# Segfault
	"Segfault": Character.new("Segfault",
		{
			"hp": 13.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_resist_glitch": 1.0,
			"element_attack_glitch": 5.0
		},
		{
			"Feet": "Segway",
			"Weapon": "Segfault Weapon"
		}
	),
	# Stack Overflow
	"Stack Overflow": Character.new("Stack Overflow",
		{
			"hp": 14.0,
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
			"hp": 15.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_attack_glitch": 100.0
		},
		{
			"Head": "Monitor",
			"Weapon": "Blue Screen of Death Weapon"
		}
	)
}