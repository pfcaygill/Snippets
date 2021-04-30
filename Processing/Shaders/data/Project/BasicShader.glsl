#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform float PI;

float plot(vec2 st){
    float edge1 = 0.0055; 
    float edge2 = 0.005;
    return smoothstep(edge1, edge2, abs(st.x - st.y));
}

float sine_step(float pct){
    return step(sin(pct), 0.0);
}

void main(){
    vec2 st = gl_FragCoord.xy/u_resolution;
    float dx = 2.0 * PI * st.x;
    vec2 delta = 2.0 * PI * st;
    vec3 color = vec3(dx);

    float stepped = sine_step(dx);
    float plotted = plot(st);
    float chosen = plotted;
    color.rgb = (1.0-chosen) * color;
    color.g += chosen;

    gl_FragColor = vec4(color, 1.0);
}