#version 330 compatibility

#include "/lib/roundVertex.glsl"

//Uniforms
uniform mat4 gbufferModelViewInverse;
uniform float viewWidth;
uniform float viewHeight;

//Out
out vec2 lmcoord;
out vec2 texCoord;
out vec4 glcolor;
out vec3 normal;

void main() {

	vec4 clipVertex = roundToNearestPixel(ftransform(), viewWidth, viewHeight);

	gl_Position = clipVertex;
#ifdef vertexSnapping
	if (gl_Position.z > 0)
        gl_Position /= gl_Position.w;
#endif

	texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal;
	normal = mat3(gbufferModelViewInverse) * normal;
}