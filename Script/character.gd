class_name Character extends StatNode

var _name: String

# Base stat values, type: <string, float>
var _base_stats: Dictionary

# What items are present on the actor, by slot. Type: <String, Item>
var _item_names_by_slot: Dictionary

# Active effects, type: Effect
var _active_effects: Array

# Permenent stat value offsets, type: <String, float>
var _permanent_stat_offsets: Dictionary

func _init(name: String, item_names_by_slot: Dictionary):
	_name = name
	_item_names_by_slot = item_names_by_slot

func deep_copy() -> Character:
	var item_names_by_slot_copy: Dictionary
	for item_name in _item_names_by_slot:
		item_names_by_slot_copy[item_name] = _item_names_by_slot[item_name]
	return Character.new(_name, item_names_by_slot_copy)

func tick():
	for effect in _active_effects:
		effect.tick()
		if effect.is_completed():
			_active_effects.remove(effect)

# Get the base value of a stat
func get_base_value_for_stat(stat: String):
	return _base_stats[stat]

# Get the current value of a stat, adjusted for any effects
func get_current_value_for_stat(stat: String):
	var current_value: float = _base_stats[stat]
	# Add any stat offsets due to equipped items
	for item_name in _item_names_by_slot.values():
		var item = ItemDatabase.get_item_by_name(item_name)
		for effect in item.get_inflicted_effects():
			if effect.is_permanent():
				var stat_effects = effect.get_stat_effects()
				if stat_effects.has_key(stat):
					current_value = current_value + stat_effects[stat]
	# Add any permanent stat offsets
	if _permanent_stat_offsets.has(stat):
		current_value = current_value + _permanent_stat_offsets[stat]
	# Add any stat offsets due to effects
	for effect in _active_effects:
		var stat_effects = effect.get_stat_effects()
		if stat_effects.has_key(stat):
			current_value = current_value + stat_effects[stat]
	return current_value

func add_effect(effect: Effect):
	if effect.is_permanent():
		for stat in effect.get_stat_effects().keys():
			add_permanent_stat_offset(stat, effect.get_stat_effects()[stat])
	else:
		_active_effects.append(effect)

func add_permanent_stat_offset(stat: String, value: float):
	if _permanent_stat_offsets.has(stat):
		_permanent_stat_offsets[stat] = _permanent_stat_offsets[stat] + value
	else:
		_permanent_stat_offsets[stat] = value
	
	# Treat hp and mp separately, since these two should never go beyond their maximum
	# If any of these stats have a positive permanent offset, set it to 0 again
	if stat == "hp" or stat == "mp":
		if _permanent_stat_offsets[stat] > 0:
			_permanent_stat_offsets[stat] = 0
	