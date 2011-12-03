
// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;

// Setup the Processing Canvas
void setup(){
  setupAvatar();
  radius = avatar_size * 200.0;
  
  size( 350, 350 );
  strokeWeight( avatar_size * 10 );
  frameRate( 15 );
  X = width / (int)(4.0 * avatar_speed);
  Y = width / (int)(4.0 * avatar_speed);
  nX = X;
  nY = Y;  
}

// Main draw loop
void draw(){
  
  radius = radius + sin( frameCount / ( (10 * avatar_amplitude) * avatar_frequency) );
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas grey
  background( 100 );
  
  // Set fill-color to blue
  fill( 0, 121, 184 );
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw circle
  ellipse( X, Y, radius, radius );                  
}


// Set circle's next destination
void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}
