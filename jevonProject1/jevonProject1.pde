Brick[] bricks=new Brick[1]; //declaring Brick class and bricks array, currently of size 1
float gravity=0.3; //gravity for bricks[i].move

void setup() {
  size(1400, 600, P3D);
  background(0); //background is not to be refreshed
  smooth();
  frameRate(60); //just to be sure!
  bricks[0]=new Brick(width/2, 0, 1.5, random(100), random(100), random(100), random(100), random(15), random(15), random(15), random(15)); //Initialise bricks array
}

void draw() {
  stroke(255);
  strokeWeight(1);
  
  //display ALL bricks
  for (int i=0; i<bricks.length; i++) {
    bricks[i].move();
    bricks[i].display();    
  }
}

void mousePressed() {
  //scalarY created to tweak other variables later, mainly broadness of buildings
  float scalarY=map(mouseY, 0, 600, 1.5, 0.5); //inversely mapped: taller buildings => larger scalarY 

  //scalarY tweaks size of random brackets, potentially making building corners more far flung
  Brick b = new Brick(mouseX, mouseY, scalarY, scalarY*random(100), scalarY*random(100), scalarY*random(100), scalarY*random(100), scalarY*random(15), scalarY*random(15), scalarY*random(15), scalarY*random(15));
  
  //Append new Brick object to array
  bricks=(Brick[])append(bricks, b);
}