class_name CombatBackground extends Node2D

export(Array, Color) var random_colors_1
export(Array, Color) var random_colors_2
export(Array, Texture) var random_textures
export(Texture) var boss_texture

func _ready():
	Global.combat_background = self

func randomize_color_and_texture():
	randomize()
	var r_col: int = randi()%len(random_colors_1)
	var r_tex: int = randi()%len(random_textures)
	
	var color1: Color = random_colors_1[r_col]
	var color2: Color = random_colors_2[r_col]
	var texture: Texture = random_textures[r_tex]
	
	material.set_shader_param("colorTint1", color1)
	material.set_shader_param("colorTint2", color2)
	material.set_shader_param("albedoBaseChannel", texture)

func set_boss_background():
	material.set_shader_param("colorTint1", Color(0.2, 0.0, 0.0))
	material.set_shader_param("colorTint2", Color(0.4, 0.0, 0.0))
	material.set_shader_param("albedoBaseChannel", boss_texture)