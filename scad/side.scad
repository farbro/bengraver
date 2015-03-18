include <dimensions.scad>;
use <../MCAD/servos.scad>;
use <../MCAD/motors.scad>;
use <common.scad>;

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

        translate(x_top_rod_position) {
          circle(table_rods_diam/2);
        }
        translate(x_btm_rod_position) {
          circle(table_rods_diam/2);
        }

        // Foot extrusion
        
        translate([span_bottom/2, -holes_margin]) scale([span_bottom/2-holes_margin/2, bottom_extrusion_height, 1]) circle(1);

        }
      }
    }
}

module side_r() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_hole_diam/2, center=true);
      translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) nema17_holes(stepper_slide_distance);
      translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
      translate([-bearing_extrusion_height/2 + plate_distance - board_thickness/2, 0]) {
        square([bearing_extrusion_height, bearing_extrusion_length], center=true);
        square([bearing_axle_extrusion_height, bearing_axle_extrusion_length], center=true);
        translate([bearing_axle_extrusion_length/2 + 4, bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([bearing_axle_extrusion_length/2 + 4, -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
      }
    }
  }
}

module side_r_bearing_guide() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bearing_guide_diam/2, center=true);
      translate(a_stepper_pos) rotate([0, 0, stepper_rotation]) nema17_holes(stepper_slide_distance);
      translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90]) 
      translate([-bearing_extrusion_height/2 + plate_distance - board_thickness/2, 0]) {
        square([bearing_extrusion_height, bearing_extrusion_length], center=true);
        translate([bearing_axle_extrusion_length/2 + 4, bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([bearing_axle_extrusion_length/2 + 4, -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
      }
    }
  }
}

module side_l_bearing_guide() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bottle_axle_diam, center=true);
      translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90]) 
      translate([-bearing_extrusion_height/2 + plate_distance - board_thickness/2, 0]) {
        square([bearing_extrusion_height, bearing_extrusion_length], center=true);
        translate([bearing_axle_extrusion_length/2 + 4, bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([bearing_axle_extrusion_length/2 + 4, -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
      }
    }
  }
}

module side_l() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate(bottle_axle_pos) circle(r=bottle_axle_diam, center=true);
      translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
      translate([-bearing_extrusion_height/2 + plate_distance - board_thickness/2, 0]) {
        square([bearing_extrusion_height, bearing_extrusion_length], center=true);
        square([bearing_axle_extrusion_height, bearing_axle_extrusion_length], center=true);
        translate([bearing_axle_extrusion_length/2 + 4, bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([bearing_axle_extrusion_length/2 + 4, -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), bearing_extrusion_height/2 + 3]) square(strap_hole_dim, center=true);
        translate([-(bearing_axle_extrusion_length/2 + 4), -(bearing_extrusion_height/2 + 3)]) square(strap_hole_dim, center=true);
      }
    }
  }
}

side_l();
