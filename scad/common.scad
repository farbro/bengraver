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

module endstop(pcb_base=true) {
  // End stop from Sparkfun
  outer=18.6;
  inner=9.9;
  height=15.04;
  inner_height=12.12;
  depth=4.97;
  pcb_width=20.15;
  pcb_length=15.11;
  pcb_thickness=1.56;

  rotate([90, 0, 0]) 
  translate([-outer/2, -(height-inner_height), -depth/2]) {
    color("gray")
    linear_extrude(depth)
    difference() {
      square([outer, height]);
      translate([(outer - inner)/2, height - inner_height]) square([inner, inner_height]);
    }
    color("red")
    translate([-(pcb_width-outer)/2, -pcb_thickness, -(pcb_width-outer)/2]) cube([pcb_width, pcb_thickness, pcb_length]);
  }


}

endstop();
