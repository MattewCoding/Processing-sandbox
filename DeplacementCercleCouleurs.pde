/* Deplacement cercle avec changement de couleurs
 * Auteurs: SEBBOUH Ryan et YANG Mattew
 *
 * Dans ce module, on peux modifier les couleurs des cercles en
 * maintenant la souris enfoncée lorsqu'elle se trouve au-dessus
 * d'un cercle.
 *
 * Déplacez la souris vers la gauche et la droite pour déplacer
 * les cercles.
 *
 */

int largeCircleSize = 280;  // Taille du premier cercle
int smallCircleSize = 180;   // Taille du deuxième cercle
int smallerCircleSize = 80;   // Taille du troisième cercle

color largeCircleColor = color(204, 102, 0);
color smallCircleColor = color(204, 153, 0);
color smallerCircleColor = color(204, 204, 0);

// Variables pour mieux modifier les valeurs
// "depth" donne l'illusion de la perspective
int centerHeight, centerWidth, depth;

int intervalle = 250; // Pause entre changement de couleurs
int tempsEcoule = 250;

void setup() {
  size(640, 320);
  noStroke();
  centerHeight = height/2;
  centerWidth = mouseX = width/2;
  depth = width/10;
}

void draw() {
  background(51, 0, 0);
  float deplacement = mouseX/float(width) - 0.5;
  boolean delaiPasse = millis() - tempsEcoule >= intervalle; // Determiner s'il on a depassé le delai
  translate(centerWidth, centerHeight); // Commun au deux cercles

  // Grand cercle
  largeCircleColor = desinnerCercle(largeCircleSize, int(deplacement * depth), delaiPasse, largeCircleColor);

  // Petit cercle
  smallCircleColor = desinnerCercle(smallCircleSize, int(deplacement * depth/2), delaiPasse, smallCircleColor);

  // Petit cercle
  smallerCircleColor = desinnerCercle(smallerCircleSize, int(deplacement * depth/4), delaiPasse, smallerCircleColor);
  
  if(delaiPasse) tempsEcoule = millis(); // Si delai depassé, on recommence à 0
}

// Fonction pour vérifier si la souris survole un cercle
boolean isMouseOverCircle(float diameter, float cercleXCentre) {
  float distance = dist(mouseX, mouseY, cercleXCentre, height / 2);
  return distance < diameter / 2;
}

color desinnerCercle(int size, int deplacementX, boolean delaiPasse, color defaultColor){
  color couleurCercle = defaultColor;
  
  pushMatrix();
  translate(deplacementX, 0);
  if (isMouseOverCircle(size, centerWidth + deplacementX)) {
    if (mousePressed && delaiPasse) {
      couleurCercle = color(random(255), random(255), random(255)); // Changer la couleur aléatoirement lors du clic
    }
  }
  fill(couleurCercle);
  circle(0,0,size);
  popMatrix();
  return couleurCercle;
}
