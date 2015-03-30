include <dimensions.scad>;
use <common.scad>;
use <../MCAD/motors.scad>;
use <rod.scad>;
use <bar.scad>;
use <solenoid.scad>;
use <x_stepper_mount.scad>;
use <../MCAD/hardware.scad>;
include <timing_belts.scad>;

module belt_clamp() {
  module belt_extrusion() {
    translate([-(carriage_length + carriage_rounding_radius*2)/2, 22/2]) projection(cut=true) mirror([0,1,0]) belt_angle(prf = tGT2_2, bwdth = 1, angle=30, rad=30);
  }

  color("white")
  linear_extrude(board_thickness, center=true)
    difference() {
      intersection() {
        translate([-carriage_length/2 - carriage_rounding_radius, x_stepper_mount_shift - x_stepper_pulley_radius]) square([carriage_length + carriage_rounding_radius*2, x_rods_span/2 - (x_stepper_mount_shift - x_stepper_pulley_radius)]);
        projection() x_carriage();
      }
      {
         belt_extrusion();
         mirror([1, 0, 0]) belt_extrusion();
      }
    }
}

module nut_plate(nut=true) {
  linear_extrude(board_thickness, center=true) {
    difference() {
      union() {
        square([nut_guide_hole_width-0.5, nut_guide_height + board_thickness*2 - 0.5], center=true);
        square([nut_guide_width, nut_guide_height - 0.5], center=true);
      }
      if (nut) circle(8.8/2, $fn=6);
      else circle(z_leadscrew_diam/2);
    }
  }
}

module spring_plate() {
  linear_extrude(board_thickness, center=true) {
    difference() {
      union() {
        square([nut_guide_hole_width, nut_guide_height + board_thickness*2 - 0.5], center=true);
        square([nut_guide_width, nut_guide_height - 0.5], center=true);
      }
      circle(z_leadscrew_diam/2);
    }
  }

}

module x_carriage() {
  module bushings_extrusion(length, height, level=0) {
    square([length, height], center=true);
    //translate([length/2 - strap_hole_dim[0]/2 - 0, height/2 - strap_hole_dim[1]/2 + 4]) square(strap_hole_dim, center=true);
    //translate([-(length/2 - strap_hole_dim[0]/2 - 0), height/2 - strap_hole_dim[1]/2 + 4]) square(strap_hole_dim, center=true);
    //translate([length/2 - strap_hole_dim[0]/2 - 0, -(height/2 - strap_hole_dim[1]/2 + 4)]) square(strap_hole_dim, center=true);
    //translate([-(length/2 - strap_hole_dim[0]/2 - 0), -(height/2 - strap_hole_dim[1]/2 + 4)]) square(strap_hole_dim, center=true);
  }


  module bearing_holes() {
    // X bushings extrusion
    if (level==0 || level==1) {
      translate([carriage_length/2 - 12, x_rods_span/2, 0]) bushings_extrusion(bushings_hole_length, carriage_bushing_hole_width);
      translate([carriage_length/2 - 12, -(x_rods_span/2), 0]) bushings_extrusion(bushings_hole_length, carriage_bushing_hole_width);
    }

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

      // Screw holes
      translate([z_rods_span/2 + z_rods_diam + 1, 0]) circle(carriage_screw_diam/2);
      translate([-(z_rods_span/2 + z_rods_diam + 1), 0]) circle(carriage_screw_diam/2);

      // Nut guide hole
      if (level==1 || level==2) square([nut_guide_hole_width, nut_guide_hole_length], center=true);

      // Solenoid holes
      //translate([0, solenoid_pos, 0]) rotate([180, 0, 90]) solenoid_holes();
    }

  }
}

module x_table() {
  translate([0, x_carriage_pos, 0]) {
    // Carriage plates

    translate([plate_distance, 0, x_rods_span/2]) rotate([90, 0, 90]) x_carriage(level=0);
    translate([-plate_distance, 0, x_rods_span/2]) rotate([90, 0, 90]) x_carriage(level=1);
    translate([-plate_distance - z_plate_dist*2 - board_thickness, 0, x_rods_span/2]) rotate([90, 0, 90]) x_carriage(level=2);
    translate([-plate_distance- z_plate_dist - board_thickness/2, 0, x_rods_span/2 + nut_guide_hole_length/2 - board_thickness/2]) rotate([0,0,90]) nut_plate();
    translate([-plate_distance- z_plate_dist - board_thickness/2, 0, x_rods_span/2 + nut_guide_hole_length/2 - board_thickness]) rotate([0,0,90]) nut_plate(nut=false);
    translate([-plate_distance- z_plate_dist - board_thickness/2, 0, x_rods_span/2 - nut_guide_hole_length/2 + board_thickness/2]) rotate([0,0,90]) spring_plate();
    //translate([-plate_distance - z_plate_dist - board_thickness/2]) rotate([90, 0, 90]) belt_clamp();

    // Solenoid
    //translate([-plate_distance - board_thickness/2, 0, x_rods_span/2 + solenoid_pos]) rotate([0, -90, 0])  solenoid();

    translate([-plate_distance - z_plate_dist - board_thickness/2, 0, -z_pos]) {
      // Inner Z bar
      translate([0, z_rods_span/2, z_rods_length - board_thickness/2]) rotate([90, 0, 0]) z_bar();
      translate([0, z_rods_span/2, board_thickness/2]) rotate([90, 0, 0]) z_stepper_bar();

      // Z rods
      translate([0, -z_rods_span/2, 0]) rotate([90, 0, 0])  rod_smooth(l=z_rods_length, d=z_rods_diam);
      translate([0, z_rods_span/2, 0]) rotate([90, 0, 0])  rod_smooth(l=z_rods_length, d=z_rods_diam);


    }
    // Z bushings
    translate([-plate_distance - board_thickness/2 - z_plate_dist, -z_rods_span/2, x_rods_span/2 + z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 
    translate([-plate_distance - board_thickness/2 - z_plate_dist, z_rods_span/2, x_rods_span/2 +z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 
    translate([-plate_distance - board_thickness/2 - z_plate_dist, -z_rods_span/2, -x_rods_span/2 + z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 
    translate([-plate_distance - board_thickness/2 - z_plate_dist, z_rods_span/2, -x_rods_span/2 +z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 

    // Carriage bushings
    translate([0, carriage_length/2 - 12, 0]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, carriage_length/2 - 12, 0]) translate([0, 0, x_rods_span]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, -(carriage_length/2 - 12), 0]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, -(carriage_length/2 - 12), 0]) translate([0, 0, x_rods_span]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");

  }
  // Table rods
  translate([0,-board_thickness/2-table_rod_ext, 0]) rod_smooth(l=x_table_width+table_rod_ext*2+board_thickness, d=table_rods_diam);
  translate([0,-board_thickness/2-table_rod_ext, x_rods_span]) rod_smooth(l=x_table_width+table_rod_ext*2+board_thickness, d=table_rods_diam);

 // Mount plate
 translate([table_rods_diam/2 + board_thickness/2, x_table_width-x_stepper_mount_length/2 - board_thickness*2, x_rods_span/2]) rotate([90, 90, -90]) mount_plate();
}

//belt_clamp();

x_table();
