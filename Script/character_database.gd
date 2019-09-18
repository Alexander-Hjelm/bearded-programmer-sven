class_name CharacterDatabase

# Available items. Type: <String, Item>
const _characters : Dictionary = {
	# Bubba cola. A consumable that gives a +5 hp boost
	"Segfault": Character.new("Segfault", 
		{
			"Feet": "Segway"
		}
	)
}

static func get_character_by_name(name: String) -> Character:
	return _characters[name]