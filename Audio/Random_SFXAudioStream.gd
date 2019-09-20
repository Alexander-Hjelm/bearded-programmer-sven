extends AudioStreamPlayer

export (AudioStream) var sfx_1
export (AudioStream) var sfx_2
export (AudioStream) var sfx_3
export (AudioStream) var sfx_4
export (AudioStream) var sfx_5
export (AudioStream) var sfx_6
export (AudioStream) var sfx_7
export (AudioStream) var sfx_8
export (AudioStream) var sfx_9
export (AudioStream) var sfx_10
export (AudioStream) var sfx_11
export (AudioStream) var sfx_12
export (AudioStream) var sfx_13
export (AudioStream) var sfx_14
export (AudioStream) var sfx_15
export (AudioStream) var sfx_16

export var random_sfx_to_play = 3

func _play_random_sfx():
	var random_sfx = randi() % random_sfx_to_play + 1
	
	match random_sfx:
		1: stream = sfx_1
		2: stream = sfx_2
		3: stream = sfx_3
		4: stream = sfx_4
		5: stream = sfx_5
		6: stream = sfx_6
		7: stream = sfx_7
		8: stream = sfx_8
		9: stream = sfx_9
		10: stream = sfx_10
		11: stream = sfx_11
		12: stream = sfx_12
		13: stream = sfx_13
		14: stream = sfx_14
		15: stream = sfx_15
		16: stream = sfx_16
	
	play()