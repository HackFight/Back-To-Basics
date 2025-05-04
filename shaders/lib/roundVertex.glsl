vec4 roundToNearestPixel(vec4 vertex, float viewWidth, float viewHeight)
{
	vertex.xyz /= vertex.w;
	
	vertex.xy = vertex.xy * 0.5 + 0.5;
	vertex.xy *= 0.2;
	vertex.xy = vertex.xy * 2.0 - 1.0;

	vertex.xy = vec2(floor(vertex.x * viewWidth * 0.2 + 0.5)/(viewWidth * 0.2), floor(vertex.y * viewHeight * 0.2 + 0.5)/(viewHeight * 0.2));
	vertex.xyz *= vertex.w;

	return vertex;
}