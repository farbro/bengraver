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

module endstop_hole() {
  translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
  translate([plate_distance, - carriage_height/2])  
  rotate([180, 0, 180]) {
      endstop();
  }

}

module cable_channel(points) {
  for (i=[1:len(points)-1]) {
    hull() {
      translate([points[i][0], points[i][1]]) circle(cable_diam/2);
      translate([points[i-1][0], points[i-1][1]]) circle(cable_diam/2);
    }
  }
}

module x_stepper_strap_holes() {
  translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
  translate([-table_rods_diam/2 - board_thickness/2, 0]) { 
    translate([board_thickness/2 + strap_hole_dim[1]/2, x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin]) rotate([0, 0, 90]) square(strap_hole_dim, center=true);
    translate([-(board_thickness/2 + strap_hole_dim[1]/2), x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin]) rotate([0, 0, 90]) square(strap_hole_dim, center=true);

    translate([board_thickness/2 + strap_hole_dim[1]/2, -(x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin)]) rotate([0, 0, 90]) square(strap_hole_dim, center=true);
    translate([-(board_thickness/2 + strap_hole_dim[1]/2),-(x_rods_span/2 - table_rods_diam/2 - strap_hole_dim[0] - strap_margin)]) rotate([0, 0, 90]) square(strap_hole_dim, center=true);
  }
}

module a_stepper_holes(outline=false) {
  
  translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) 
    if (!outline) nema17_holes(stepper_slide_distance);
    else intersection() {
      square([42.5, 42.5], center=true);
      rotate([0, 0, 45]) square([54, 54], center=true);
    }
}

module wall() {
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

module wall_rm() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_hole_diam/2, center=true);
      translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) nema17_holes(stepper_slide_distance);
      belt_guide(inner=true);
      x_rods_holes();
      a_stepper_holes(outline=false);
      endstop_hole(inner=true, show=false);
      projection(cut=false) endstop_hole();
      cable_channel(points=[[front_rod_diam*2, 0], [a_stepper_pos[0] - 23, a_stepper_pos[1]], [75, 45]]);
      cable_channel(points=[[75, 40], x_top_rod_position]);
      cable_channel(points=[[front_rod_diam*2, 0], x_btm_rod_position]);
    }
  }
}

module wall_ri() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_guide_diam/2, center=true);
      a_stepper_holes(outline=false);
      x_rods_holes();
      belt_guide(inner=false);
      projection(cut=true) endstop_hole();
      translate([front_rod_diam*2,cable_diam/2]) circle(5/2);
    }
  }
}

module wall_ro() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_guide_diam/2, center=true);
      belt_guide(inner=false);
      a_stepper_holes(outline=true);
    }
  }
}

module wall_li() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      x_rods_holes();
      x_stepper_strap_holes();
    }
  }
}

module wall_lo() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    x_stepper_strap_holes();
  }
}

module wall_lm() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      x_rods_holes();
      x_stepper_strap_holes();
    }
  }
}

wall_l();