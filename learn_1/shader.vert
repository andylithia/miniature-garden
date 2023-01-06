#version 330 core
layout (location = 0) in vec3 aPos; // the position variable has attribute position 0
layout (location = 2) in vec2 aTexCoord;

noperspective out vec2 TexCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{

    // gl_Position = projection * view * model * vec4(aPos, 1.0f); // see how we directly give a vec3 to vec4's constructor
    vec4 vertInClipSpace = projection * view * model * vec4(aPos, 1.0f); // see how we directly give a vec3 to vec4's constructor
    vec2 grid = vec2(160,120) * 0.5;
    vec4 snapped = vertInClipSpace;
    snapped.xyz = vertInClipSpace.xyz / vertInClipSpace.w;
    snapped.xy = floor(grid * snapped.xy) / grid;  // This is actual grid
    snapped.xyz *= vertInClipSpace.w;
    gl_Position = snapped;
    TexCoord = aTexCoord;
}