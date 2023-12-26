/**
 * Solar System Reflection 
 * by Simon Greenwold. Modified by Mattew Yang. 
 * 
 * Vary the specular reflection component of a material
 * with the horizontal position of the mouse.
 * Now with "planets" orbiting around the "star". Vary
 * the orbit with the horizontal position of the mouse.
 * The vertical position of the mouse modifies the
 * angle the solar system is viewed from.
 *
 * Holding down the mouse switches the lighting from reflection to directional.
 */

int randInt(int s, int e){
  return int(random(s,e));
}

float randPI(){
  return random(0, PI);
}

// Initial setup
float angles[] = {0.0, 0.0, 0.0, 0.0};
float speed[] = {5.0, 4.0, 3.0, 2.0};
float offset[] = {randPI(), randPI(), randPI(), randPI()};
int orbit_dist[] = {randInt(225, 250), randInt(275, 325), randInt(350, 375), randInt(450, 480)};
float radii[] = {5.0, 7.0, 12.0, 8.0};

void setup() {
  size(1280, 1280, P3D);
  
  noStroke();
  colorMode(RGB, 1);
  fill(0.4);
}

float[] calculatePos(float dist, float angle, float radius){
  float ans[] = {0.0, 0.0};
  ans[0] = width/2 + dist * cos(2 * angle);
  //println("23; ans[0]: " + width/2 + " " + cos(angle) + " "+ radius);
  ans[1] = dist * sin(2*(angle - PI/2));
  //println("25; sinAngle (" + (angle - PI/2) + "): " + 120 + " * " + sin(2*(angle - PI/2)) + " = " + ans[1]);
  return ans;
}

void drawArrow(){
  float arrowSize = 25;
  noStroke();
  beginShape();
  vertex(-arrowSize, arrowSize, 0);
  vertex(arrowSize, arrowSize, 0);
  vertex(0, -arrowSize*2, 0);
  endShape(CLOSE);
}

void setLight(boolean mouseDown, float rot){
  // Set the specular color of lights that follow
  if(mouseDown){
    float dirY = (mouseY / float(height) - 0.5) * 2;
    float dirX = (mouseX / float(width) - 0.5) * 2;
    lightSpecular(1, 1, 1);
    directionalLight(0.8, 0.8, 0.8, -dirX, -dirY, -1);
    specular(0.5, 0.5, 0.5);
  } else {
    lightSpecular(1, 1, 1);
    directionalLight(0.8, 0.8, 0.8, 0, 0, -1);
    float s = mouseX / float(width);
    specular(s, s, s);
  }
}

void draw() {
  float yRotate = mouseY / float(width) * PI - PI/2 - PI/8;
  
  background(0); // Black
  // Set the specular color of lights that follow
  lightSpecular(1, 1, 1);
  setLight(mousePressed, yRotate);
  
  // Sun
  pushMatrix(); // Isolate translations
  translate(width / 2, height / 2);
  sphere(120);
  popMatrix();
  
  float mouseXPercent = (float)mouseX/width * PI;
  //println("mouseX: " + mouseX + " " + width);
  
  // Planets
  for(int i=0; i<4; i++){
    //println("orbit_dist: " + orbit_dist[i]);
    float pos[] = calculatePos((float)orbit_dist[i], angles[i], radii[i]);
    
    //println("pos: " + pos[0] + " " + pos[1]);
    
    pushMatrix();
    translate(0, height/2); // Rotate around the center
    rotateX(yRotate); // Slight offset below to account for the fact that we like to look at things from above
    translate(pos[0], 0, pos[1]);
    sphere(radii[i]);
    popMatrix();
    
    angles[i] = (mouseXPercent*speed[i] + offset[i])%TWO_PI;
  }
  pushMatrix(); // Isolate translations
  translate(0, height/2); // Rotate around the center
  rotateX(yRotate);
  translate(width-100, 0, PI);
  drawArrow();
  popMatrix();
}
