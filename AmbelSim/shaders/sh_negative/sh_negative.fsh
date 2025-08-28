varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 _r;

void main()
{
	_r = texture2D( gm_BaseTexture, v_vTexcoord );
	
    gl_FragColor = vec4(vec3(1.0, 1.0, 1.0) - _r.xyz, _r.w*v_vColour.w);
}
