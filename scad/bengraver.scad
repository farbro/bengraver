use <clamps_assembly.scad>;
use <rod.scad>;
use <rod_clamp.scad>;
use <MCAD/motors.scad>;

// Engraver size
width=400;
length=100;
z_rods_length=200;


// Clams
clamps_length=100;
clamps_height=40;
clamps_thickness=10;
clamps_outer_dia=15;
clamps_middle_dia=12;
clamps_bolt_dia=3;
clamps_rod_span=60;
clamps_edge_height=21;


complete_table(clamps_length, clamps_height, clamps_thickness, clamps_outer_dia, clamps_middle_dia, clamps_bolt_dia, clamps_rod_span, clamps_edge_height);

// Rods for X table
union() {
  translate([0, -width/2, 0]) rod_threaded(8, width);
  translate([clamps_rod_span/2, -width/2, 0]) rod_smooth(8, width);
  translate([-clamps_rod_span/2, -width/2, 0]) rod_smooth(8, width);
}

// Rods for Z table
translate([0, 0, clamps_edge_height]) rotate([0, 0, 90]) union() {
  translate([0, -z_rods_length/2-30, 0]) rod_threaded(8, z_rods_length);
  translate([clamps_rod_span/2, -z_rods_length/2, 0]) rod_smooth(8, z_rods_length);
  translate([-clamps_rod_span/2, -z_rods_length/2, 0]) rod_smooth(8, z_rods_length);
}

translate([-clamps_length/2, 0, 21]) rotate([0, 90, 0]) stepper_motor_mount(17);

