float G = 10;
float dt = 0.1;
float coeffVisual = 100;
float limForce = 150;

int nbrGravitors;
ArrayList<Gravitor> system;

void setup(){
  size(600, 600);
  frameRate(30);
  colorMode(HSB);
  
  nbrGravitors = 2;
  system = new ArrayList<Gravitor>();
  for(int i=0; i<nbrGravitors; i++){
    float x = random(random(width/4, width/3), random(2*width/3, 3*width/4));
    float y = random(random(height/4, height/3), random(2*height/3, 3*height/4));
    float xs = random(10);
    float ys = random(10);
    float m = random(random(1, 3), random(10, 20));
    float r = random(10, 20);
    float h = random(127);
    float s = random(255);
    float b = random(255);
    Gravitor gravitor = new Gravitor(false, x, y, xs, ys, m, r, h, s, b);
    system.add(gravitor);
  }
  float m = random(random(5, 10), random(15, 25));
  float r = random(10, 20);
  float h = random(127);
  float s = random(255);
  float b = random(255);
  Gravitor gravitor = new Gravitor(true, m, r, h, s, b);
  system.add(gravitor);
  
  background(0);
}

void draw(){
  //background(0);
  
  for(Gravitor gravitor : system){
    gravitor.update();
  }
  for(Gravitor gravitor : system){
    gravitor.display();
  }
}

float dist(Gravitor g1, Gravitor g2){
  float distance;
  distance = pow((g1.old_xPos-g2.old_xPos), 2) + pow((g1.old_yPos-g2.old_yPos), 2);
  return pow(distance, 0.5);
}
