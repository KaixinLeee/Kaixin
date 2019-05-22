
import processing.serial.*;

PShader blur;
PGraphics src;
PGraphics pass1, pass2;
Serial arduino;
int targetDistance;
int currentDistance;
PImage img;
PImage img2;
PImage img3;
void setup() {

  img = loadImage("moon.jpg"); // Load the original image
  img2 = loadImage("moon2.jpg"); // Load the original image
  img3 = loadImage("big.jpg"); // Load the original image
  arduino=new Serial(this, Serial.list()[0], 115200);
  fill(60);

  size(1980, 1820, P2D);

  blur = loadShader("blur.glsl");
  blur.set("blurSize", 9);
  blur.set("sigma", 5.0f);  

  src = createGraphics(width, height, P2D); 

  pass1 = createGraphics(width, height, P2D);
  pass1.noSmooth();  

  pass2 = createGraphics(width, height, P2D);
  pass2.noSmooth();
}

void draw() {

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
  //println('a');
  //println(currentDistance);
  if (currentDistance < 20)
  {
    image(img, 0, 0);
  }
  if (currentDistance > 20&&currentDistance <50)
  {
    image(img2, 0, 0);
  }
  if (currentDistance > 50)
  {
    image(img3, 0, 0);
  }

  //change image regarding to distance



  blur.set("sigma", 10.*float (currentDistance)/float(width));
  //ellipse(width/2, height/2, currentDistance*5, currentDistance*5);//

  //  //blur.set("sigma", 10.*float (mouseX)/float(width));
  //  src.beginDraw();
  //  src.background(0);
  //  src.fill(255);
  //  //src.ellipse(width/2, height/2, 400, 400);
  //  //image(img, 0, 0); // Displays the image from point (0,0) 
  //  src.endDraw();



  //  // Applying the blur shader along the vertical direction   
  //  blur.set("horizontalPass", 0);
  //  pass1.beginDraw();            
  //  pass1.shader(blur);  
  //  pass1.image(src, 0, 0);
  //  pass1.endDraw();

  //  // Applying the blur shader along the horizontal direction      
  //  blur.set("horizontalPass", 1);
  //  pass2.beginDraw();            
  //  pass2.shader(blur);  
  //  pass2.image(pass1, 0, 0);
  //  pass2.endDraw();    

  //  image(pass2, 0, 0);
  //}

  //void keyPressed() {
  //  if (key == '9') {
  //    blur.set("blurSize", 9);
  //    blur.set("sigma", 5.0);
  //  } else if (key == '7') {
  //    blur.set("blurSize", 7);
  //    blur.set("sigma", 3.0);
  //  } else if (key == '5') {
  //    blur.set("blurSize", 5);
  //    blur.set("sigma", 2.0);
  //  } else if (key == '3') {
  //    blur.set("blurSize", 5);
  //    blur.set("sigma", 1.0);
  //  }
} 
