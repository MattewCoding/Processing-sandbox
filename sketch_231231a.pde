int largeCircleSize = 280;  // Taille du premier cercle
int smallCircleSize = 180;   // Taille du deuxième cercle

color largeCircleColor = color(204, 102, 0);
color smallCircleColor = color(204, 153, 0);

void setup() {
  size(640, 360);
  noStroke();
}

void draw() {
  background(51, 0, 0);

  // Premier cercle
  pushMatrix();
  translate(320, 180);
  if (isMouseOverCircle(0, 0, largeCircleSize)) {
    if (mousePressed) {
      largeCircleColor = color(random(255), random(255), random(255)); // Changer la couleur aléatoirement lors du clic
    }
  }
  fill(largeCircleColor);
  ellipse(0, 0, largeCircleSize, largeCircleSize);

  // Deuxième cercle
  if (isMouseOverCircle(0, 0, smallCircleSize)) {
    if (mousePressed) {
      smallCircleColor = color(random(255), random(255), random(255)); // Changer la couleur aléatoirement lors du clic
    }
  }
  fill(smallCircleColor);
  ellipse(0, 0, smallCircleSize, smallCircleSize);
  popMatrix();
}

// Fonction pour vérifier si la souris survole un cercle
boolean isMouseOverCircle(float x, float y, float diameter) {
  float distance = dist(mouseX, mouseY, x + width / 2, y + height / 2);
  return distance < diameter / 2;
}
