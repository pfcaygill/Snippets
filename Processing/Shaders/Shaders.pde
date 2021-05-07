/**
 from the https://thebookofshaders.com/04/
 nifty little example to let me play with the shader files we can define for ourselves
*/

PShader shader;
String SHADER_FILE = "Project/BasicShader.glsl";

void settings(){
 size(600, 600, P2D);
}
void setup() {
  noStroke();
  /*
  From the docs on shaders:
  Loads a shader into the PShader object. The shader file must be loaded in the sketch's "data" folder/directory to load correctly.
  Shaders are compatible with the P2D and P3D renderers, but not with the default renderer.
  */
  shader = loadShader(SHADER_FILE);
}
void draw() {
  if (frameCount==1){
    surface.setLocation(100, 0);
  }
  shader.set("u_resolution", float(width), float(height));
  shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("PI", PI);
  shader.set("u_time", millis() / 1000.0);
  shader(shader);
  rect(0,0,width,height);
}
void mousePressed(){
  reloadShader();
}

void reloadShader(){
  try {
    PShader temp = loadShader(SHADER_FILE);
    shader(temp); // check our shader can be applied
    resetShader();
    shader = temp;
    println("Shader Reloaded");
  } catch(RuntimeException e){
    println("Could not compile fragment shader, canceling load");
    println(e.getMessage());
  } catch(Exception e){
    println(e.getMessage());
  }
}
