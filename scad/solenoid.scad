include <dimensions.scad>;

module solenoid() {
  
  translate([0, 0, solenoid_dim[2]/2]) {
    color("darkgray") cube(solenoid_dim, center=true);
    translate([-solenoid_dim[0]/2, 0, 0]) rotate([0, 90, 0]) color("gray")  cylinder(r=7/2, h=47);
  }
  solenoid_holes();
}

module solenoid_holes() {
  translate([1, 0, 0]) {
    translate([14.5/2, -12.0/2, 0]) circle(3/2);
    translate([-14.5/2, 12.0/2, 0]) circle(3/2);
  }
}

solenoid();
  
