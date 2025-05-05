#version 330 compatibility

/*
const int colortex0Format = RGB16;
*/

//Uniforms
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform mat4 gbufferModelViewInverse;
uniform vec3 shadowLightPosition;
uniform int worldTime;

//In
in vec2 texCoord;

//CONSTANTS
const vec3 blocklightColor = vec3(1.0, 0.5, 0.08);
const vec3 sunlightColor = vec3(1.0);
const vec3 ambientColor = vec3(0.1);

//Variables
vec3 skylightColor = vec3(0.05, 0.15, 0.3);

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main()
{
    color = texture(colortex0, texCoord);
    color.rgb = pow(color.rgb, vec3(2.2));

    vec2 lightmap = texture(colortex1, texCoord).rg;
    vec3 encodedNormal = texture(colortex2, texCoord).rgb;
    vec3 normal = normalize((encodedNormal - 0.5) * 2.0);

    vec3 blocklight = lightmap.r * blocklightColor;

    if(13500 < worldTime && worldTime < 22800) skylightColor = vec3(0.0, 0.0, 0.0);
    else skylightColor = vec3(0.05, 0.15, 0.3);
    vec3 skylight = lightmap.g * skylightColor;
    vec3 ambient = ambientColor;
    vec3 sunLightVector = normalize(shadowLightPosition);
    vec3 worldSunLightVector = mat3(gbufferModelViewInverse) * sunLightVector;
    vec3 sunlight = sunlightColor * clamp(dot(worldSunLightVector, normal), 0.0, 1.0) * lightmap.g;

    float depth = texture(depthtex0, texCoord).r;
    if (depth == 1.0) return;
    
    color.rgb *= blocklight + skylight + ambient + sunlight;
}