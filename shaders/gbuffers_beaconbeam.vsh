#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

out vec2 texcoord;
out vec4 glcolor;
out vec3 normal;

void main() {

	vec4 vertex = ftransform();
	vertex.xyz /= vertex.w;
	vertex.xy = vertex.xy * 0.5 + 0.5;
	vertex.xy *= 0.2;
	vertex.xy = vertex.xy * 2.0 - 1.0;
	vertex.xyz *= vertex.w;
	gl_Position = vertex;
	
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
	normal = gl_NormalMatrix * gl_Normal;
	normal = mat3(gbufferModelViewInverse) * normal;
}