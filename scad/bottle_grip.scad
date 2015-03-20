include <dimensions.scad>;
use <2dTimingPulleyCutout.scad>;

/*
module btm_grip_support() {
  t = board_thickness-0.2;
  margin = 5;
  linear_extrude(t, center=true)
  union() {
    difference() {
      union() {
        translate([0, t + margin]) scale([bottle_grip_bottom_diam/2, bottle_grip_bottom_height]) circle();
        square([bottle_grip_bottom_diam/2, t + margin]);
      }
      union() {
        mirror([1, 0, 0]) square([1000, 1000]);
        mirror([0, 1, 0]) translate([-500, 0, 0]) square([1000, 1000]);
       translate([0, -1]) square([bottle_axle_diam/2 + 1, t + 2]);
       translate([0, t]) square([14.2/2, bottle_grip_bottom_height + margin + 1]);
       translate([bottle_axle_diam + 5, -1]) square([t*2, t+1]);
       translate([bottle_grip_bottom_diam/2 - t - 4, -1]) square([t, t+1]);
       square([bottle_grip_bottom_diam/2 - t - 4, 0.5]);
      }
    }
  points=[[0, 0], [-5, 0], [0, -3]];
  translate([bottle_grip_bottom_diam/2, 0]) polygon(points);
  //translate([bottle_axle_diam + 1, 0]) mirror([1, 0, 0]) polygon(points);
  }
  
}
*/

module btm_grip_support() {
  t = board_thickness;
  l=bottle_grip_bottom_diam/2;
  margin=6;

  points = [
    [bottle_axle_diam/2, 0.5],
    [15, 0.5],
    [15, t],
    [20, t],
    [20, 0.5],
    [30, 0.5],
    [30, t],
    [35, t],
    [35, 0.5],
    [l, 0.5],
    [l, t + margin],
    [16/2, t + margin + bottle_grip_bottom_height],
  ];

  linear_extrude(t, center=true)
    polygon(points);
}

module top_grip_support() {
  t = board_thickness;
  l=bottle_grip_top_diam/2;
  margin=6;

  points = [
    [bottle_axle_diam/2, 0.5],
    [10, 0.5],
    [10, t],
    [20, t],
    [20, 0.5],
    [30, 0.5],
    [l, 0.5],
    [l, t + margin + bottle_grip_top_height],
    [16/2, t + margin],
  ];

  linear_extrude(t, center=true)
    polygon(points);
}

module top_plate() {
  t = board_thickness;
  linear_extrude(board_thickness, center=true)
  difference() {
    circle(r=bottle_grip_top_diam/2);
    circle(r=bottle_axle_diam/2 + 2);
    union() {
      for (i=[0:6]) {
        rotate(i*360/6, [0, 0, 1])
          projection(cut=true) translate([0, 0, -t/2]) rotate([90, 0, 0]) top_grip_support();
      }
    }
  }
}

/*module btm_plate() {
  t = board_thickness - 0.2;
  linear_extrude(board_thickness, center=true)
  difference() {
    circle(r=bottle_grip_bottom_diam/2);
    circle(r=bottle_axle_diam/2 + 2);
    union() {
      for (i=[0:6]) {
        rotate(i*360/6, [0, 0, 1])
          projection(cut=true) translate([0, 0, -t/2]) rotate([90, 0, 0]) btm_grip_support();
      }
    }
  }
}*/

module pulley() {
  pulley_cogs(numTeeth=bottle_pulley_teeth, shaftDiameter=bottle_axle_diam, materialThickness=board_thickness);
}

module beltguide() {
  pulley_beltguide(numTeeth=bottle_pulley_teeth, shaftDiameter=bottle_axle_diam, materialThickness=board_thickness);
}

module btm_plate() {
  t = board_thickness;
  linear_extrude(board_thickness, center=true)
  difference() {
    circle(r=bottle_grip_bottom_diam/2);
    circle(r=bottle_axle_diam/2 + 2);
    union() {
      for (i=[0:6]) {
        rotate(i*360/6, [0, 0, 1])
          projection(cut=true) translate([0, 0, -t/2]) rotate([90, 0, 0]) btm_grip_support();
      }
    }
  }
}


module btm_plate2() {
  linear_extrude(board_thickness, center=true) 
  difference() {
    circle(r=bottle_grip_bottom_diam/2);
    circle(bottle_axle_diam/2);
  }
}

module top_plate2() {
  linear_extrude(board_thickness, center=true) 
  difference() {
    circle(r=bottle_grip_top_diam/2);
    circle(bottle_axle_diam/2);
  }
}



module bottom_grip() {
  beltguide();
  translate([0, 0, board_thickness]) pulley();
  translate([0, 0, board_thickness*2]) beltguide();
  translate([0, 0, board_thickness*3.5]) btm_plate();
  translate([0, 0, board_thickness*4.5]) 
  for (i=[0:6]) {
    rotate(i*360/6, [0, 0, 1])
    translate([0, 0, -board_thickness/2]) rotate([90, 0, 0]) btm_grip_support(tol=0);
  }
}

module top_grip() {
  top_plate2();
  translate([0, 0, board_thickness]) top_plate();
  translate([0, 0, board_thickness]) 
  for (i=[0:6]) {
    rotate(i*360/6, [0, 0, 1])
    translate([0, 0, -board_thickness/2]) rotate([90, 0, 0]) top_grip_support();
  }
}

//bottom_grip();
//btm_grip_support();
//btm_plate();
//bottom_grip();
//top_grip_support();
//top_plate();
top_grip();

