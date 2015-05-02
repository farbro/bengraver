include <dimensions.scad>;
use <../MCAD/servos.scad>;
use <../MCAD/motors.scad>;
use <formulas.scad>;
use <common.scad>;
use <x_table2.scad>;
use <vslot.scad>;

module belt_guide(inner=true) {
    translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2 + bearing_extrusion_translation]) rotate([0, 0, -x_table_tilt+90])
  translate([-2,0]) rotate([0,0,90]){
    square([bearing_extrusion_height, bearing_extrusion_length], center=true);
    if (inner) square([bearing_axle_length, sqrt(pow(bearing_id,2) - pow(board_thickness,2))], center=true);
  }
}

module belt_guide_axle_holder() {
  w=8.3;
  l=5.5;

  linear_extrude(board_thickness, center=true) 
    difference() {
      translate([0,-w/2]) square([l, w]);
      translate([l, 0]) circle(7.8/2);
    }

}

module x_stepper_hole(holes=false) {
    translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90]) translate([-2 + (22-x_stepper_pulley_radius*2)/2 ,-35]){
    if (!holes) square([42.5, 33], center=true);
    translate([x_stepper_mount_screw_span/2,0]) circle(5/2);
    translate([-x_stepper_mount_screw_span/2,0]) circle(5/2);
  }
}

module bearing_axle() {
  linear_extrude(board_thickness, center=true)
  square([5.8, bearing_axle_length], center=true);
}

module belt_tensioner_hole(inner=false) {
  if (inner) {
    circle(belt_tensioner_stroke/2 + belt_tensioner_bolt_diam/2);
  }
  else {
    circle(belt_tensioner_stroke/2 + belt_tensioner_bolt_diam/2 + belt_tensioner_axle_margin); 
  }
}

module belt_tensioner() {
  color("lightgray")
  linear_extrude(board_thickness, center=true)
  difference() {
    belt_tensioner_hole(inner=false);
    translate([0, -belt_tensioner_stroke/2]) circle(belt_tensioner_bolt_diam/2 - 0.4);
  }
}

module endstop_hole() {
  translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90])
  translate([plate_distance, - carriage_height/2 + 7])  
  rotate([180, 0, 180]) {
      endstop();
  }

}

module cable_channel(points, thickness) {
  for (i=[1:len(points)-1]) {
    hull() {
      translate([points[i][0], points[i][1]]) circle(thickness/2);
      translate([points[i-1][0], points[i-1][1]]) circle(thickness/2);
    }
  }
}

module x_table_holes(holes=false) {
  // x table
   translate(bottle_axle_pos) rotate([0,0,-x_table_tilt]) translate([-x_a_distance, 0])  translate([0,-carriage_base_dist-z_plate_dist-board_thickness/2]) {
      //translate([-10,0]) circle(5/2);
      //translate([10,0]) circle(5/2);
     
    if (!holes) hull() projection() vslot20x40(1); 
   
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
      x_table_holes(holes=true);
      belt_guide(inner=false);
      a_stepper_holes(outline=false);
      endstop_hole(inner=true, show=false);
      projection(cut=false) endstop_hole();
      translate(belt_tensioner_position) belt_tensioner_hole(inner=true);


      // X to Y split
      cable_channel(points=[[a_stepper_pos[0] - 23, a_stepper_pos[1]], [a_stepper_pos[0] -23, 30]], thickness=cable_diam*2);
      // Endstop cable channel
      cable_channel(points=[[a_stepper_pos[0] -23, 30], [45, 40]], thickness=cable_diam);
      // A stepper cable channel
      cable_channel(points=[[front_rod_diam*2, 0], [a_stepper_pos[0] - 23, a_stepper_pos[1]]], thickness=cable_diam*2.5);
      // X stepper cable channel
      cable_channel(points=[[a_stepper_pos[0] -23, 30], [x_top_rod_position[0] + 10, x_top_rod_position[1]-6]], thickness=cable_diam*2);
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
      x_table_holes();
      projection(cut=true) endstop_hole();
      belt_guide(inner=false);
      translate(belt_tensioner_position) belt_tensioner_hole(inner=false);
      translate([front_rod_diam*2,cable_diam/2]) circle(7/2);
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
      belt_guide(inner=true);
      a_stepper_holes(outline=true);
      translate(belt_tensioner_position) belt_tensioner_hole(inner=false);
      x_table_holes(holes=true);
      translate([a_stepper_pos[0] - 25, a_stepper_pos[1]]) circle(5/2);
    }
  }
}

module wall_li() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      x_table_holes();
      belt_guide(inner=true);
      x_stepper_hole(holes=true);
    }
  }
}

module wall_lo() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    x_table_holes(holes=true);
    belt_guide(inner=false);
    x_stepper_hole();
  }
}

module wall_lm() {
  color("white")
  linear_extrude(board_thickness, center=true)
  difference() {
    wall();
    union() {
      belt_guide(inner=false);
      x_table_holes(holes=true);
      x_stepper_hole(holes=true);

  //  translate([(x_top_rod_position[0] + x_btm_rod_position[0])/2, (x_top_rod_position[1] + x_btm_rod_position[1])/2]) rotate([0, 0, -x_table_tilt+90]) translate([-2 + (22-x_stepper_pulley_radius*2)/2 ,-35]){
  //  if (!holes) square([42.5, 33], center=true);
  //  translate([x_stepper_mount_screw_span/2,0]) circle(5/2);
  //  translate([-x_stepper_mount_screw_span/2,0]) circle(5/2);
  //}

    cable_channel(points=[[x_top_rod_position[0] + 35 +33/2 - 3 , x_top_rod_position[1] -2 + (22-x_stepper_pulley_radius*2)/2], [x_top_rod_position[0] + 10, x_top_rod_position[1] - 6]], thickness=cable_diam*2);
    }
  }
}

belt_guide_axle_holder();
