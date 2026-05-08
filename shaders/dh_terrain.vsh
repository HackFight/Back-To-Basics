#version 330 compatibility

#include "/lib/roundVertex.glsl"

uniform sampler2D dhDepthTex0;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 viewSpaceFragPos;

void main() {

	vec4 vertex = ftransform();

	vertex.xyz /= vertex.w;
	
	vertex.xy = vertex.xy * 0.5 + 0.5;
	vertex.xy *= resolution;
	vertex.xy = vertex.xy * 2.0 - 1.0;

	vertex.xyz *= vertex.w;

	gl_Position = vertex;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	viewSpaceFragPos = (gl_ModelViewMatrix * gl_Vertex).xyz;
}