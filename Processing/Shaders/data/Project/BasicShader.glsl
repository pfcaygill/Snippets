#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float PI;

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

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    
    // value used for gradiant
    float y = abs(sin(PI*2.0 * st.x));

    // the gradiant color based on the value of Y
    vec3 color = vec3(y);

    // plot the gradiant color as a green line using our plot function    
    float graph_offset = -0.0;
    float graph_scaling = 2.0;
    float plotted = plot(st, y, graph_offset, graph_scaling);
    float axis = axis(st, graph_offset);
    color.rgb *= (1.0-plotted) * (1.0-axis);
    color.r += axis;
    color.g += plotted;

    gl_FragColor = vec4(color, 1.0);
}