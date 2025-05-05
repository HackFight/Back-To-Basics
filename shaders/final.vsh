#version 330 compatibility

//Uniforms
uniform float viewWidth;
uniform float viewHeight;

//Out
out vec2 texelCoord;

void main()
{
	gl_Position = ftransform();
	vec2 texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy * 0.2;
	texelCoord = texCoord * vec2(viewWidth, viewHeight);
}