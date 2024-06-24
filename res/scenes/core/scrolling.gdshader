shader_type canvas_item;
uniform vec2 speed = vec2(1.0,0);
uniform float scrolled = 0.;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = texture(TEXTURE, mod(UV + speed*scrolled,1.0));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
