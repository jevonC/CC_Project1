class Brick {
  float x, x1, x2, x3, x4; //a core x value and its randomisers
  float y, y1, y2, y3, y4; //a core y value and its randomisers
  float sY; //transferring scalarY into Brick class
  float z;
  float lineOpacity=225; //opacity of line, will decrease as bricks recede
  float speedFall; //speed at which each brick falls, before receding into background
  float t=10; //thickness of each brick

  //values for blooming dots
  float r=0; //will increase in value, causing dots to spin outwards
  float theta=0; //will increase in value, causing dots to spin at all
  float opacity=200; //opacity of blooming dots, will decrease in value, causing further dots to fade

  Brick(float x_, float y_, float sY_, float x1_, float x2_, float x3_, float x4_, float y1_, float y2_, float y3_, float y4_) {
    x=x_;
    y=y_;
    sY=sY_;
    x1=x1_;
    x2=x2_;
    x3=x3_;
    x4=x4_;
    y1=y1_;
    y2=y2_;
    y3=y3_;
    y4=y4_;
    speedFall=0;
  }

  void move() { //all x,y,z values change HERE   
    y=y+speedFall; //add speedFall to y location
    speedFall=speedFall+gravity; //add gravity to speedFall

    //if Brick reaches the bottom, start receding
    if (y>height) {    //i.e. when Brick reaches bottom
      y=height+1; //just to ensure that y remains more than height...
      //recede into distance, z-value decreases
      z-=(2-sY)*100; //the broader the building, the bigger the sY, the more defined its "tunnel" looks
    }
  }

  void display() { //Display the Brick
    //when Brick hasn't disappeared (it tends to disappear z=~-4650)
    if (z>=-4650) {
      //each Brick is made up of 8 corners, 4 in top layer and 4 in bottom layer
      //each Brick is but a wireframe
      strokeWeight(1);
      stroke(255, lineOpacity);
      lineOpacity-=2; //lineOpacity decreases as z increases, avoids making the page look too white
      noFill();

      pushMatrix(); //localising each Brick with its own translation
      translate(x, y, z);

      //top layer of Brick
      beginShape();
      vertex(-x1, -y1); //top-left corner (of top layer)
      vertex(x2, -y2); //top-right corner (of top layer)
      vertex(x3, y3); //bottom-right corner (of top layer)
      vertex(-x4, y4); //bottom-left corner (of top layer)
      endShape(CLOSE);

      //lines joining corners of 2 layers
      line(-x1, -y1, -x1, -y1+t); //joins the 2 top-left corners
      line(x2, -y2, x2, -y2+t); //joins the 2 top-right corners
      line(x3, y3, x3, y3+t); //joins the 2 bottom-right corners
      line(-x4, y4, -x4, y4+t); //joins the 2 bottom-left corners

      //bottom layer of Brick
      beginShape();
      vertex(-x1, -y1+t); //top-left corner (of bottom layer)
      vertex(x2, -y2+t); //top-right corner (of bottom layer)
      vertex(x3, y3+t); //bottom-right corner (of bottom layer)
      vertex(-x4, y4+t); //bottom-left corner (of bottom layer)
      endShape(CLOSE);  
      popMatrix();
    }

    //when Brick has disappeared (z=~4650 or so)
    //below are codes for blooming dots (modified from example 13-5 in "Learning Processing")
    if (z<-4650) {
      //each set of blooming dots are translated along the x and y-axis but NOT z-axis (if it is, then things will be too small and I cannot get them to bloom across whole screen)
      pushMatrix();      
      //mapping x-values at z=-4650 to their x-value equivalents at z=0
      float tinyX=map(x, 0, 1400, 635, 765); //at z=-4650, x ranges only from 635 to 765
      translate(tinyX, 330);
      float spinX=r*cos(theta); 
      float spinY=r*sin(theta);
      float spinOpacity=map(sY, 0.5, 1.5, 1.0, 0.18); //spinOpacity scalar based on sY, inversely mapped - taller buildings' dots bloom wider

      noStroke();
      fill(255, opacity);
      ellipse(spinX, spinY, 4, 4); //adjusted for translation

      theta += 1.5; //increases the angle
      r+=0.75; //increases the radius
      opacity-=spinOpacity; //decreases opacity as affected by sOpacity

      popMatrix();
    }
  }
}