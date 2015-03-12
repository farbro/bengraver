include <dimensions.scad>;
use <common.scad>;
use <../MCAD/motors.scad>;
use <rod.scad>;
use <bar.scad>;
use <solenoid.scad>;

module x_carriage() {
      module bearing_holes() {
        translate([carriage_length/2 - 12, span_rods/2, 0]) square([24.2, carriage_bushing_hole_width], center=true);
        translate([carriage_length/2 - 12, -(span_rods/2), 0]) square([24.2, carriage_bushing_hole_width], center=true);
        translate([0, z_rods_span/2, 0]) circle(15.2/2);
        translate([0, - z_rods_span/2, 0]) circle(15.2/2);
        translate([carriage_length/2 - 5, 0, 0]) square([5.65, nut_hole_width], center=true);
      }

  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    minkowski() {
      circle(carriage_rounding_radius);
      square([carriage_length, span_rods + table_rods_diam], center=true);
    }
    
    // Extrude holes for bearings
    union() {

      bearing_holes();
      mirror([1, 0, 0]) bearing_holes();
    }

  }
}

module x_table() {
  translate([0, width/3, 0]) {
    // Carriage plates

    translate([plate_distance, 0, span_rods/2]) rotate([90, 0, 90]) x_carriage();
    translate([-plate_distance, 0, span_rods/2]) rotate([90, 0, 90]) x_carriage();

    // Solenoid
    translate([-(plate_distance+board_thickness/2), 0, span_rods/2]) rotate([0, -90, 0]) rotate([0, 0, 90])  solenoid();

    // Outer Z bar
    translate([-z_pos + board_thickness/2, 0, span_rods/2 - z_rods_span/2]) rotate([0, 0, 90]) bar(s=z_rods_span, width=z_bar_width, hole_d=z_rods_diam, t=board_thickness, m_hole_d=8, s_m=z_rods_span/2);

    // Inner Z bar
    translate([-z_pos+z_rods_length - board_thickness/2, 0, span_rods/2 - z_rods_span/2]) rotate([0, 0, 90]) bar(s=z_rods_span, width=z_bar_width, hole_d=z_rods_diam, t=board_thickness, m_hole_d=8, s_m=z_rods_span/2);

    // Carriage bushings
    translate([0, carriage_length/2 - 12, 0]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, carriage_length/2 - 12, 0]) translate([0, 0, span_rods]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, -(carriage_length/2 - 12), 0]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");
    translate([0, -(carriage_length/2 - 12), 0]) translate([0, 0, span_rods]) rotate([90, 0, 0]) import("LM8UU-24_Rev3_-_8.stl");

    // Z bushings
    translate([0, 0, span_rods/2 + z_rods_span/2]) {
      rotate([0, 90, 0]) import("LM8UU-24_Rev3_-_8.stl"); 
      rotate([90, 90, 0]) translate([0, -z_pos, 0]) rod_smooth(l=z_rods_length, d=z_rods_diam);
    }
    translate([0, 0, span_rods/2-z_rods_span/2]) {
      rotate([0, 90, 0]) import("LM8UU-24_Rev3_-_8.stl");
      rotate([90, 90, 0]) translate([0, -z_pos, 0]) rod_smooth(l=z_rods_length, d=z_rods_diam);
    }
  }

  // Table rods
  translate([0,-board_thickness/2-table_rod_ext, 0]) rod_smooth(l=width+table_rod_ext*2+board_thickness);
  translate([0,-board_thickness/2-table_rod_ext, span_rods]) rod_smooth(l=width+table_rod_ext*2+board_thickness);
  translate([0,-board_thickness/2-table_rod_ext, span_rods/2]) rod_threaded(l=width+table_rod_ext*2+board_thickness);
}

x_table();
