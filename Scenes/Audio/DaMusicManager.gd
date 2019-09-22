extends AudioStreamPlayer

export (AudioStream) var combat_music_1
export (AudioStream) var boss_music_1
export (AudioStream) var intro_music
export (AudioStream) var overworld_music
export (AudioStream) var encounter_SFX

onready var SFX1 = $SFX1
onready var SFX2 = $SFX2
onready var SFX3 = $SFX3

func play_combat_music_1():
	stream = combat_music_1
	play()


func play_intro_music():
	stream = intro_music
	play()


func play_overworld_music():
	stream = overworld_music
	play()


func play_boss_music():
	stream = boss_music_1
	play()


func play_encounter_sfx():
	SFX1._play_random_sfx()