#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

in vec2 lmcoord;
in vec2 texCoord;
in vec4 glcolor;
in vec3 normal;
in float clipW;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightmapData;
layout(location = 2) out vec4 encodedNormal;

void main() {

	lightmapData = vec4(lmcoord, 0.0, 1.0);
	encodedNormal = vec4(normal * 0.5 + 0.5, 1.0);

	color = texture(gtexture, texCoord / clipW) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < 0.1) discard;
}