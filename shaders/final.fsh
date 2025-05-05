#version 330 compatibility

//CONSTANTS
const int DITHER_PATTERN[16] = int[]
(
    -4, 0, -3, 1,
    2, -2, 3, -1,
    -3, 1, -4, 0,
    3, -1, 2, -2
);

//Uniform
uniform sampler2D colortex0;

//In
in vec2 texelCoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main()
{
	color = texelFetch(colortex0, ivec2(texelCoord), 0);
    color.rgb = pow(color.rgb, vec3(1.0/2.2));

    int index = int(int(mod(texelCoord, 4).x) + int(mod(texelCoord, 4).y) * 4);
    float dither_value = float(DITHER_PATTERN[index]);

    color.rgb = floor((color.rgb * 255 + vec3(dither_value)) / 8) / 31;
}