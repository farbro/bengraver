include <dimensions.scad>;
use <../MCAD/nuts_and_bolts.scad>;
use <2dTimingPulleyCutout.scad>;

module beltguide() {
    pulley_beltguide(bottle_pulley_teeth, bottle_axle_diam, board_thickness, 0);
}

module cogs() {
  pulley_cogs(bottle_pulley_teeth, bottle_axle_diam, board_thickness , 0);
}

module bottom_grip() {
  color("yellow") {
    beltguide();
    translate([0, 0, board_thickness]) cogs();
  }

  translate([0, 0, board_thickness*2]) 
  color("darkslategray")
    difference() {
      union() {
        cylinder(r=bottle_grip_bottom_diam/2, h=bottle_grip_bottom_height);
        translate([0, 0, bottle_grip_bottom_height]) cylinder(h=bottle_grip_bottom_cone_height, r1=bottle_grip_bottom_diam/2, r2=bottle_axle_diam/2);
      }
      union() {
        translate([0,0, -1]) cylinder(r=bottle_axle_diam/2, h=bottle_grip_bottom_height+bottle_grip_bottom_cone_height + 2);
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
        translate([0,0,bottle_grip_top_height])  mirror([0,0,0]) resize([0, 0, 50]) circle();
      }
    }
}

$fn=100;
bottom_grip();
