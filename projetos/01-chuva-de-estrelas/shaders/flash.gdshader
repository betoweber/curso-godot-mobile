// Flash de dano: mistura a cor do sprite com uma cor sólida (normalmente branco).
// O script anima "intensidade" de 1 para 0 com um Tween. Lição: trilha-godot/14-shaders.md
shader_type canvas_item;

uniform vec4 cor_flash : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float intensidade : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	// COLOR já vem com a cor do sprite/polígono. Mantemos o alfa (transparência) original.
	COLOR.rgb = mix(COLOR.rgb, cor_flash.rgb, intensidade);
}
