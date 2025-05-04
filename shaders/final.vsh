#version 330 compatibility

uniform float viewWidth;
uniform float viewHeight;

out vec2 texelCoord;

void main()
{
	gl_Position = ftransform();
	vec2 texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy * 0.2;
	texelCoord = texCoord * vec2(viewWidth, viewHeight);
}