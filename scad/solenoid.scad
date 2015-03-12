include <dimensions.scad>;

module solenoid() {
  color("darkblue") translate([-27/2, -25/2]) cube([27, 25, 22]);
  color("gray")  cylinder(r=7/2, h=47);
}

solenoid();
  
