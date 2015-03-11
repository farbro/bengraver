use <common.scad>;
use <dimensions.scad>;
use <../MCAD/motors.scad>;

module bar(s=100, width=45, hole_d=8, t=6, m_hole_d=8, s_m=50) {
  color("yellow")
  rotate(-90, [0,1,0])
  rotate(90, [1,0,0]) 
  linear_extrude(6, center=true) {
    difference() {
      hull() {
        circle(width/2);
        translate([s, 0, 0]) circle(width/2);
      }
      union() {
        circle(hole_d/2);
        translate([s, 0, 0]) circle(hole_d/2);
        translate([s_m, 0, 0]) circle(m_hole_d/2);

      }
    }
  }
}



bar();
