#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float PI;

vec3 colorA = vec3(0.149,0.141,0.912);
vec3 colorB = vec3(1.000,0.833,0.224);

float plot(vec2 pixel_coordinate, float edge, float offset, float scaling){
    // the plot function
    float graph_point = (pixel_coordinate.y + offset) * scaling;
    return smoothstep(edge-0.01, edge, graph_point) - 
           smoothstep(edge, edge+0.01, graph_point);
}

float axis(vec2 pixel_coordinate, float offset){    
    return step(abs(offset) - 0.001, pixel_coordinate.y) * 
           step(pixel_coordinate.y, abs(offset) + 0.001);
}

vec3 horizontal_color(float y, vec2 st){
    // the gradiant color based on the value of Y
    vec3 col = vec3(y);
    float graph_offset = -0.0;
    float graph_scaling = 1.0;

    // plot the gradiant color as a green line using our plot function    
    
    float plotted = plot(st, y, graph_offset, graph_scaling);
    float axis = axis(st, graph_offset);
    col.rgb *= (1.0-plotted) * (1.0-axis);
    col.r += axis;
    col.g += plotted;
    return col;
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    // value used for gradiant
    float y = st.x;
    // the gradiant color based on the value of Y
    // y = sin(PI*2.0 * (st.x + u_time/5));
    // y = pow(4.0 * y * (1.0 - y), 0.5);
    //vec3 color = horizontal_color(y, st);
    vec3 color = mix(colorA, colorB, y);
    float graph_offset = -0.0;
    float graph_scaling = 1.0;
    float plotted = plot(st, y, graph_offset, graph_scaling);
    color.rgb *= (1.0-plotted);
    color.g += plotted;

    gl_FragColor = vec4(color, 1.0);
}