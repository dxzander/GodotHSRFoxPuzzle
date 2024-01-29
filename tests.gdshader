shader_type spatial;
render_mode blend_mix, cull_disabled;

uniform vec4 top : source_color  = vec4( 1.0, 1.0, 0.0, 0.0 );
uniform vec4 bot : source_color  = vec4( 1.0, 1.0, 0.0, 0.25 );
varying vec3 local_vertex;

void vertex() {
	// Called for every vertex the material is visible on.
	//local_vertex = ( VIEW_MATRIX * vec4( VERTEX, 1.0 ) ).xyz;
	local_vertex = VERTEX;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = mix(top, bot, -local_vertex.y+0.5).rgb;
	ALPHA = abs(mix(top, bot, -local_vertex.y+0.5).a*sin(TIME))*0.8+0.01;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
