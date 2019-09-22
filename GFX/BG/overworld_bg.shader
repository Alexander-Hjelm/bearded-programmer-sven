shader_type canvas_item;	// 3D rendering mode

render_mode unshaded;	// Removes any effects added by Godot

uniform sampler2D albedoBaseChannel : hint_albedo;
uniform vec4 colorTint : hint_color;

uniform float colorCycleSpeed : hint_range(0.0,1.0,0.01);

void fragment()
{
	vec4 albedoColor = texture(albedoBaseChannel, UV);
	
	vec4 colorOut = abs(colorTint * sin(TIME) * albedoColor);
	
	colorOut.a = 1.0;
	
	//colorOut = albedoColor;
	
	// Final albedo color
	COLOR = colorOut.rgba;
}