varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 blur_vector;
uniform vec2 texel_size;

const float blur_steps = 20.0;
const float sigma = 0.6;

float weight(float pos) {
	return  exp(-(pos * pos) / (2.0 * sigma * sigma));
}

void main() {
	vec4 blurred_col = texture2D(gm_BaseTexture, v_vTexcoord);
	
	vec2 sample;
	float offset_L, sample_weight_D1, sample_weight_D2, sample_weight_L;
	float total_weight = 1.0;
	
	for(float offset_D1 = 1.0; offset_D1 <= blur_steps; offset_D1 += 2.0) {
		sample_weight_D1 = weight(offset_D1 / (blur_steps + 1.0));
		sample_weight_D2 = weight((offset_D1 + 1.0) / (blur_steps + 1.0));
		sample_weight_L = sample_weight_D1 + sample_weight_D2;
		total_weight = total_weight + (2.0 * sample_weight_L);
			
		offset_L = (offset_D1 * sample_weight_D1 + (offset_D1 + 1.0) * sample_weight_D2) / sample_weight_L;
			
		sample = v_vTexcoord + offset_L * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight_L;
		
		sample = v_vTexcoord - offset_L * texel_size * blur_vector;
		blurred_col += texture2D(gm_BaseTexture, sample) * sample_weight_L;
	}
	
    gl_FragColor = v_vColour * blurred_col / total_weight;
}

