shader_type canvas_item;

// mipmap is neaded for textureLod
uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest_mipmap;

uniform sampler2D noise;

uniform float found_items = 30.0;

void fragment() {
    vec4 screen_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	vec4 dark_texture = vec4(0,0,0, 1);
	COLOR =  mix(screen_color, dark_texture, 0.01*found_items);
	//COLOR = screen_color + noise_color;
}