use <bar.scad>;
use <../MCAD/motors.scad>;
use <../MCAD/stepper.scad>;

module bottle_driver(s=100, t=6) {
  difference() {
    bar(w=40, t=t);
    translate([0, -t/2, s/2]) rotate(-90, [1,0,0]) stepper_motor_mount(nema_standard=17, slide_distance=2);
  }
}
  
bottle_driver();
