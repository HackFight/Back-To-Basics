#version 330 compatibility

#define resolution 0.2 // [0.2 0.25 0.5 1.0]

//Uniforms
uniform float viewWidth;
uniform float viewHeight;

//Out
out vec2 texelCoord;
out vec3 viewSpaceFragPos;

void main()
{
	gl_Position = ftransform();
	vec2 texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy * resolution;
	texelCoord = texCoord * vec2(viewWidth, viewHeight);
}