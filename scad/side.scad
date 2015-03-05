include <dimensions.scad>;
use <../MCAD/servos.scad>;
use <../MCAD/motors.scad>;
use <common.scad>;

module side() {
  union() {
  top_x_position = span_bottom -sin(back_tilt_angle)*span_bottle;

    difference() {
        // Base plate
        minkowski() {
        circle(holes_margin);
        polygon(points=[
          [0, 0],
          [span_bottom, 0],
          [bottle_top_rod_position[0], bottle_top_rod_position[1]],
          [break_position[0], break_position[1]],
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

module side_r() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
  difference() {
    side();
    union() {
      translate([span_bottom - tan(back_tilt_angle)*span_bottle/2, span_bottle/2*cos(back_tilt_angle), 0])
        circle(, r=bottle_axis_diam/2, center=true);
    }
  }
}

module side_l() {
  color("yellow")
  linear_extrude(board_thickness, center=true)
    mirror([0,0,1]) side();
}

side_l();
