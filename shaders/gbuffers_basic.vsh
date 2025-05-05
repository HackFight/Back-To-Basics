#version 330 compatibility

#include "/lib/roundVertex.glsl"

//Uniforms
uniform float viewWidth;
uniform float viewHeight;

//Out
out vec2 lmcoord;
out vec4 glcolor;

void main() {
	gl_Position = gl_Position = roundToNearestPixel(ftransform(), viewWidth, viewHeight);
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}