include <dimensions.scad>;
use <common.scad>;

module electronics_mount() {

  module arduino_holes() {
    translate([-50.8/2, -48.2/2]) {
      translate([0,0]) circle(arduino_hole_diam/2);
      translate([50.8,5.1]) circle(arduino_hole_diam/2);
      translate([50.8,5.1+27.9]) circle(arduino_hole_diam/2);
      translate([0,48.2]) circle(arduino_hole_diam/2);
    }
  }

  rounding=5;

  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    minkowski() {
      circle(rounding);
      square([span_bottom-rounding + front_rod_diam/2 + bottle_rod_diam/2 + strap_margin, electronics_mount_length-rounding], center=true);
    }
    {
      translate([-25, 0]) arduino_holes();
      strap_holes(pos=[-span_bottom/2, electronics_mount_length/2 - strap_margin - rounding], rot=90, span=front_rod_diam);
      strap_holes(pos=[-span_bottom/2, -(electronics_mount_length/2 - strap_margin - rounding)], rot=90, span=front_rod_diam);
      strap_holes(pos=[span_bottom/2, electronics_mount_length/2 - strap_margin - rounding], rot=90, span=front_rod_diam);
      strap_holes(pos=[span_bottom/2, -(electronics_mount_length/2 - strap_margin - rounding)], rot=90, span=front_rod_diam);
    }
  }

  
}

electronics_mount();
