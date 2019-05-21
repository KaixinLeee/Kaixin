import processing.serial.*;
//------------------------
Serial arduino;
int targetDistance;
int currentDistance;
//---------------------
void setup()
{
  size(400, 400);
  printArray(Serial.list());
  arduino=new Serial(this, Serial.list()[0], 115200);
  fill(255);
}
//---------------------
void draw()
{
  background(50);
  if (arduino.available()>0)
  { 
    targetDistance=arduino.read();

    println(arduino.read());
  }
  if (currentDistance>targetDistance)
  {
    currentDistance--;
  } else if (currentDistance<targetDistance)
  {
    currentDistance++;
  }
  ellipse(width/2, height/2, currentDistance*5, currentDistance*5);
}
