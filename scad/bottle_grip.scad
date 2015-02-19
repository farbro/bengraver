include <dimensions.scad>;
include <../MCAD/nuts_and_bolts.scad>;

module bottom_grip() {
  color("darkslategray")
    difference() {
      union() {
        cylinder(r=bottle_grip_bottom_diam/2, h=bottle_grip_bottom_height);
        translate([0, 0, bottle_grip_bottom_height]) cylinder(h=bottle_grip_bottom_cone_height, r1=bottle_grip_bottom_diam/2, r2=10);
      }
      union() {
        translate([0,0,-0.01]) boltHole(size=bottle_axle_diam, length=bottle_grip_bottom_height+bottle_grip_bottom_cone_height);
        translate([0,0,bottle_grip_bottom_height+bottle_grip_bottom_cone_height+0.01]) mirror([0,0,1]) nutHole(size=bottle_axle_diam);
      }
    }
}

module top_grip() {
  color("darkslategray")
    difference() {
      union() {
        cylinder(r=bottle_grip_top_diam/2, h=bottle_grip_top_height+bottle_grip_top_cone_height-0.001);
      }
      union() {
        translate([0, 0, bottle_grip_top_height+0.01]) cylinder(h=bottle_grip_top_cone_height, r2=bottle_grip_top_inner_diam/2, r1=0);
        translate([0,0,-0.01]) boltHole(size=bottle_axle_diam, length=bottle_grip_top_height+bottle_grip_top_cone_height);
        translate([0,0,bottle_grip_top_height])  mirror([0,0,0]) resize([0, 0, 50]) nutHole(size=bottle_axle_diam);
      }
    }
}

$fn=100;
top_grip();
