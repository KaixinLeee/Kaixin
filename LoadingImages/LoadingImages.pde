PImage img;
//---------------------
void setup()
{
  size(400, 400, P2D);
  fill(255);  
  img = loadImage("moon.jpg"); // Load the original image  
}
//---------------------
void draw()
{
  image(img, 0, 0); // Displays the image from point (0,0) 
}
