class_name CharacterDatabase extends Node2D

# Available items. Type: <String, Item>
var characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new(
		"Bearded Programmer Sven",
		"res://Scenes/Actor/Protagonists/Sven/SvenTheProgrammer.tscn",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_resist_glitch": 10.0,
			"element_attack_glitch": 100.0,
		},
		{
			"Weapon": "Player Weapon"
		},
		{}
	),
	# Segfault
	"Segfault": Character.new(
		"Segfault",
		"res://Scenes/Actor/Antagonists/Monsters/SegFault/SegFault.tscn",
		{
			"hp": 6.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_resist_glitch": 1.0,
			"element_attack_glitch": 5.0
		},
		{
			"Feet": "Segway",
			"Weapon": "Segfault Weapon"
		},
		{"Bubba Cola": 1.0}
	),
	# Stack Overflow
	"Stack Overflow": Character.new(
		"Stack Overflow",
		"res://Scenes/Actor/Antagonists/Monsters/StackOverflow/StackOverflow.tscn",
		{
			"hp": 7.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_resist_glitch": 2.0
		},
		{
			"Body": "Trash Can",
			"Weapon": "Stack Overflow Weapon"
		},
		{}
	),
	# Blue Screen of Death
	"Blue Screen of Death": Character.new(
		"Blue Screen of Death",
		"res://Scenes/Actor/Antagonists/Monsters/BlueScreen/BlueScreen.tscn",
		{
			"hp": 8.0,
			"mp": 5.0,
			"speed": 40.0,
			"element_attack_glitch": 100.0,
			"element_resist_glitch": 3.0
		},
		{
			"Head": "Monitor",
			"Weapon": "Blue Screen of Death Weapon"
		},
		{}
	),
		# Godot Boss
	"Godot Boss": Character.new(
		"Godot Boss",
		"res://Scenes/Actor/Antagonists/Bosses/GodotBoss.tscn",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 50.0,
			"element_attack_glitch": 100.0,
			"element_resist_glitch": 3.0
		},
		{
			"Head": "Your Anus",
			"Weapon": "Godot Fisting Weapon"
		},
		{}
	)
}