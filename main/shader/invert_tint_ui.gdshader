shader_type canvas_item;

uniform vec4 cover_color: hint_color = vec4(0.0);

void fragment() {
	float ir = (1.0 - textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).r);
	COLOR = cover_color * vec4(ir, ir, ir, texture(TEXTURE, UV).a);
}