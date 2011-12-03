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
    fWidth = fWidth + avatar_amplitude * 5 * sin( frameCount * avatar_frequency / 2.0 );
    fHeight = fHeight + avatar_amplitude * 5 * sin( frameCount * avatar_frequency / 2.0 );
  
    // Set fill-color to blue
    fill( 255 * avatar_colour, 255 * avatar_colour, 255 * avatar_colour );
  
  
    // Set stroke-color white
    stroke(255 * (1 - avatar_colour), 255 * (1 - avatar_colour), 255 * (1 - avatar_colour));
    strokeWeight( avatar_size * 10 );
  
    // Draw body
    ellipse(x, y, fWidth, fHeight);                  
    
    // Draw eyes
    fill(0);
    ellipse( x - (fWidth/8), y - (fHeight/5), fWidth/10, fHeight/10 );
    ellipse( x + (fWidth/8), y - (fHeight/5), fWidth/10, fHeight/10 );
    
    // Draw mouth
    noFill();
    stroke(255 * (1 - avatar_colour), 255 * (1 - avatar_colour), 255 * (1 - avatar_colour));
    if (avatar_mood > 0.7) {
      arc(x, y + (fHeight/3)*avatar_mood, fWidth/3, fHeight/10, 0, PI);
    } else {
      arc(x, y + (fHeight/3)*avatar_mood, fWidth/3, fHeight/10, PI, TWO_PI);
    }
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


