include <dimensions.scad>;
use <../MCAD/servos.scad>;
use <../MCAD/motors.scad>;
use <formulas.scad>;
use <common.scad>;

module belt_guide(inner=true) {
    translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
  translate([-bearing_extrusion_height/2 + plate_distance - board_thickness/2, 0]) {
    square([bearing_extrusion_height, bearing_extrusion_length], center=true);
    if (inner)
      square([bearing_axle_length, bearing_id], center=true);
    else
      square([bearing_axle_length, arc_distance(bearing_id/2, bearing_id/2 - board_thickness/2)], center=true);
      
  }
}

module x_rods_holes() {
    translate(x_top_rod_position) { circle(table_rods_diam/2); }
    translate(x_btm_rod_position) { circle(table_rods_diam/2); }
}

module a_stepper_holes(outline=false) {
  
  translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) 
    if (!outline) nema17_holes(stepper_slide_distance);
    else intersection() {
      square([42.5, 42.5], center=true);
      rotate([0, 0, 45]) square([54, 54], center=true);
    }
}

module 

module side() {
  union() {
  top_x_position = span_bottom -sin(back_tilt_angle)*span_bottle;

    difference() {
        // Base plate
        hull()
        minkowski() {
        circle(holes_margin);
        polygon(points=[
          [0, 0],
          [span_bottom, 0],
          [bottle_top_rod_position[0], bottle_top_rod_position[1]],
          //[break_position[0], break_position[1]],
          [x_top_rod_position[0], x_top_rod_position[1]],
          [x_btm_rod_position[0], x_btm_rod_position[1]],
          [axle_position[0], axle_position[1]],
          [0,0]
          ], convexity=1);
        }
        union() {
        // Holes
        translate(axle_position) circle(front_rod_diam/2);
        translate(bottle_top_rod_position) circle(bottle_rod_diam/2);
        translate([span_bottom, 0, 0]) circle(bottle_rod_diam/2);
        // Foot extrusion
        
        translate([span_bottom/2, -holes_margin]) scale([span_bottom/2-holes_margin/2, bottom_extrusion_height, 1]) circle(1);

        }
      }
    }
}

module side_rm() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_hole_diam/2, center=true);
      translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) nema17_holes(stepper_slide_distance);
      belt_guide(inner=true);
      x_rod_holes();
      a_stepper_holes(outline=false);
    }
  }
}

module side_ri() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_guide_diam/2, center=true);
      a_stepper_holes(outline=false);
      x_rods_holes();
      belt_guide(inner=false);
    }
  }
}

module side_ro() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_guide_diam/2, center=true);
      belt_guide(inner=false);
      a_stepper_holes(outline=true);
    }
  }
}

module side_li() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      x_rods_holes();
    }
  }
}

module side_lo() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
  }
}

module side_lm() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      x_rods_holes();
    }
  }
}

side_l();
