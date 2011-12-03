class Avatar {
  float fWidth, fHeight, fStroke;
  float x, y;
  
  Avatar() {
    fWidth = avatar_size * 200.0;
    fHeight = fWidth;
    fStroke = avatar_size * 10;
    x = width / 2;
    y = height / 2;
  }
  
  void update() {
    // track avatar position
    x+=(mX-x)/delay;
    y+=(mY-y)/delay;
  }
  
  void draw() {
    fWidth = fWidth + sin( frameCount / ( (10 * avatar_amplitude) * avatar_frequency) );
    fHeight = fHeight + sin( frameCount / ( (10 * avatar_amplitude) * avatar_frequency) );
  
    // Set fill-color to blue
    fill( 0, 121, 184 );
  
    // Set stroke-color white
    stroke(255); 
    strokeWeight( avatar_size * 10 );
  
    // Draw body
    ellipse(x, y, fWidth, fHeight);                  
    
    // Draw eyes
    fill(0);
    ellipse( x - (fWidth/8), y - (fHeight/5), fWidth/10, fHeight/10 );
    ellipse( x + (fWidth/8), y - (fHeight/5), fWidth/10, fHeight/10 );
    
    strokeWeight(0);
    fill( 184, 121, 0 );
    ellipse( x, y + (fHeight/5), fWidth/3, fHeight/10 );

  }
}


// Global variables
int mX, mY;
int delay = 16;

Avatar avatar;

// Setup the Processing Canvas
void setup(){
  setupAvatar();
  size( 350, 350 );
  frameRate( 15 );
  smooth();
  
  avatar = new Avatar();
}

// Main draw loop
void draw() {
  // Fill canvas grey
  background( 100 );

  avatar.update();  
  
  avatar.draw();
}

void mouseMoved() {
  mX = mouseX;
  mY = mouseY;  
}
