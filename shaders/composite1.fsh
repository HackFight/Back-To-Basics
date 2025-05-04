#version 330 compatibility

/*
const int colortex0Format = RGB16;
*/

//CONSTANTS
#define FOG_DENSITY 6.0

//Uniforms
uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform mat4 gbufferProjectionInverse;
uniform float far;
uniform vec3 fogColor;

//In
in vec2 texCoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

//Functions
vec3 projectAndDivide(mat4 projectionMatrix, vec3 position){
  vec4 homPos = projectionMatrix * vec4(position, 1.0);
  return homPos.xyz / homPos.w;
}

void main()
{
    color = texture(colortex0, texCoord);

    float depth = texture(depthtex0, texCoord).r;
    if(depth == 1.0) return;

    vec3 NDCPos = vec3(texCoord, depth) * 2.0 - 1.0;
    vec3 viewPos = projectAndDivide(gbufferProjectionInverse, NDCPos);
    
    /*
    float dist = length(viewPos) / far;
    float fogFactor = exp(-FOG_DENSITY * (1.0 - dist));
    
    color.rgb = mix(color.rgb, fogColor, clamp(fogFactor, 0.0, 1.0));
    */

    color.rgb = mix(color.rgb, pow(fogColor, vec3(2.2)), length(viewPos)/far);
}