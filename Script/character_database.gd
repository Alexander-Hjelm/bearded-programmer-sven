class_name CharacterDatabase extends Node2D

# Available items. Type: <String, Item>
var _characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new(
		"Bearded Programmer Sven",
		"res://Scenes/Actor/Protagonists/Sven/SvenTheProgrammer.tscn",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0,
			
			"element_resist_memory": 10.0,
			"element_resist_OS": 10.0,
			"element_resist_glitch": 10.0,
			"element_resist_NONE": 0.0,
			
			"element_attack_memory": 20.0,
			"element_attack_OS": 20.0,
			"element_attack_glitch": 20.0,
			"element_attack_NONE": 100.0,
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
			"hp": 3.0,
			"mp": 5.0,
			"speed": 40.0,
			
			"element_resist_memory": 80.0,
			"element_resist_OS": 80.0,
			"element_resist_glitch": 10.0,
			
			"element_attack_memory": 0.0,
			"element_attack_OS": 0.0,
			"element_attack_glitch": 100.0
		},
		{
			"Feet": "Segway",
			"Weapon": "Segfault Weapon"
		},
		{
			"Bubba Cola": 0.2,
			"Registry Cleaner": 0.15,
			"Canary Bird": 0.15,
			"Unit Test Suite": 0.1,
			"Debugger": 0.1
		}
	),
	# Stack Overflow
	"Stack Overflow": Character.new(
		"Stack Overflow",
		"res://Scenes/Actor/Antagonists/Monsters/StackOverflow/StackOverflow.tscn",
		{
			"hp": 4.0,
			"mp": 5.0,
			"speed": 40.0,

			"element_resist_memory": 10.0,
			"element_resist_OS": 80.0,
			"element_resist_glitch": 80.0,
			
			"element_attack_memory": 100.0,
			"element_attack_OS": 0.0,
			"element_attack_glitch": 0.0
		},
		{
			"Body": "Trash Can",
			"Weapon": "Stack Overflow Weapon"
		},
		{
			"Bubba Cola": 0.2,
			"Registry Cleaner": 0.15,
			"Bugzapper": 0.15,
			"Extra RAM": 0.1,
			"BloatKiller (TM)": 0.1
		}
	),
	# Blue Screen of Death
	"Blue Screen of Death": Character.new(
		"Blue Screen of Death",
		"res://Scenes/Actor/Antagonists/Monsters/BlueScreen/BlueScreen.tscn",
		{
			"hp": 4.0,
			"mp": 5.0,
			"speed": 40.0,
			
			"element_resist_memory": 80.0,
			"element_resist_OS": 10.0,
			"element_resist_glitch": 80.0,
			
			"element_attack_memory": 0.0,
			"element_attack_OS": 100.0,
			"element_attack_glitch": 0.0
		},
		{
			"Head": "Monitor",
			"Weapon": "Blue Screen of Death Weapon"
		},
		{
			"Bubba Cola": 0.2,
			"Bugzapper": 0.15,
			"Canary Bird": 0.15,
			"Linux Virtual Machine": 0.1,
			"Distro Upgrade": 0.1
		}
	),
		# Godot Boss
	"Godot Boss": Character.new(
		"Godot Boss",
		"res://Scenes/Actor/Antagonists/Bosses/GodotBoss.tscn",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 50.0,
			
			"element_resist_memory": 55.0,
			"element_resist_OS": 55.0,
			"element_resist_glitch": 55.0,
			
			"element_attack_memory": 0.0,
			"element_attack_OS": 0.0,
			"element_attack_glitch": 100.0
		},
		{
			"Head": "Your Anus",
			"Weapon": "Godot Fisting Weapon"
		},
		{}
	)
}

# Use this when getting characters
func get_character(character_name: String) -> Character:
	return _characters[character_name].deep_copy()