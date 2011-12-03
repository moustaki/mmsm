
void setupAvatar() {}
    float avatar_size = random(1);
    float avatar_colour = random(1);
    float avatar_frequency = random(1);
    float avatar_amplitude = random(1);
    float avatar_mood = random(1);
    float avatar_speed = random(1);

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
    
    
    radius = radius + sin( frameCount / ( (10 * avatar_amplitude) * avatar_frequency) );
   
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw circle
  ellipse(x, y, radius, radius );                  

  }
}


// Global variables
float radius = 50.0;
int mX, mY;
int delay = 16;

Avatar avatar;

// Setup the Processing Canvas
void setup(){
  setupAvatar();
  size( 350, 350 );
  frameRate( 15 );

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


