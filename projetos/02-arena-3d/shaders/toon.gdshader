// Toon shading (cel shading): a luz vira "faixas" em vez de um degradê suave.
// Combina muito com low poly. Lição: trilha-godot/14-shaders.md
shader_type spatial;

// Os "uniforms" aparecem no Inspector do material, como @export no GDScript.
uniform vec4 cor : source_color = vec4(1.0, 0.55, 0.25, 1.0);
uniform sampler2D textura : source_color, filter_nearest, hint_default_white; // pixel art nítida
uniform int faixas : hint_range(1, 6) = 3;                 // quantos "degraus" de luz
uniform vec4 cor_sombra : source_color = vec4(0.45, 0.4, 0.65, 1.0); // sombra arroxeada fica mais viva que cinza
uniform float brilho_borda : hint_range(0.0, 1.0) = 0.25;  // rim light: contorno claro do lado iluminado

// fragment(): roda para cada pixel do objeto. Define a cor "base" (albedo).
void fragment() {
	ALBEDO = cor.rgb * texture(textura, UV).rgb;
}

// light(): roda para cada pixel E para cada luz. Aqui trocamos o cálculo padrão.
void light() {
	// dot(NORMAL, LIGHT): 1 = superfície de frente para a luz, 0 = de lado, <0 = de costas
	float luz = clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION; // ATTENUATION inclui as sombras
	// "Quantiza" a luz em faixas: 0.0, 0.5, 1.0... em vez de valores contínuos
	float degrau = floor(luz * float(faixas) + 0.5) / float(faixas);
	vec3 tom = mix(cor_sombra.rgb, vec3(1.0), degrau);
	// Rim light: realça a borda (onde a normal fica perpendicular à câmera)
	float borda = pow(1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0), 4.0);
	tom += step(0.5, borda) * brilho_borda * degrau;
	DIFFUSE_LIGHT += tom * LIGHT_COLOR / PI;
}
