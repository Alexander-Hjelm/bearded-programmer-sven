extends Node2D

var DIRECTION_RIGHT = 1
var DIRECTION_LEFT = -1
var direction = Vector2(DIRECTION_RIGHT, 1)


func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT # default to right if param is 0
	var hor_dir_mod = hor_direction / abs(hor_direction) # get unit direction
	apply_scale(Vector2(hor_dir_mod * direction.x, 1)) # flip
	direction = Vector2(hor_dir_mod, direction.y) # update direction