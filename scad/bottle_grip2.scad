include <dimensions.scad>;

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

module btm_grip_support2(t=5.3, tol=0.25) {
  l=bottle_grip_bottom_diam/2;
  margin=3;

  points = [
    [bottle_axle_diam/2 - tol, 0],
    [15 + tol, 0],
    [15 + tol, t - tol],
    [20 - tol, t - tol],
    [20 - tol, 0],
    [30 + tol, 0],
    [30 + tol, t - tol],
    [35 - tol, t - tol],
    [35 - tol, 0],
    [l, 0],
    [l, t + margin],
    [13/2 - tol, t + margin + bottle_grip_bottom_height],

  ];

  polygon(points);
}

module btm_plate() {
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
}

module btm_plate2() {
  linear_extrude(board_thickness, center=true) 
  difference() {
    circle(r=bottle_grip_bottom_diam/2 - 5);
    circle(bottle_axle_diam/2);
  }
}

module bottom_grip() {
  btm_plate2();
  translate([0, 0, board_thickness]) btm_plate();
  translate([0, 0, board_thickness]) 
  for (i=[0:6]) {
    rotate(i*360/6, [0, 0, 1])
    translate([0, 0, -board_thickness/2]) rotate([90, 0, 0]) btm_grip_support();
  }
}


//bottom_grip();
btm_grip_support();
//btm_grip_support2();

