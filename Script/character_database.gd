class_name CharacterDatabase

# Available items. Type: <String, Item>
var _characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new("Bearded Programmer Sven", {}),
	# Segfault
	"Segfault": Character.new("Segfault",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 1.0
		},
		{
			"Feet": "Segway"
		}
	),
	# Stack Overflow
	"Stack Overflow": Character.new("Stack Overflow",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 1.0
		},
		{
			"Body": "Trash can"
		}
	),
	# Blue Screen of Death
	"Blue Screen of Death": Character.new("Blue Screen of Death",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 1.0
		},
		{
			"Head": "Monitor"
		}
	)
}

static func get_character_by_name(name: String) -> Character:
	return _characters[name]