extends Node

enum sven_morph_state_types {HUMAN,SEG, SEGTV, SEGSTACK, STACK, STACKTV, TV, FULLMORPH}
var sven_current_morph_state = sven_morph_state_types.HUMAN

var has_tv = false
var has_seg = false
var has_stack = false

var sven_the_bad_programmer
var godot_boss

var you_merged_with_godot = false

var overworld_camera: Camera2D
var combat_camera: Camera2D

var overworld_player: OverworldPlayer

var combat_background: CombatBackground