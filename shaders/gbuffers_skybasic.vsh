#version 330 compatibility

#include "/lib/roundVertex.glsl"

out vec4 glcolor;

void main() {
	gl_Position = roundToNearestPixel(ftransform());
	glcolor = gl_Color;
}
