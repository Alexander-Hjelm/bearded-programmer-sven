class_name Character

var _name: String

# Base stat values, type: <string, float>
var _base_stats: Dictionary

# What items are present on the actor, by slot. Type: <String, Item>
var _item_names_by_slot: Dictionary

# Active effects, type: Effect
var _active_effects: Array

# Permenent stat value offsets, type: <String, float>
var _permanent_stat_offsets: Dictionary

func _init(name: String, base_stats: Dictionary, item_names_by_slot: Dictionary):
	_name = name
	_item_names_by_slot = item_names_by_slot
	
	# Initialize base stats
	_base_stats["hp"] = 0.0
	_base_stats["mp"] = 0.0
	_base_stats["speed"] = 0.0
	
	# Add element attack and resistances
	for element in ElementDatabase.Element.values():
		_base_stats["element_attack_" + element] = 0.0
		_base_stats["element_resist_" + element] = 0.0
	
	# Initialize any specified stats
	for stat in base_stats.keys():
		_base_stats[stat] = base_stats[stat]

func deep_copy() -> Character:
	# Copy base stats
	var base_stats_copy: Dictionary
	for stat in base_stats_copy:
		base_stats_copy[stat] = _base_stats[stat]
	# Copy item names
	var item_names_by_slot_copy: Dictionary
	for item_name in _item_names_by_slot:
		item_names_by_slot_copy[item_name] = _item_names_by_slot[item_name]
	return Character.new(_name, base_stats_copy, item_names_by_slot_copy)

func tick():
	for effect in _active_effects:
		effect.tick()
		if effect.is_completed():
			_active_effects.remove(effect)

# Get the base value of a stat
func get_base_value_for_stat(stat: String):
	# first make sure that the base stat exists on the character
	if not _base_stats.has(stat):
		_base_stats[stat] = 0.0
	return _base_stats[stat]

# Get the current value of a stat, adjusted for any effects
func get_current_value_for_stat(stat: String) -> float:
	# first make sure that the base stat exists on the character
	if not _base_stats.has(stat):
		_base_stats[stat] = 0.0
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

func add_effect(effect: Effect, src_actor_element_attack: float):
	var element: int = effect.get_element()

	# Check the source actor's element damage against the target actor's element defense	
	# If the target actor's element resist is less than source actor's element attack,
	# do not apply the effect
	if src_actor_element_attack <= get_element_resist(element):
		return
	
	# The element factor decides how much of the incoming effect is resisted
	var element_factor: float = (src_actor_element_attack - get_element_resist(element))/100
	element_factor = max(element_factor, 1.0)
	element_factor = min(element_factor, 0.0)
	
	# Deep copy the incoming effect and apply the element factor to it,
	# reducing any incoming stat damage
	var effect_copy = effect.deep_copy()
	var stat_effects: Dictionary = effect_copy.get_stat_effects()
	for stat in stat_effects.keys():
		if stat_effects[stat] < 0.0:
			stat_effects[stat] = stat_effects[stat] * element_factor
	
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

func get_weapon() -> Item:
	# TODO: Implement

func get_element_attack(element: int) -> float:
	return get_current_value_for_stat("element_attack_" + ElementDatabase.Element.values()[element])
	
func get_element_resist(element: int) -> float:
	return get_current_value_for_stat("element_resist_" + ElementDatabase.Element.values()[element])