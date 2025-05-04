#version 330 compatibility

#include /lib/roundVertex.glsl

//CONSTANTS
const float VERTEX_POS_IMPRECISION = 0.1;

//Uniforms
uniform mat4 gbufferModelViewInverse;
uniform float viewWidth;
uniform float viewHeight;

//Out
out vec2 lmcoord;
out vec2 texCoord;
out vec4 glcolor;
out vec3 normal;
out float clipW;

void main() {

	vec4 clipVertex = roundToNearestPixel(ftransform(), viewWidth, viewHeight);
	clipW = clipVertex.w;

	gl_Position = clipVertex;
	texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy * clipW ;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal;
	normal = mat3(gbufferModelViewInverse) * normal;
}