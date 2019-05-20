import processing.serial.*;
//------------------------
Serial arduino;
int targetDistance;
int currentDistance;
PImage img;
PImage img2;
//---------------------
void setup()
{
  size(400, 400);
  printArray(Serial.list());
  arduino=new Serial(this, Serial.list()[0], 115200);
  fill(255);
  img = loadImage("moon.jpg"); 
  img2 = loadImage("diy.jpg");// Load the original image
}
//---------------------
void draw()
{
  background(50);
  if (arduino.available()>0)
  { 
    targetDistance=arduino.read();

    //println(arduino.read());
  }
  if (currentDistance>targetDistance)
  {
    //currentDistance--;
  } else if (currentDistance<targetDistance)
  {
    //currentDistance++;
  }

  if (arduino.available()<50.0)
    image(img, 0, 0); // Displays the image from point (0,0) 
  if (arduino.available()>50.0)
    image(img2, 0, 0); // Displays the image from point (0,0) 
  //ellipse(width/2, height/2, currentDistance*5, currentDistance*5);
}
