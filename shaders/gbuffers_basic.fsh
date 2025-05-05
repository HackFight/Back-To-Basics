#version 330 compatibility

//Uniforms
uniform sampler2D lightmap;
uniform float alphaTestRef = 0.1;

//In
in vec2 lmcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = glcolor * texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) discard;
}