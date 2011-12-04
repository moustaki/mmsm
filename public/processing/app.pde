class Avatar {
  Body body;
  Eyes eyes;
  Mouth mouth;
  
  int x, y;
  float w, h, s;
  int c;
  
  Avatar() {
    w = avatar_size * 200.0;
    h = w;
    s = avatar_size * 10;
    this.x = width / 2;
    this.y = height / 2;
  }
  
  void update() {
    // track avatar position
//    x+=(mX-x)/delay;
//    y+=(mY-y)/delay;
//      println(x + "," + y);
  }
  
  void draw() {
    w = w + avatar_amplitude * 5 * sin( frameCount * avatar_frequency / 2.0 );
    h = h + avatar_amplitude * 5 * sin( frameCount * avatar_frequency / 2.0 );
  
    body.draw(this);    
    eyes.draw(this);
    mouth.draw(this);    
  }
}

// inspired by/adapted from:
//   blob flowers	 by allonestring, licensed under Creative Commons Attribution-Share Alike 3.0 and GNU GPL license.
//   Work: http://openprocessing.org/visuals/?visualID=30755
class blob //a shape with rounded corners
{
  float[] xpos, ypos; //vertices
  color colour;
  float[] xoffcw, yoffcw; //"clockwise" offsets from vertices
  int n;
  int offset = 3; //fraction of each end of line converted to rounded corners
   
  blob(float[] xpos, float[] ypos, color colour)
  {
    this.xpos = xpos;
    this.ypos = ypos;
    this.colour = colour;
    init();
  }
   
  void init()
  {
    noStroke();
 
    n = xpos.length;
    xoffcw = new float[n];
    yoffcw = new float[n];
  }
   
  void display()
  {
    for(int i = 0; i < n; i++)
    {
      float dx = xpos[i] - xpos[(i + 1) % n];
      float dy = ypos[i] - ypos[(i + 1) % n];
      xoffcw[i] = xpos[i] - dx / offset;
      yoffcw[i] = ypos[i] - dy / offset;
    } 
     
    fill(colour);
    beginShape();
    vertex(xoffcw[n - 1], yoffcw[n - 1]);
    for(int i = 0; i < n; i++)
    {
      int j = (i + n - 1) % n;
      bezierVertex(xpos[i], ypos[i], xpos[i], ypos[i], xoffcw[i], yoffcw[i]);
    }
    endShape();
  }
}

class ShinyBody extends Body {
  int numVertices;
  
  public ShinyBody() {
    numVertices = (int)random(3, 10);
  }
  
  public void draw(Avatar avatar) {
    float[] xBlobVertices = new float[numVertices];
    float[] yBlobVertices = new float[numVertices];
    float angle = TWO_PI / numVertices;
    float gamma = 0;
  
    float bRadius = 20 + (80 * avatar_size);
    for(int i = 0; i < numVertices; i++) {
      gamma+=angle;
      xBlobVertices[i] = avatar.w * cos(gamma);
      yBlobVertices[i] = avatar.h * sin(gamma);
    }
    blob b = new blob(xBlobVertices, yBlobVertices, palette[1]);

    pushMatrix();
    translate(avatar.x, avatar.y);
    b.display();
    popMatrix();
  }
}

class Body {
  public void draw(Avatar avatar) {
    fill( palette[1] );
    stroke( palette[1]);
    strokeWeight( avatar_size * 10);
    ellipse(avatar.x, avatar.y, avatar.w, avatar.h);
  }
}

class SquareBody extends Body {
  public void draw(Avatar avatar) {
    fill( palette[1] );
    stroke(palette[1]);
    strokeWeight( avatar_size * 10);
    rect(avatar.x - avatar.w/2, avatar.y - avatar.w/2, avatar.w, avatar.h);
  }
}

class OvalBody extends Body {
  public void draw(Avatar avatar) {
    fill( palette[1] );
    stroke(palette[1]);
    strokeWeight( avatar_size * 10);
    ellipse(avatar.x, avatar.y, avatar.w, avatar.h * 0.8);
  }
}

class ImageBody extends Body {
  PImage img;

  public ImageBody(int seed) {
    img = loadImage((seed+1) + ".png");
  }
  public void draw(Avatar avatar) {
    image(img, avatar.x - avatar.w/2, avatar.y - avatar.h/2, avatar.w, avatar.h);
  }
}


class Eyes {
  public void draw(Avatar avatar) {
    fill(255);
    stroke(1);
    strokeWeight(1);
    ellipse( avatar.x - (avatar.w/8), avatar.y - (avatar.h/5), avatar.w/10, avatar.h/10 );
    ellipse( avatar.x + (avatar.w/8), avatar.y - (avatar.h/5), avatar.w/10, avatar.h/10 );
    
  }
}

class Mouth {
  public void draw(Avatar avatar) {
    noFill();
    stroke(palette[0]);
    strokeWeight( avatar_size * 10);
    if (avatar_mood > 0.5) {
      arc(avatar.x, avatar.y + (avatar.h/3)*avatar_mood, avatar.w/3, avatar.h/10, 0, PI);
    } else {
      arc(avatar.x, avatar.y + (avatar.h/3)*avatar_mood, avatar.w/3, avatar.h/10, PI, TWO_PI);
    }
  }
}

Avatar avatarFactory(int seed) {
  avatar = new Avatar();
  avatar.body = new ShinyBody();
  avatar.eyes = new Eyes();
  avatar.mouth = new Mouth();
  return avatar;
}

// Global variables
int mX, mY;
int delay = 16;

Avatar avatar;
int palette[] = { #292a24, #cfc392, #e0a929 };

// Setup the Processing Canvas
void setup(){
  setupAvatar();
  size( 350, 350 );
  frameRate( 15 );
  smooth();
  
  background(255);
  avatar = avatarFactory((int)random(5.0));
}

// Main draw loop
void draw() {
  noStroke();
  background(palette[0]);

  avatar.update();  
  avatar.draw();
}

void mouseMoved() {
  mX = mouseX;
  mY = mouseY;  
}
