//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D bloom_texture;

const float bloom_intensity = 0.9;
const float bloom_darken = 0.55;

void main()
{
	vec4 base_col = texture2D( gm_BaseTexture, v_vTexcoord );
	vec3 bloom_col = texture2D( bloom_texture, v_vTexcoord ).rgb;
	
	/// add (linear dodge):
	base_col.rgb = base_col.rgb * bloom_darken + bloom_col * bloom_intensity;
	
    gl_FragColor = v_vColour * base_col;
}
