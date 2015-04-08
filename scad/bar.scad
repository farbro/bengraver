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

module bar2(s=100, width=45, hole_d=8, t=6, m_hole_d=8, s_m=50) {
    difference() {
      hull() {
        translate([s/2, 0]) circle(width/2);
        translate([-s/2, 0, 0]) circle(width/2);
      }
      union() {
        translate([s/2, 0, 0]) circle(hole_d/2);
        translate([-s/2, 0, 0]) circle(hole_d/2);
        translate([0, 0, 0]) circle(m_hole_d/2);
    }
  }
}

module z_bar_inner() {
  linear_extrude(board_thickness, center=true)
  difference() {
    bar2(s=z_rods_span, width=z_bar_width, hole_d=z_rods_diam, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
    translate([z_screws_span/2, 0]) circle(z_screws_diam/2);
    translate([-z_screws_span/2, 0]) circle(z_screws_diam/2);
  }
}

module z_bar_outer() {
  linear_extrude(board_thickness, center=true)
  difference() {
    bar2(s=z_rods_span, width=z_bar_width, hole_d=0, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
    translate([z_screws_span/2, 0]) circle(z_screws_diam/2);
    translate([-z_screws_span/2, 0]) circle(z_screws_diam/2);
  }
}

module bearing_guide() {
  bar(s=bottle_bar_height, width=z_bar_width, hole_d=bottle_rod_diam, t=board_thickness, m_hole_d=bearing_guide_diam, s_m=span_bottle/2);
}

module bottle_bar() {
  bar(s=bottle_bar_height, width=bottle_bar_width, t=board_thickness, hole_d=bottle_rod_diam, s_m=bottle_bar_height/2, m_hole_d=bearing_hole_diam);
}

module z_bar() {
  bar(s=z_rods_span, width=z_bar_width, hole_d=z_rods_diam, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
}

module x_stepper_bar() {
  linear_extrude(board_thickness)
  bar2(s=x_stepper_mount_screw_span, width=20, t=board_thickness, hole_d=5, m_hole_d=0);
}

module z_stepper_bar_inner() {
  linear_extrude(board_thickness, center=true) {
  difference() {
    bar2(s=z_rods_span, width=28.2, hole_d=z_rods_diam, t=board_thickness, m_hole_d=toolbit_mount_diam+1, s_m=z_rods_span/2);
     translate([0,0]) stepper_motor_mount(nema_standard=11, pilot=false, mochup=false);
      translate([z_screws_span/2, 0]) circle(z_screws_diam/2);
      translate([-z_screws_span/2, 0]) circle(z_screws_diam/2);
    }
  }
}

module z_stepper_bar_outer() {
  linear_extrude(board_thickness, center=true) {
  difference() {
    bar2(s=z_rods_span, width=28.2, hole_d=0, t=board_thickness, m_hole_d=toolbit_mount_diam, s_m=z_rods_span/2);
      translate([0,0]) stepper_motor_mount(nema_standard=11, pilot=true);
    translate([z_screws_span/2, 0]) circle(8.8/2, $fn=6);
    translate([-z_screws_span/2, 0]) circle(8.8/2, $fn=6);
    }
  }
}

x_stepper_bar();
