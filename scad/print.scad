include <dimensions.scad>;
use <side.scad>;
use <bar.scad>;
use <x_stepper_mount.scad>;
use <x_table.scad>;
use <bottle_grip.scad>;
use <bottle_grip2.scad>;

minkowski() {
  circle(cut_diam/2);
  projection()
  side_r();
  //side_r_bearing_guide();
  //side_r_rod_stop();
  //side_l();
  //side_l_bearing_guide();
  //side_l_rod_stop();
  //mount_plate();
  //rotate([90, 0, 90]) bearing_guide();
  //rotate([90, 0, 90]) bottle_bar();
  //x_carriage();
  //rotate([90, 0, 90]) z_bar();
  //cogs();
  //beltguide();
  //btm_plate();
  //btm_plate2();
  //btm_grip_support();
  //top_grip_support();
  //top_plate();
  //top_plate2();
}
