class_name CharacterDatabase

# Available items. Type: <String, Item>
var _characters : Dictionary = {
	# Bearded Programmer Sven
	"Bearded Programmer Sven": Character.new("Bearded Programmer Sven",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
		},
		{}
	),
	# Segfault
	"Segfault": Character.new("Segfault",
		{
			"hp": 20.0,
			"mp": 5.0,
			"speed": 40.0
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
			"speed": 40.0
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
			"speed": 40.0
		},
		{
			"Head": "Monitor"
		}
	)
}

static func get_character_by_name(name: String) -> Character:
	return _characters[name]