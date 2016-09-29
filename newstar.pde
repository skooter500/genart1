void setup()
{
  background(0);
  fullScreen();
  noCursor();
  //size(500, 500);
  //smooth();
  cx = width / 2;
  cy = height / 2;
  
  from = color(0, 255, 255);
  to = color(0, 0, 0);
  
}

color nextColor()
{
  return color(random(0, 255), random(0, 255), 0);
}

float cx, cy;
color from;
color to;
float theta = 0;
float speed = -0.05f;
float timer = 0.0f;
int sides = 8;
float gOff = 0;

color lerpColor(color from, color to, float t)
{
  return 
  color(
    lerp(red(from), red(to), t)
    , lerp(green(from), green(to), t)
    , lerp(blue(from), blue(to), t)
    );
}

void draw()
{
  background(0);
  strokeWeight(20);
  float offset = 0 ;
  translate(cx, cy);  
  for(float radius = 0 ; radius < width * 1.6 ; radius += 35)
  {
    offset += 0.1f;
    float t = map(sin(theta + offset), -1.0f, 1.0f, 0.0f, 1.0f);
    color col = lerpColor(from, to, t);
    color(map(sin(theta + offset), -1, 1, 0, 255), 0, 0);    
    //rotate(speed);  
    drawStar(0, 0, radius, sides, col);
  }
  theta += speed;
  gOff += speed;
  timer += abs(speed);
  println(theta);  
} //<>//

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