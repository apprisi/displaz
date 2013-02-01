//#line 1 "points_v.glsl"
#version 130

uniform float exposure = 1.0;     //# name=Exposure; range=[0.01,10000]
uniform float contrast = 1.0;     //# name=Contrast; range=[0.01,10000]
uniform float minPointSize = 1.0;
uniform float maxPointSize = 100.0;
uniform float pointSize = 1.0;    //# name=Point Size; min=1; max=200
uniform vec3 cursorPos = vec3(0);
uniform int selector = 0;         //# Selector [-1, 100]
uniform int fileNumber = 0;
in float intensity;
in vec3 position;

flat out float pointScreenSize;
flat out vec4 pointColor;
flat out int markerShape;

void main()
{
    // Point position & size
    vec4 eyeCoord = gl_ModelViewMatrix * vec4(position,1.0);
    gl_Position = gl_ProjectionMatrix * eyeCoord;
    pointScreenSize = clamp(20.0*pointSize / (-eyeCoord.z), minPointSize, maxPointSize);
    gl_PointSize = pointScreenSize;
    // Compute vertex color
    float Y = exposure*pow(intensity/400.0, contrast);
    Y = Y / (1.0 + Y);
    pointColor = Y*vec4(1);
    if (selector == fileNumber)
        markerShape = 0;
    else
        markerShape = -1;
}
