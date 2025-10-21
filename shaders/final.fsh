#version 330 compatibility

#define dithering // Turn on dithering
#define lessColors // Use 16-bit colors

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

#ifdef dithering
    float dither_value = float(DITHER_PATTERN[index]);
#ifdef lessColors
    color.rgb = floor((color.rgb * 255 + vec3(dither_value)) / 8) / 31;
#else
    color.rgb = floor(color.rgb * 255 + vec3(dither_value)) / 255;
#endif
#endif
#ifndef dithering
#ifdef lessColors
    color.rgb = floor((color.rgb * 255) / 8) / 31;
#else
    color.rgb = floor(color.rgb * 255) / 255;
#endif
#endif
}