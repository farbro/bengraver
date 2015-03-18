include <dimensions.scad>;
use <../MCAD/motors.scad>;
use <common.scad>;

module mount_plate() {
  color("yellow")
  linear_extrude(board_thickness, center=true) 
  difference() {
    minkowski() {
      circle(5);
      square([x_stepper_mount_width, x_stepper_mount_length], center=true);
    }
    union() {
      stepper_motor_mount(17, mochup=false);
      translate([x_rods_span/2 + table_rods_diam/2, x_stepper_mount_length/2 - 7]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 - table_rods_diam/2, x_stepper_mount_length/2 - 7]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 + table_rods_diam/2, -(x_stepper_mount_length/2 - 7)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 - table_rods_diam/2, -(x_stepper_mount_length/2 - 7)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 + table_rods_diam/2), x_stepper_mount_length/2 - 7]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 - table_rods_diam/2), x_stepper_mount_length/2 - 7]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 + table_rods_diam/2), -(x_stepper_mount_length/2 - 7)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 - table_rods_diam/2), -(x_stepper_mount_length/2 - 7)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
    }
  }
    stepper_motor_mount(17);
}

mount_plate();
