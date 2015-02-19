include <dimensions.scad>;
use <common.scad>;
use <../MCAD/motors.scad>;
use <rod.scad>;
use <bar.scad>;

module arm() {
    difference() {
      union() {
        hull() {
          circle(bottom_arm_width/2);
          translate([0, span_axis, 0]) circle(arm_width/2);
        }
        translate([0, span_axis, 0]) 
        rotate([0, 0, -arm_bending])
        hull() {
          circle(arm_width/2);
          translate([0, span_rods, 0]) circle(top_arm_width/2);
        }
      }
      // Holes
      union() {
        circle(front_rod_diam/2);
        translate([0, span_axis, 0]) circle(table_rods_diam/2);
        translate([0, span_axis, 0])
          rotate([0, 0, -arm_bending])
            translate([0, span_rods, 0]) 
              circle(table_rods_diam/2);
      }
        
    }
}

module arm_l() {
  rotate([90, 0, 0]) 
    union() {
  color("gold")
  linear_extrude(board_thickness, center=true) {
    difference() {
      arm();
      translate([0, span_axis, 0])
        rotate([0, 0, -arm_bending/2])
          //translate([0, span_rods/2, 0]) 
            rotate([0, 0, 90])
              nema17_holes(1);
    }

  }
      translate([0, span_axis, 0])
        rotate([0, 0, -arm_bending/2])
          //translate([0, span_rods/2, 0]) 
            rotate([0, 0, 90])
              rotate([180, 0, 0])
                stepper_motor_mount(nema_standard=17, slide_distance=1);
      }
}

module arm_r() {
  color("gold")
  rotate([90, 0, 0]) 
  linear_extrude(board_thickness, center=true) {
    difference() {
      arm();
    }
  }
}

module x_table() {
  // Bars
  arm_r();
  translate([0,width,0]) arm_l();
  
  //Axis rod
  translate([0,-board_thickness/2-rod_ext,0]) rod_threaded(front_rod_diam, width+rod_ext*2+board_thickness);

  // Table rods
  translate([0,-board_thickness/2-table_rod_ext, span_axis]) rod_smooth(l=width+table_rod_ext*2+board_thickness);
  translate([0, -board_thickness/2-table_rod_ext, span_axis])
    rotate([0, arm_bending, 0])
      translate([0, 0, span_rods]) 
        rod_smooth(l=width+table_rod_ext*2+board_thickness);
}

x_table();
