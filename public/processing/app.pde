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
    x = width / 2;
    y = height / 2;
  }
  
  void update() {
    // track avatar position
    x+=(mX-x)/delay;
    y+=(mY-y)/delay;
  }
  
  void draw() {
    w = w + sin( frameCount * avatar_frequency / ( (10 * avatar_amplitude)) );
    h = h + sin( frameCount * avatar_frequency / ( (10 * avatar_amplitude)) );
  
    body.draw(this);    
    eyes.draw(this);
    mouth.draw(this);    
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
    img = loadImage("/processing/" + (seed+1) + ".png");
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
  avatar.body = new ImageBody(seed);
  avatar.eyes = new Eyes();
  avatar.mouth = new Mouth();
  return avatar;
}

// Global variables
int mX, mY;
int delay = 16;

Avatar avatar;
int palette[] = { #f0f6dc, #08b8ab, #3ab451 };

// Setup the Processing Canvas
void setup(){
  setupAvatar();
  size( 350, 350 );
  frameRate( 15 );
  smooth();
  
  avatar = avatarFactory((int)random(5.0));
}

// Main draw loop
void draw() {
  background(palette[0]);
  avatar.update();  
  avatar.draw();
}

void mouseMoved() {
  mX = mouseX;
  mY = mouseY;  
}


