import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       wave;
Oscil       wave1;


void setup()
{
  background(0);
  fullScreen(P3D);
  noCursor();
  //size(500, 500);
  //smooth();
  cx = width / 2;
  cy = height / 2;
  
  from = color(0, 0, 0);
  to = color(255, 0, 0);
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  wave1 = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  wave.patch( out );
  //wave1.patch( out );
  //wave.setAmplitude(1);
    
}

color nextColor()
{
  return color(random(0, 255), random(0, 255), 0);
}

float cx, cy;
color from;
color to;
float theta = (3.0f / 2.0f) * PI;
float theta1 = (3.0f / 2.0f) * PI;
float speed = -0.01f;
float timer = 0.0f;
int sides = 4;
float gOff = 0;
float rotSpeed = 0.1f;

color lerpColor(color from, color to, float t)
{
  return 
  color(
    lerp(red(from), red(to), t)
    , lerp(green(from), green(to), t) //<>//
    , lerp(blue(from), blue(to), t)
    );
}

float rot = 0;
void draw()
{
  translate(cx, cy);  
  
  
  rotate(rot);
  rot += 0.001f;
  background(0);
  strokeWeight(20);
  float offset = 0 ;
  float freq = map(noise(theta), 0.2f, 0.7f, 60, 180);
  wave.setFrequency(freq);

  float freq1 = map(noise(theta1), 0.3f, 0.7f, 200, 100);
  wave1.setFrequency(freq1);
  for(float radius = 0 ; radius < width * 1.6 ; radius += 40)
  {
    offset += 0.1f;
    float t = map(noise(theta + offset), 0.2f, 0.8f, 0.0f, 1.0f);
    color col = lerpColor(from, to, t);
    //color(map(sin(theta + offset), -1, 1, 0, 255), 0, 0);    
    rotate(rotSpeed);  
    drawStar(0, 0, radius, sides, col);
  }
  theta += speed;
  theta1 += speed * 0.4;
  gOff += speed;
  timer += abs(speed);
  /*if (timer >= TWO_PI)
  {
    timer = TWO_PI - timer; //<>//
    //to = nextColor();
    //sides = (int) random(3, 10);
  } 
  */
}

void drawStar(float cx, float cy, float radius, int points, color c)
{
    float thetaInc = TWO_PI / (points * 2);
    float lastX;
    float lastY;
    lastX = cx;
    lastY = cy -radius; 
    
    stroke(c);
    
    for (int i = 1 ; i <= (points * 2) ; i ++)
    {
      float theta = (i * thetaInc);
      float x, y;
      float r;
      if (i % 2 == 1)
      {
        r = radius * 0.5f;
      }
      else
      {
        r = radius;        
      }

      x = cx + sin(theta) * r;
      y = cy -cos(theta) * r;
      line(lastX, lastY, x, y);
      lastX = x;
      lastY = y;      
    }
}