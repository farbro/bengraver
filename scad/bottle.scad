include <dimensions.scad>;

module bottle() {
  nd=bottle_diam*0.15;
  t=3;
  module shape() {
    // Main shape
    polygon(points=[[t, bottle_height/20], [bottle_diam/2, 0], [bottle_diam/2, bottle_height*2/3], [nd, bottle_height*5/6], [nd, bottle_height], [0, bottle_height]]);
    // Bottle neck things
    translate([nd+t/4, bottle_height*1]) circle(t/4);
    translate([nd+t/4, bottle_height*0.96]) circle(t/4);
  }
  

  //Rotational extrude
  color("DarkGreen", 0.5)
    rotate_extrude(convexity=4, $fn=100)
      minkowski() {
        circle(3);
        difference() {
          shape();
          translate([-0.01, 0.01, 0]) shape();
        }
      }
}

translate([0, 0, 10]) bottle();
