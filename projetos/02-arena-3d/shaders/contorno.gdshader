// Contorno estilo desenho animado pela técnica "inverted hull" (casco invertido):
// desenhamos o modelo de novo, um pouquinho inflado e só com as faces de TRÁS,
// numa cor sólida. O que "sobra" para fora do modelo original vira o contorno.
// Use como "Next Pass" do material principal. Lição: trilha-godot/14-shaders.md
shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 cor_contorno : source_color = vec4(0.08, 0.05, 0.12, 1.0);
uniform float espessura : hint_range(0.0, 0.1) = 0.025;

// vertex(): roda para cada vértice. Empurramos o vértice na direção da normal.
void vertex() {
	VERTEX += NORMAL * espessura;
}

void fragment() {
	ALBEDO = cor_contorno.rgb;
}
