include <dimensions.scad>;
use <bar.scad>;
use <rod.scad>;
use <walls.scad>;
use <x_table.scad>;
use <bottle.scad>;
use <bottle_driver.scad>;
use <../MCAD/motors.scad>;
use <bottle_grip.scad>;
use <timingPulley-v2.scad>;
use <../MCAD/bearing.scad>;

x_table_bar_dist = 3;

// Sides
rotate([90,0,0]) {
  //wall_ro();
  translate([0, 0, -board_thickness]) {
    wall_rm();
    translate([0, 0, -board_thickness/2]) endstop_hole();
  }
  translate([0, 0, -2*board_thickness]) wall_ri();
  translate([bottle_axle_pos[0], bottle_axle_pos[1], -board_thickness + 7/2]) bearing();
  translate([bottle_axle_pos[0], bottle_axle_pos[1], -board_thickness*2 - 7/2]) bearing();
  translate([a_stepper_pos[0], a_stepper_pos[1], -board_thickness]) rotate([0, 180, stepper_rotation]) stepper_motor_mount(17);
}
translate([0, width, 0]) rotate([90, 0, 0]) wall_lo();
translate([0, width-board_thickness, 0]) rotate([90, 0, 0]) wall_lm();
translate([0, width-2*board_thickness, 0]) rotate([90, 0, 0]) wall_li();

// Front rod
translate([0,-board_thickness/2-rod_ext, 0]) rod_threaded(d=front_rod_diam, l=width+rod_ext*2+board_thickness);

// x table
translate([x_btm_rod_position[0], board_thickness, x_btm_rod_position[1]]) rotate([0, 90 + x_table_tilt, 0])  {
  x_table();
  translate([- plate_distance + board_thickness/2, board_thickness/2,  x_rods_span/2]) rotate([0, 90, 0]) {
    bearing();
    rotate([90, 0, 0]) translate([0, -(bearing_axle_length-bearing_extrusion_height)/2, 0]) rod_smooth(d=8, l=bearing_axle_length);
  }
}

// Bottle grip
 translate([bottle_axle_pos[0], board_thickness*2+10, bottle_axle_pos[1]]) rotate([-90, 0, 0]) bottom_grip();

 translate([bottle_axle_pos[0], bottle_bar_pos-board_thickness/2-3, bottle_axle_pos[1]]) rotate([90, 0, 0]) top_grip();
 translate([bottle_axle_pos[0], bottle_bar_pos-7/2+board_thickness/2, bottle_axle_pos[1]]) rotate([90, 0, 0]) bearing();
 translate([bottle_axle_pos[0], bottle_bar_pos+7+board_thickness*2, bottle_axle_pos[1]]) rotate([90, 0, 0]) bearing();



// Bottle
translate([span_bottom, 0, 0])
  rotate([0, -back_tilt_angle, 0])
union() {
  translate([0,bottle_pos,span_bottle/2]) rotate(90, [1,0,0]) translate([0, 0, 0]) mirror([0, 0, 1]) bottle();
  // Bottle bar
  translate([0, bottle_bar_pos, 0]) bearing_guide();

  // Bearing guide
  translate([0, bottle_bar_pos+board_thickness, 0]) bottle_bar();
  translate([0, bottle_bar_pos+board_thickness*2, 0]) bearing_guide();

  // Rods
  translate([0,-board_thickness/2 - nut_t,0]) rod_threaded(d=bottle_rod_diam, l=width+board_thickness+nut_t*2);
  translate([0,-board_thickness/2 - nut_t,span_bottle]) rod_threaded(d=bottle_rod_diam, l=width+board_thickness+nut_t*2);
}
