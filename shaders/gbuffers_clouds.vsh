#version 330 compatibility

#include "/lib/roundVertex.glsl"

out vec2 texcoord;
out vec4 glcolor;

void main() {
	gl_Position = roundToNearestPixel(ftransform());
	if (gl_Position.z > 0)
        gl_Position /= gl_Position.w;
		
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
}