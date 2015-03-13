include <dimensions.scad>;
use <bar.scad>;
use <rod.scad>;
use <side.scad>;
use <x_table.scad>;
use <bottle.scad>;
use <bottle_driver.scad>;
use <../MCAD/motors.scad>;
use <bottle_grip.scad>;
use <timingPulley-v2.scad>;

x_table_bar_dist = 3;

// Sides
rotate([90,0,0]) {
  side_r();
  translate([0, 0, -board_thickness]) side_r_bearing_guide();
  translate([bottle_axle_pos[0], bottle_axle_pos[1], board_thickness/2 + 7/2]) import("608zz.stl");
  translate([bottle_axle_pos[0], bottle_axle_pos[1], -(board_thickness/2 + 7/2)]) import("608zz.stl");
}
translate([0, width, 0]) rotate([90, 0, 0]) side_l();
translate([0, width-board_thickness, 0]) rotate([90, 0, 0]) side_l_bearing_guide();

// Front rod
translate([0,-board_thickness/2-rod_ext, 0]) rod_threaded(l=width+rod_ext*2+board_thickness);

// x table
translate([x_btm_rod_position[0], 0, x_btm_rod_position[1]]) rotate([0, x_table_tilt, 0]) x_table();

// Bottle grip
 translate([bottle_axle_pos[0], board_thickness/2+7, bottle_axle_pos[1]]) rotate([-90, 0, 0]) bottom_grip();

 translate([bottle_axle_pos[0], bottle_bar_pos-board_thickness/2-3, bottle_axle_pos[1]]) rotate([90, 0, 0]) top_grip();
 translate([bottle_axle_pos[0], bottle_bar_pos-7/2+board_thickness/2, bottle_axle_pos[1]]) rotate([90, 0, 0]) import("608zz.stl");
 translate([bottle_axle_pos[0], bottle_bar_pos+7+board_thickness, bottle_axle_pos[1]]) rotate([90, 0, 0]) import("608zz.stl");



// Bottle
translate([span_bottom, 0, 0])
  rotate([0, -back_tilt_angle, 0])
union() {
  //translate([0,bottle_pos,span_bottle/2]) rotate(90, [1,0,0]) translate([0, 0, 0]) mirror([0, 0, 1]) bottle();
  // Bottle bar
  translate([0, bottle_bar_pos, 0]) bearing_guide();

  // Bearing guide
  translate([0, bottle_bar_pos+board_thickness+1, 0]) bar(s=bottle_bar_height, width=bottle_bar_width, t=board_thickness, s_m=bottle_bar_height/2);

  // Rods
  translate([0,-board_thickness/2 - nut_t,0]) rod_threaded(d=table_rods_diam, l=width+board_thickness+nut_t*2);
  translate([0,-board_thickness/2 - nut_t,span_bottle]) rod_threaded(d=table_rods_diam, l=width+board_thickness+nut_t*2);
}
