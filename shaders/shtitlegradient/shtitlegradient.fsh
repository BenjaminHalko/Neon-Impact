varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uvDimensions;
uniform float shift;

void main() {
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	float hue = abs(1.0 - fract(shift + (v_vTexcoord.x + v_vTexcoord.y) / (uvDimensions.x + uvDimensions.y) / 2.5) * 2.0) * 2.0;
    gl_FragColor.rgb *= vec3(0.0,smoothstep(0.0,1.0,min(2.0-hue,1.0)),smoothstep(0.0,1.0,min(hue,1.0)));
}