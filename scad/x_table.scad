include <dimensions.scad>;
use <common.scad>;
use <../MCAD/motors.scad>;
use <rod.scad>;
use <bar.scad>;
use <solenoid.scad>;
use <x_stepper_mount.scad>;
use <../MCAD/hardware.scad>;

module x_carriage() {
  module bushings_extrusion(length, height) {
    square([length, height], center=true);
    translate([length/2 - strap_hole_dim[0]/2 - 0, height/2 - strap_hole_dim[1]/2 + 4]) square(strap_hole_dim, center=true);
    translate([-(length/2 - strap_hole_dim[0]/2 - 0), height/2 - strap_hole_dim[1]/2 + 4]) square(strap_hole_dim, center=true);
    translate([length/2 - strap_hole_dim[0]/2 - 0, -(height/2 - strap_hole_dim[1]/2 + 4)]) square(strap_hole_dim, center=true);
    translate([-(length/2 - strap_hole_dim[0]/2 - 0), -(height/2 - strap_hole_dim[1]/2 + 4)]) square(strap_hole_dim, center=true);
  }

  module z_bar () {
  }

  module bearing_holes() {
    // X bushings extrusion
    translate([carriage_length/2 - 12, x_rods_span/2, 0]) bushings_extrusion(bushings_hole_length, carriage_bushing_hole_width);
    translate([carriage_length/2 - 12, -(x_rods_span/2), 0]) bushings_extrusion(bushings_hole_length, carriage_bushing_hole_width);

    // Screw holes
    //translate([screw_xspan/2, screw_zspan/2, 0]) circle(z_bolt_diam/2);

    // z bushings extrusion
    translate([z_rods_span/2, z_bushings_pos, 0]) rotate([0, 0, 90]) bushings_extrusion(bushings_hole_length, z_bushings_hole_width);
  }

  color("yellow")
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

      // Solenoid holes
      translate([0, solenoid_pos, 0]) rotate([180, 0, 90]) solenoid_holes();
    }

  }
}

module x_table() {
  translate([0, x_table_width/3, 0]) {
    // Carriage plates

    translate([-plate_distance, 0, x_rods_span/2]) rotate([90, 0, 90]) x_carriage();

    // Solenoid
    translate([-plate_distance - board_thickness/2, 0, x_rods_span/2 + solenoid_pos]) rotate([0, -90, 0])  solenoid();

    translate([-plate_distance - z_plate_dist - board_thickness/2, 0, -z_pos]) {
      // Inner Z bar
      translate([0, z_rods_span/2, z_rods_length - board_thickness/2]) rotate([90, 0, 0]) z_bar();
      translate([0, -z_rods_span/2, 0]) rotate([90, 0, 0])  rod_smooth(l=z_rods_length, d=z_rods_diam);
      translate([0, z_rods_span/2, 0]) rotate([90, 0, 0])  rod_smooth(l=z_rods_length, d=z_rods_diam);
    }
    // Z bushings
    translate([-plate_distance - board_thickness/2 - z_plate_dist, -z_rods_span/2, x_rods_span/2 + z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 
    translate([-plate_distance - board_thickness/2 - z_plate_dist, z_rods_span/2, x_rods_span/2 +z_bushings_pos]) import("LM8UU-24_Rev3_-_8.stl"); 

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

x_table();
