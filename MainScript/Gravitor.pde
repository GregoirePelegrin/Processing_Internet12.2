class Gravitor{
  boolean isMouse;
  
  float old_xPos;
  float old_yPos;
  float new_xPos;
  float new_yPos;
  float mass;
  float radius;
  
  float xAccel;
  float yAccel;
  float xSpeed;
  float ySpeed;
  
  float hue;
  float saturation;
  float brightness;
  
  Gravitor(boolean im, float x, float y, float xs, float ys, float m, float r, float h, float s, float b){
    this.isMouse = im;
    this.old_xPos = x;
    this.old_yPos = y;
    this.mass = m;
    this.radius = r;
    
    this.xAccel = 0;
    this.yAccel = 0;
    this.xSpeed = xs;
    this.ySpeed = ys;
    
    this.hue = h;
    this.saturation = s;
    this.brightness = b;
    
    /*println("----------Init----------");
    println("Accel: ", this.xAccel, " // ", this.yAccel);
    println("Speed: ", this.xSpeed, " // ", this.ySpeed);
    println("Pos: ", this.old_xPos, " // ", this.old_yPos);
    println("Carac: ", this.mass, "//", this.radius);*/
  }
  
  Gravitor(boolean im, float m,  float r, float h, float s, float b){
    this.isMouse = im;
    this.mass = m;
    this.radius = r;
    this.hue = h;
    this.saturation = s;
    this.brightness = b;
  }
  
  void update(){
    if(!this.isMouse){
      this.xAccel = 0;
      this.yAccel = 0;
      
      float currForce;
      float currAccel;
      float currAngle;
      for(Gravitor gravitor : system){
        if(this == gravitor){
          continue;
        }
        currForce = 0;
        currAccel = 0;
        currAngle = 0;
        
        currForce = coeffVisual*G*(this.mass*gravitor.mass)/dist(this, gravitor);
        if(abs(currForce) > limForce){
          currAccel = currForce*limForce/( abs(currForce)*this.mass);
        } else {
          currAccel = currForce/this.mass;
        }
        
        float x;
        float y;
        if(gravitor.isMouse){
          x = this.old_xPos - gravitor.new_xPos;
          y = this.old_yPos - gravitor.new_yPos;
        } else {
          x = this.old_xPos - gravitor.old_xPos;
          y = this.old_yPos - gravitor.old_yPos;
        }
        if(x>=0 && y>=0){
          currAngle = PI + acos(abs(x)/dist(this, gravitor));
        } else if(x<=0 && y<=0){
          currAngle = acos(abs(x)/dist(this, gravitor));
        } else if(x<=0 && y>=0){
          currAngle = - acos(abs(x)/dist(this, gravitor));
        } else if(x>=0 && y<=0){
          currAngle = PI - acos(abs(x)/dist(this, gravitor));
        } else {
          println("ERROR");
          noLoop();
          break;
        }
        
        this.xAccel += currAccel*cos(currAngle);
        this.yAccel += currAccel*sin(currAngle);
      }
      
      this.xSpeed += this.xAccel*dt;
      this.ySpeed += this.yAccel*dt;
      
      this.new_xPos = this.old_xPos + this.xSpeed*dt;
      this.new_yPos = this.old_yPos + this.ySpeed*dt;
    } else {
      this.new_xPos = mouseX;
      this.new_yPos = mouseY;
    }
  }
  
  void display(){
    fill(this.hue, this.saturation, this.brightness, 50);
    noStroke();
    ellipse(this.old_xPos, this.old_yPos, 2*this.radius, 2*this.radius);
  
    this.old_xPos = this.new_xPos;
    this.old_yPos = this.new_yPos;
  }
}
