/*
    Vairiable Blur: move mouse x position to change amount of blurring
 */
//---------------------------------------------------------------------
PShader blur;
PGraphics src;
PGraphics pass1, pass2;
PImage img;
//---------------------------------------------------------------------
void setup() 
{
  size(320, 360, P2D);

  blur = loadShader("blur.glsl");
  blur.set("blurSize", 9);
  blur.set("sigma", 5.0f);  

  src = createGraphics(width, height, P2D); 
  img = loadImage("moon.jpg"); // Load the original image
  pass1 = createGraphics(width, height, P2D);
  pass1.noSmooth();  

  pass2 = createGraphics(width, height, P2D);
  pass2.noSmooth();
}
//---------------------------------------------------------------------
void draw() 
{
  blur.set("sigma", 5.*float (mouseX)/float(width));
  src.beginDraw();
  src.background(0);
  src.fill(255);  
  src.image(img, 0, 0); // Displays the image from point (0,0) 
  src.endDraw();

  // Applying the blur shader along the vertical direction   
  blur.set("horizontalPass", 0);
  pass1.beginDraw();            
  pass1.shader(blur);  
  pass1.image(src, 0, 0);
  pass1.endDraw();

  // Applying the blur shader along the horizontal direction      
  blur.set("horizontalPass", 1);
  pass2.beginDraw();            
  pass2.shader(blur);  
  pass2.image(pass1, 0, 0);
  pass2.endDraw();    

  image(pass2, 0, 0);
}
//---------------------------------------------------------------------
