class_name Effect

# A dictionary representing which stats are affected and by how much. Can be positive or negative
# Type: <string, float>
var _stat_effects: Dictionary
# How many turns this stat should be active for
var _time: int
# Is the effect permanent?
var _permanent: bool

func _init(stat_effects: Dictionary, permanent: bool, time: int):
	self._stat_effects = stat_effects
	self._time = time

func tick():
	_time = _time - 1

func is_completed() -> bool:
	return _time > 0

func get_stat_effects() -> Dictionary:
	return _stat_effects

func is_permanent() -> bool:
	return _permanent