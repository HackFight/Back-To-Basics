#version 330 compatibility

#include "/lib/roundVertex.glsl"

uniform float viewWidth;
uniform float viewHeight;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;

void main() {
	gl_Position = roundToNearestPixel(ftransform(), viewWidth, viewHeight);
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}