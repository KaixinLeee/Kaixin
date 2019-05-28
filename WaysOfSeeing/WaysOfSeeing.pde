/*
  What does this do?
 */
import processing.serial.*;
//-----------------------------------------------------
PShader blur;
PGraphics src;
PGraphics pass1, pass2;
Serial arduino;
int targetDistance  ;
int currentDistance ;
PImage bigImage, mediumImage, smallImage, currentImage;

//-----------------------------------------------------
void setup() 
{
  //---------------------------------------------------
  bigImage    = loadImage("big.jpg");
  mediumImage = loadImage("media.jpg"); 
  smallImage  = loadImage("small.jpg"); 
  currentImage = bigImage;
  //---------------------------------------------------
  arduino = new Serial(this, Serial.list()[0], 115200);
  fill(60);
  //---------------------------------------------------
  size(1920, 1080, P2D);
  //fullScreen(P2D, 1);
  //---------------------------------------------------
  blur = loadShader("blur.glsl");
  blur.set("blurSize", 60);
  blur.set("sigma", 5.0f);  
  //---------------------------------------------------
  src = createGraphics(width, height, P2D); 
  //---------------------------------------------------
  pass1 = createGraphics(width, height, P2D);
  pass1.noSmooth();  

  pass2 = createGraphics(width, height, P2D);
  pass2.noSmooth();
  //---------------------------------------------------
  checkArduino();
}

float blurScale = 2 * PI / 255.0;

void draw() 
{
  float blurAmount = (1 - cos(currentDistance * blurScale)) * 10;
  //---------------------------------------------------  
  blur.set("sigma", blurAmount);

  //blur.set("sigma", 5.0*(sin(PI*millis()/1000.0)+1));
  //---------------------------------------------------
  src.beginDraw();
  src.background(50);  
  src.image(currentImage, 0, 0); // Displays the image from point (0,0) 
  src.endDraw();
  //---------------------------------------------------
  checkArduino();
  //---------------------------------------------------  
  //change image regarding to distance  
  applyBlur();
  //image(src, 0, 0);
} 


void applyBlur()
{ 
  //---------------------------------------------------
  // Applying the blur shader along the vertical direction   
  blur.set("horizontalPass", 0);
  pass1.beginDraw();            
  pass1.shader(blur);  
  pass1.image(src, 0, 0);
  pass1.endDraw();
  //---------------------------------------------------
  // Applying the blur shader along the horizontal direction      
  blur.set("horizontalPass", 1);
  pass2.beginDraw();            
  pass2.shader(blur);  
  pass2.image(pass1, 0, 0);
  pass2.endDraw();    
  //---------------------------------------------------
  image(pass2, 0, 0);
}


void checkArduino()
{
  //---------------------------------------------------
  if (arduino.available() > 0)
  { 
    targetDistance = arduino.read();
    println(arduino.read());
  }
  //---------------------------------------------------
  if (currentDistance > targetDistance)
  {
    currentDistance--;
  } else if (currentDistance < targetDistance)
  {
    currentDistance++;
  }

  println(currentDistance);
  //---------------------------------------------------
  if (currentDistance <90)
  {
    currentImage = bigImage;
  }
  if (currentDistance > 90 &&
    currentDistance < 180)
  {
    currentImage = mediumImage;
  }
  if (currentDistance > 180)
  {
    currentImage = smallImage;
  }
  //---------------------------------------------------
}
