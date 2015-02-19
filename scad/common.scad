include <dimensions.scad>;

module nema17_holes(slide) {
  shaft_d = 22;
  screw_d=3;
  s=31;

  module screwhole() {
    hull() {
     translate([-slide/2,0,0]) circle(r=screw_d/2, center=true);
     translate([slide/2,0,0]) circle(h=depth, r=screw_d/2, center=true);
    }
  }

  translate([s/2,s/2,0]) screwhole();
  translate([-s/2,s/2,0]) screwhole();
  translate([s/2,-s/2,0]) screwhole();
  translate([-s/2,-s/2,0]) screwhole();

  circle(r=shaft_d/2, center=true);
}
