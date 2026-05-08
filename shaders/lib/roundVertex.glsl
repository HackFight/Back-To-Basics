#define vertexSnapping // Turn on vertex snapping
#define resolution 0.2 // [0.1 0.125 0.2 0.25 0.5 1.0]

//Uniforms
uniform float viewHeight;
uniform float viewWidth;

vec4 roundToNearestPixel(vec4 vertex)
{
	vertex.xyz /= vertex.w;
	
	vertex.xy = vertex.xy * 0.5 + 0.5;
	vertex.xy *= resolution;
#ifdef vertexSnapping
	vertex.xy = vec2(floor(vertex.x * viewWidth)/viewWidth, floor(vertex.y * viewHeight)/viewHeight);
#endif
	vertex.xy = vertex.xy * 2.0 - 1.0;

	vertex.xyz *= vertex.w;

	return vertex;
}