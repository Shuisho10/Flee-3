shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float transparency = SCREEN_UV.x;
	COLOR = vec4(COLOR.xyz,min(COLOR.a,transparency));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
