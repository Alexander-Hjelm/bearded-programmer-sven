class_name Character

var _name: String

var _resource_path: String

# Base stat values, type: <string, float>
var _base_stats: Dictionary

# What items are present on the actor, by slot. Type: <String, Item>
var _item_names_by_slot: Dictionary

# Active effects, type: Effect
var _active_effects: Array

# Permenent stat value offsets, type: <String, float>
var _permanent_stat_offsets: Dictionary

func _init(name: String, resource_path: String, base_stats: Dictionary, item_names_by_slot: Dictionary):
	self._name = name
	self._resource_path = resource_path
	self._base_stats = {}
	self._permanent_stat_offsets = {}
	self._active_effects = []
	self._item_names_by_slot = item_names_by_slot
	
	# Initialize base stats
	self._base_stats["hp"] = 0.0
	self._base_stats["mp"] = 0.0
	self._base_stats["speed"] = 0.0
	
	# Add element attack and resistances
	for element in ElementDatabase.Element.keys():
		self._base_stats["element_attack_" + str(element)] = 0.0
		self._base_stats["element_resist_" + str(element)] = 0.0
	
	# Initialize any specified stats
	for stat in base_stats.keys():
		self._base_stats[stat] = base_stats[stat]

func deep_copy() -> Character:
	# Copy base stats
	var base_stats_copy: Dictionary
	for stat in base_stats_copy:
		base_stats_copy[stat] = self._base_stats[stat]
	# Copy item names
	var item_names_by_slot_copy: Dictionary
	for item_name in _item_names_by_slot:
		item_names_by_slot_copy[item_name] = _item_names_by_slot[item_name]
	return get_script().new(_name, base_stats_copy, item_names_by_slot_copy)

func tick():
	for effect in _active_effects:
		effect.tick()
		if effect.is_completed():
			_active_effects.remove(effect)

func get_name() -> String:
	return _name

func get_resource_path() -> String:
	return _resource_path

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
		if _item_names_by_slot["Weapon"] == item_name:
			continue
		var item = item_database.items[item_name]
		for effect in item.get_inflicted_effects():
			if effect.is_permanent():
				var stat_effects = effect.get_stat_effects()
				if stat_effects.has(stat):
					current_value = current_value + stat_effects[stat]
	# Add any permanent stat offsets
	if _permanent_stat_offsets.has(stat):
		current_value = current_value + _permanent_stat_offsets[stat]
	# Add any stat offsets due to effects
	for effect in _active_effects:
		var stat_effects = effect.get_stat_effects()
		if stat_effects.has(stat):
			current_value = current_value + stat_effects[stat]
	return current_value

# Add an effect
# The return value represents if the effect was positive, negative or neutral in terms of
# raising/lowering stats
# -1 = stats were primarily lowered
# 0 = nothing happened with the stats
# 1 = stats were primarily raised
func add_effect(effect: Effect, element: int, src_actor_element_attack: float) -> int:
	# Check the source actor's element damage against the target actor's element defense	
	# If the target actor's element resist is less than source actor's element attack,
	# do not apply the effect
	if src_actor_element_attack <= get_element_resist(element):
		print("The attack was deflected")
		return 0
	
	# The element factor decides how much of the incoming effect is resisted
	var element_factor: float = (src_actor_element_attack - get_element_resist(element))/100.0
	element_factor = min(element_factor, 1.0)
	element_factor = max(element_factor, 0.0)
	
	var total_stats_raised: float = 0.0
	
	# Deep copy the incoming effect and apply the element factor to it,
	# reducing any incoming stat damage
	var effect_copy = effect.deep_copy()
	var stat_effects: Dictionary = effect_copy.get_stat_effects()
	for stat in stat_effects.keys():
		if stat_effects[stat] < 0.0:
			stat_effects[stat] = stat_effects[stat] * element_factor
			
		if stat != "hp" or stat != "mp":
			total_stats_raised = total_stats_raised + stat_effects[stat]
	
	if effect_copy.is_permanent():
		for stat in effect_copy.get_stat_effects().keys():
			add_permanent_stat_offset(stat, effect_copy.get_stat_effects()[stat])
			print("The effect was added as a permanent stat offset")
	else:
		_active_effects.append(effect_copy)
		print("The effect was added (non-permanent")
	
	if total_stats_raised > 0.0:
		return 1
	elif total_stats_raised == 0:
		return 0
	else:
		return -1

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
	var weapon_name: String = _item_names_by_slot["Weapon"]
	return item_database.items[weapon_name]

func get_stat_keys() -> Array:
	return _base_stats.keys()

func get_element_attack(element: int) -> float:
	return get_current_value_for_stat("element_attack_" + str(ElementDatabase.Element.keys()[element]))

func get_element_resist(element: int) -> float:
	return get_current_value_for_stat("element_resist_" + str(ElementDatabase.Element.keys()[element]))