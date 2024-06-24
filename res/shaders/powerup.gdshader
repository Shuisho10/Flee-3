shader_type canvas_item;

uniform vec4 chroma_color:source_color;
uniform vec4 color1:source_color;
uniform vec4 color2:source_color;
uniform vec2 direction;
uniform float wave_scale;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 cc=texture(TEXTURE,UV);
	vec4 bgc=mix(color1,color2,sin((dot(SCREEN_UV.xy,direction)-TIME/10.)*wave_scale));
	
	if(cc==chroma_color)
	 COLOR= bgc;
	else
	 COLOR = cc;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
