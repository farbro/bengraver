include <dimensions.scad>;
use <bar.scad>;
use <rod.scad>;
use <walls.scad>;
use <x_table.scad>;
use <bottle.scad>;
use <bottle_driver.scad>;
use <../MCAD/motors.scad>;
use <bottle_grip.scad>;
use <electronics_mount.scad>;
use <timingPulley-v2.scad>;
use <../MCAD/bearing.scad>;
use <nutroller.scad>;

x_table_bar_dist = 3;

// Sides
rotate([90,0,0]) {
  wall_ro();

  // Bearing guide
translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
translate([-2,0]) rotate([90,0,0]){
  translate([0,0,-7/2]) bearing();
}
  translate(belt_tensioner_position) belt_tensioner();
  translate([0, 0, -board_thickness]) {
    wall_rm();
    translate([0, 0, -board_thickness/2]) endstop_hole();
    translate([belt_tensioner_position[0], belt_tensioner_position[1] - belt_tensioner_stroke/2, 0]) {
      translate([0, 0, board_thickness*1.5 + rod_ext]) rotate([-90, 0, 0]) rod_threaded(d=belt_tensioner_bolt_diam, l=rod_ext*2 + board_thickness*3 + belt_tensioner_elevation + 7);
      translate([0, 0, -board_thickness*1.5 - belt_tensioner_elevation - 7]) bearing();

    }
  }

  translate([0, 0, -2*board_thickness]) {
    wall_ri();
    translate(belt_tensioner_position) belt_tensioner();
  }

  translate([bottle_axle_pos[0], bottle_axle_pos[1], -board_thickness + 7/2]) bearing();
  translate([bottle_axle_pos[0], bottle_axle_pos[1], -board_thickness*2 - 7/2]) bearing();
  translate([a_stepper_pos[0], a_stepper_pos[1], -board_thickness]) { 
    rotate([0, 180, stepper_rotation]) stepper_motor_mount(17);

  }
}
translate([0, width, 0]) rotate([90, 0, 0]) wall_lo();
translate([0, width-board_thickness, 0]) rotate([90, 0, 0]) wall_lm();
translate([0, width-2*board_thickness, 0]) rotate([90, 0, 0]) wall_li();

// Front rod
translate([0,-board_thickness/2-rod_ext, 0]) rod_threaded(d=front_rod_diam, l=width+rod_ext*2+board_thickness);

// x table
translate([bottle_axle_pos[0], width/2, bottle_axle_pos[1]]) rotate([0, x_table_tilt]) translate([-x_a_distance, 0, 0]) rotate([0,0,-90]) x_table();


// Bottle grip
 translate([bottle_axle_pos[0], board_thickness*2.5 + 2.3, bottle_axle_pos[1]]) rotate([-90, 0, 0]) bottom_grip();

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
  translate([0, bottle_bar_pos+board_thickness, 0]) bottle_bar();
  translate([0, bottle_bar_pos+board_thickness*2, 0]) bearing_guide();
  translate([0, bottle_bar_pos+board_thickness*2.5, 0]) rotate([-90, 0, 0]) nutroller();
  translate([0, bottle_bar_pos+board_thickness*2.5, span_bottle]) rotate([-90, 0, 0]) nutroller();

  // Rods
  translate([0,-board_thickness/2 - nut_t,0]) rod_threaded(d=bottle_rod_diam, l=width+board_thickness+nut_t*2);
  translate([0,-board_thickness/2 - nut_t,span_bottle]) rod_threaded(d=bottle_rod_diam, l=width+board_thickness+nut_t*2);
}

translate([span_bottom/2, electronics_mount_pos, -front_rod_diam/2 - board_thickness/2]) electronics_mount();
