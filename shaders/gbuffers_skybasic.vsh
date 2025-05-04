#version 330 compatibility

out vec4 glcolor;

void main() {
	
	vec4 vertex = ftransform();
	vertex.xyz /= vertex.w;
	vertex.xy = vertex.xy * 0.5 + 0.5;
	vertex.xy *= 0.2;
	vertex.xy = vertex.xy * 2.0 - 1.0;
	vertex.xyz *= vertex.w;
	gl_Position = vertex;
	
	glcolor = gl_Color;
}
