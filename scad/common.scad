include <dimensions.scad>;

module strap_holes(pos=[0,0], rot=0, span=8) {
  translate(pos) rotate([0,0,rot]) {
    translate([0,-span/2]) square(strap_hole_dim, center=true);
    translate([0,span/2]) square(strap_hole_dim, center=true);
  }
}

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

module endstop(pcb_base=true) {
  // End stop from Sparkfun
  offset=0.3;

  outer=18.6;
  inner=9.9;
  height=15.04;
  inner_height=12.12;
  depth=4.97;
  pcb_width=21.15;
  pcb_length=15.11;
  pcb_thickness=1.56;
  margin=1.6;

  rotate([90, 0, 0]) 
  translate([-outer/2, -(height-inner_height) -offset*3, -depth/2]) {
    color("gray")
    linear_extrude(depth + offset*2)
    offset(0.5)
    difference() {
      square([outer, height]);
      translate([(outer - inner)/2, height - inner_height]) square([inner, inner_height]);
    }
    color("red")
    translate([-(pcb_width-outer)/2, -pcb_thickness, -margin]) cube([pcb_width, pcb_thickness, pcb_length]);
  }


}

endstop();
