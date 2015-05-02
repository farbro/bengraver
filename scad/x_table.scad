include <dimensions.scad>;
use <common.scad>;
use <../MCAD/motors.scad>;
use <rod.scad>;
use <bar.scad>;
use <solenoid.scad>;
use <x_stepper_mount.scad>;
use <../MCAD/hardware.scad>;
include <timing_belts.scad>;
use <vslot.scad>;

module nut_plate(nut=true) {
  linear_extrude(board_thickness, center=true) {
    difference() {
      union() {
        square([nut_guide_hole_width, nut_guide_height + board_thickness*2 - 0.5], center=true);
        square([nut_guide_width, nut_guide_height - 0.5], center=true);
      }
      if (nut) circle(9.1/2, $fn=6);
      else circle(z_leadscrew_diam/2);
    }
  }
}

module spring_plate() {
  linear_extrude(board_thickness, center=true) {
    difference() {
      union() {
        square([nut_guide_hole_width+0.2, nut_guide_height + board_thickness*2 - 0.5], center=true);
        square([nut_guide_width, nut_guide_height - 0.5], center=true);
      }
      circle(z_leadscrew_diam/2);
    }
  }

}

module x_carriage() {
  module bushings_extrusion(length, height, level=0) {
    square([length, height], center=true);
  }

  module bearing_holes() {
    // z bushings extrusion
    if (level==1 || level==2) {
      translate([z_rods_span/2, z_bushings_pos, 0]) rotate([0, 0, 90]) bushings_extrusion(bushings_hole_length, z_bushings_hole_width);
      translate([z_rods_span/2, -z_bushings_pos, 0]) rotate([0, 0, 90]) bushings_extrusion(bushings_hole_length, z_bushings_hole_width);
    }
  }

  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    minkowski() {
      circle(carriage_rounding_radius);
      square([carriage_length, carriage_height], center=true);
    }
    
    // Extrude holes for bearings
    union() {
      bearing_holes();
      mirror([1, 0, 0]) bearing_holes();

      // Nut guide hole
      if (level==1 || level==2) {
        square([nut_guide_hole_width, nut_guide_hole_length], center=true);
        translate([0, -carriage_height/2 - carriage_rounding_radius]) square([10.5, 10*2], center=true);
      }

      // Screw holes
      translate([carriage_screw_span_x/2, carriage_screw_span/2]) circle(carriage_screw_diam/2);
      translate([-carriage_screw_span_x/2, carriage_screw_span/2]) circle(carriage_screw_diam/2);
      translate([carriage_screw_span_x/2, -carriage_screw_span/2]) circle(carriage_screw_diam/2);
      translate([-carriage_screw_span_x/2, -carriage_screw_span/2]) circle(carriage_screw_diam/2);

      
      if (level==0 || level==1) {
        //translate([0, carriage_screw_span/2]) circle(carriage_screw_diam/2);
        //translate([0, -carriage_screw_span/2]) circle(carriage_screw_diam/2);
      }
      if (level==1) {
        translate([carriage_length/2,0]) square([7, beltWidth + 0.5], center=true);
        translate([-carriage_length/2,0]) square([7, beltWidth + 0.5], center=true);
      }

      if (level==2) {
        translate([carriage_length/2-3,0]) square([2, beltWidth + 0.5], center=true);
        translate([carriage_length/2,0]) circle(2.9/2);

        translate([-carriage_length/2+3,0]) square([2, beltWidth + 0.5], center=true);
        translate([-carriage_length/2,0]) circle(2.9/2);
      }
    }
  }
}

module x_table() {
  translate([0,0,-carriage_base_dist-z_plate_dist-board_thickness/2]) {
  translate([x_carriage_pos, 0]) {
  translate([0,0,-carriage_base_dist]) {
    x_carriage(level=0);
    translate([carriage_screw_span_x/2, carriage_screw_span/2, -board_thickness/2-4]) rotate([90, 0, 0]) rod_threaded(d=5, l=carriage_base_dist*2 + z_plate_dist*2 + board_thickness*3 + 4);
    translate([-carriage_screw_span_x/2, carriage_screw_span/2, -board_thickness/2-4]) rotate([90, 0, 0]) rod_threaded(d=5, l=carriage_base_dist*2 + z_plate_dist*2 + board_thickness*3 + 4);
    translate([carriage_screw_span_x/2, -carriage_screw_span/2, -board_thickness/2-4]) rotate([90, 0, 0]) rod_threaded(d=5, l=carriage_base_dist*2 + z_plate_dist*2 + board_thickness*3 + 4);
    translate([-carriage_screw_span_x/2, -carriage_screw_span/2, -board_thickness/2-4]) rotate([90, 0, 0]) rod_threaded(d=5, l=carriage_base_dist*2 + z_plate_dist*2 + board_thickness*3 + 4);
  }

  translate([0,0,carriage_base_dist]) {
    x_carriage(level=1);
    translate([0,0,z_plate_dist+board_thickness/2]) {
      // Z bushings
      translate([z_rods_span/2, z_bushings_pos]) rotate([90,0,0]) import("LM8UU-24_Rev3_-_8.stl"); 
      translate([-z_rods_span/2, z_bushings_pos]) rotate([90,0,0]) import("LM8UU-24_Rev3_-_8.stl"); 
      translate([z_rods_span/2, -z_bushings_pos]) rotate([90,0,0]) import("LM8UU-24_Rev3_-_8.stl"); 
      translate([-z_rods_span/2, -z_bushings_pos]) rotate([90,0,0]) import("LM8UU-24_Rev3_-_8.stl"); 

      translate([z_rods_span/2, -z_rods_length/2 + z_pos]) rod_smooth(d=8, l=z_rods_length);
      translate([-z_rods_span/2, -z_rods_length/2 + z_pos]) rod_smooth(d=8, l=z_rods_length);
      translate([0, -z_rods_length/2 + z_pos]) rod_smooth(d=5, l=z_rods_length*0.7);

      translate([0,nut_guide_hole_length/2 - board_thickness/2]) rotate([90,0]) nut_plate(nut=true);
      translate([0,nut_guide_hole_length/2 - board_thickness]) rotate([90,0]) nut_plate(nut=false);
      translate([0,-(nut_guide_hole_length/2 - board_thickness/2)]) rotate([90,0]) spring_plate(nut=false);

      translate([0, -z_rods_length/2 + board_thickness/2 + z_pos, 0]) rotate([-90,0,0]) z_stepper_bar_inner();
      translate([0, -z_rods_length/2 + board_thickness/2 + z_pos - board_thickness, 0]) rotate([-90,0,0]) z_stepper_bar_outer();
      translate([0, z_rods_length/2 - board_thickness/2 + z_pos, 0]) rotate([90,0,0]) z_bar_outer();
      translate([0, z_rods_length/2 - board_thickness/2 + z_pos - board_thickness, 0]) rotate([90,0,0]) z_bar_inner();
    }
  }

  translate([0,0,carriage_base_dist + z_plate_dist*2 + board_thickness]) {
    x_carriage(level=2);
  }
  }
    
 translate([-x_table_width/2,0]) rotate([90,0,90]) vslot20x40(x_table_width);
 }
}

x_table();
