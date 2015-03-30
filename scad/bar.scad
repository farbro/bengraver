use <common.scad>;
include <dimensions.scad>;
use <../MCAD/motors.scad>;

module bar(s=100, width=45, hole_d=8, t=6, m_hole_d=8, s_m=50) {
  color("white")
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

module bearing_guide() {
  bar(s=bottle_bar_height, width=bottle_bar_width, hole_d=bottle_rod_diam, t=board_thickness, m_hole_d=bearing_guide_diam, s_m=span_bottle/2);
}

module bottle_bar() {
  bar(s=bottle_bar_height, width=bottle_bar_width, t=board_thickness, hole_d=bottle_rod_diam, s_m=bottle_bar_height/2, m_hole_d=bearing_hole_diam);
}

module z_bar() {
  bar(s=z_rods_span, width=z_bar_width, hole_d=z_rods_diam, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
}

module z_stepper_bar() {
  rotate([90,-90,180])
  linear_extrude(board_thickness, center=true) {
    difference() {
      projection() rotate([90,0,90]) bar(s=z_rods_span, width=28.2, hole_d=z_rods_diam, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
      translate([z_rods_span/2,0]) stepper_motor_mount(11);
    }
  }
}

z_stepper_bar();
