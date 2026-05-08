#version 330 compatibility

#define resolution 0.2 // [0.1 0.125 0.2 0.25 0.5 1.0]

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;
uniform sampler2D depthtex0;
uniform float viewWidth;
uniform float viewHeight;

uniform vec3 fogColor;
uniform int dhRenderDistance;
uniform float far;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 viewSpaceFragPos;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	if (gl_FragCoord.y/viewHeight > resolution || gl_FragCoord.x/viewWidth > resolution) discard;

	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}

	float depth = texture(depthtex0, gl_FragCoord.xy / vec2(viewWidth, viewHeight)).r;
    if(depth != 1.0) {
        discard;
    }

	float distanceFromCam = distance(vec3(0), viewSpaceFragPos);
    float fogBlend = clamp((distanceFromCam - far)/(dhRenderDistance - far), 0, 1);
    color.rgb = mix(color.rgb, fogColor, fogBlend);
}