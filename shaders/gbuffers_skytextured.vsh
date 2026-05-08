#version 330 compatibility

#include "/lib/roundVertex.glsl"

out vec2 texcoord;
out vec4 glcolor;

void main() {
	gl_Position = roundToNearestPixel(ftransform());
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}