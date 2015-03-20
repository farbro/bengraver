include <dimensions.scad>;
use <../MCAD/motors.scad>;
use <common.scad>;

module mount_plate() {
  strap_margin=3;
  color("white")
  linear_extrude(board_thickness, center=true) 
  difference() {
    minkowski() {
      circle(5);
      square([x_stepper_mount_width - 5, x_stepper_mount_length - 5], center=true);
    }
    union() {
      translate([-x_stepper_mount_shift, 0]) 
      stepper_motor_mount(17, mochup=false);
      translate([x_rods_span/2 + table_rods_diam/2, x_stepper_mount_length/2 - strap_margin]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 - table_rods_diam/2, x_stepper_mount_length/2 - strap_margin]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 + table_rods_diam/2, -(x_stepper_mount_length/2 - strap_margin)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([x_rods_span/2 - table_rods_diam/2, -(x_stepper_mount_length/2 - strap_margin)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 + table_rods_diam/2), x_stepper_mount_length/2 - strap_margin]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 - table_rods_diam/2), x_stepper_mount_length/2 - strap_margin]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 + table_rods_diam/2), -(x_stepper_mount_length/2 - strap_margin)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 - table_rods_diam/2), -(x_stepper_mount_length/2 - strap_margin)]) rotate([0,0,90]) square(strap_hole_dim, center=true); 

      translate([x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin, -(x_stepper_mount_length/2)]) square(strap_hole_dim, center=true); 
      translate([-(x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin), -(x_stepper_mount_length/2)]) square(strap_hole_dim, center=true); 
    }
  }
    translate([-x_stepper_mount_shift, 0]) 
    stepper_motor_mount(17);
}

mount_plate();
