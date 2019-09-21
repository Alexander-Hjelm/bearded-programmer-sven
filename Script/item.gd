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

var _description: String

# inflicted effects, type: Effect
var _inflicted_effects: Array

func _init(name: String, element: int, inflicted_effects: Array, item_type: int, description: String):
	self._name = name
	self._element = element
	self._inflicted_effects = inflicted_effects
	self._item_type = item_type
	self._description = description

func get_inflicted_effects():
	return _inflicted_effects

func get_element() -> int:
	return _element

func get_item_type() -> int:
	return _item_type

func get_description() -> String:
	return _description