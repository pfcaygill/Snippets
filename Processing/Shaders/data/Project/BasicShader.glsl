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

float floor_box(vec2 st){
    float pct = 1.0;
    pct -= floor(st.x + 0.1);
    pct -= floor(st.y + 0.1);
    pct -= 1.0 - floor(0.9 + st.x);
    pct -= 1.0 - floor(0.9 + st.y);
    return pct;
}

vec3 fill_color_rect(vec2 st, vec2 position, vec2 size, vec3 fill_color){
    vec2 pos = step(position, st);
    vec2 s = step(size, st);
    return vec3((pos.x - s.x) * (pos.y - s.y)) * fill_color;
}

vec3 fill_color_circle(vec2 st, vec2 centre, float radius, vec3 fill_color){
    float fill = 1.0 - step(radius, distance(st, centre));
    return vec3(fill) * fill_color;
}

vec3 fill_color_rect(vec2 st, float x, float y, float width, float height, vec3 fill_color){
    return fill_color_rect(st, vec2(x, y), vec2(width, height), fill_color); 
}
vec3 mask(vec3 color){
    vec3 on = ceil(color);
    return vec3(on.r + on.g + on.b);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    
     // value used for gradiant
//     float y = st.x;
//     // the gradiant color based on the value of Y
//     y = sin(PI*2.0 * (st.x + u_time/5));
//     y = pow(4.0 * y * (1.0 - y), 0.5);
//     vec3 color = horizontal_color(y, st);

//  // Mixing and graphing
//    vec3 color = mix(colorA, colorB, y);
//    float graph_offset = -0.0;
//    float graph_scaling = 1.0;
//    float plotted = plot(st, y, graph_offset, graph_scaling);
//    color.rgb *= (1.0-plotted);
//    color.g += plotted;

    vec3 color = vec3(1.0);
    vec3 shapes = vec3(0.0);

    shapes += fill_color_rect(
        st,
        vec2(0.1, 0.1),
        vec2(0.8, 0.8),
        vec3(1.0, 0.6, 0.0)
    );
    shapes += fill_color_rect(
        st,
        vec2(0.85, 0.1),
        vec2(0.9, 0.9),
        vec3(0.0, 0.6, 0.6)
    );
    vec3 rec_3 = fill_color_rect(
        st,
        vec2(0.2, 0.2),
        vec2(0.9, 0.7),
        vec3(0.0, 0.7, 0.7)
    );
    //shapes -= mask(rec_3);
    shapes += rec_3;
    vec3 circle_1 = fill_color_circle(
        st,
        vec2(0.5),
        0.1,
        vec3(1.0, 0.0, 0.0)
    );
//    shapes -= mask(circle_1);
//    shapes += circle_1;
    color *= shapes;
    gl_FragColor = vec4(color, 1.0);
}