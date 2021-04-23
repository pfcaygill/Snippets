/**
 from the https://thebookofshaders.com/04/
 nifty little example to let me play with the shader files we can define for ourselves
*/

PShader shader;
void settings(){
 fullScreen(P2D, 1);
}
void setup() {
  noStroke();
  /*
  From the docs on shaders:
  Loads a shader into the PShader object. The shader file must be loaded in the sketch's "data" folder/directory to load correctly.
  Shaders are compatible with the P2D and P3D renderers, but not with the default renderer.
  */
  shader = loadShader("Project/BasicShader.glsl");
}
void draw() {
  shader.set("u_resolution", float(width), float(height));
  shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("u_time", millis() / 1000.0);
  shader(shader);
  rect(0,0,width,height);
}
