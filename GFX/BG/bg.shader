shader_type canvas_item;	// 3D rendering mode

render_mode unshaded;	// Removes any effects added by Godot

// Albedo Texture channels
uniform sampler2D albedoBaseChannel : hint_albedo;

uniform vec4 colorTint1 : hint_color;
uniform vec4 colorTint2 : hint_color;

uniform float uvScrollSpeedY : hint_range(0.0,1.0,0.01);
uniform float uvSwaySpeed : hint_range(0.0,1.0,0.01);
uniform float uvSwayAmp : hint_range(0.0,1.0,0.01);
uniform float uvWaveSpeed : hint_range(0.0,0.1,0.001);
uniform float uvWaveAmp : hint_range(0.0,0.1,0.001);

void fragment()
{
	float uvSwayX = uvSwayAmp*sin(TIME*uvSwaySpeed);
	float uvWaveX = uvWaveAmp*sin(TIME*uvWaveSpeed*UV.y);
	float uvScrollY = -uvScrollSpeedY*TIME;
	vec2 uvScrolled = UV + vec2(uvSwayX + uvWaveX, uvScrollY);
	vec4 colorControl = mod(texture(albedoBaseChannel, uvScrolled) + TIME/2.0, 0.69);
	
	vec4 colorOut = mix(colorTint1, colorTint2, colorControl.r);
	
	// Final albedo color
	COLOR = colorOut.rgba;
}