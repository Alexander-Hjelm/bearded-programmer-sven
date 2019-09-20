class_name Item

enum ItemType{
  EQUIPPABLE,
  CONSUMABLE,
  OFFENSIVE
}

# Unique name identifier
var _name: String

var _element: int

var _item_type: int

# inflicted effects, type: Effect
var _inflicted_effects: Array

func _init(name: String, element: int, inflicted_effects: Array, item_type: int):
	self._name = name
	self._element = element
	self._inflicted_effects = inflicted_effects
	self._item_type = item_type

func get_inflicted_effects():
	return _inflicted_effects

func get_element() -> int:
	return _element