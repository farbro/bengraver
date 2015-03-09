//100, 40, 10, 15, 12, 3, 50

module clamp(l=100, h=40, t=10, sd=15, md=12, bd=3, s=50, eh=20) {
  /*
    l=length
    h=height
    t=thickness
    sd=side holes diameter
    md=middle hole diameter
    bd=bolt diameter
    s=span between side holes
    eh=extruded edge height
  */

  gap=2; // gap between two clamps


  module main_block() {
    translate([0, 0, eh/4+gap/4]) cube([l, t, eh/2 - gap/2], center=true);
    translate([0, 0, h/4+gap/4]) cube([l-t*2, t, h/2 - gap/2], center=true);

  }
  module holes() {
      translate([s/2, 0, 0]) rotate([90, 0, 0]) cylinder(h=t+2, r=sd/2, center=true);
      //Holes for outer bolts
      translate([l/2-t/2, 0, h/4]) cylinder(h=h/2+2, r=bd/2, center=true);
      
      //Holes for inner bolts
      translate([md/2+2, 0, h/4]) cylinder(h=h/2+2, r=bd/2, center=true);

      //Middle hole
      rotate([90, 0, 0]) cylinder(h=t+2, r=md/2, center=true);
  }

  //Extrude holes from block
  difference() {
    main_block();
    union() {
      holes();
      mirror([1, 0, 0]) holes();
    }
  }
}

// Creates double clamp with stepper mount
module double_clamp(l,h,t,sd,md,bd,s,eh) {
    difference() {
      union() {
	clamp(l,h,t,sd,md,bd,s,eh);
	mirror([0, 0, 1]) mirror([1, 0, 0]) clamp(l,h,t,sd,md,bd,s,eh);
      }
      stepper_mount(11);
    }
}

module stepper_mount(depth) {
  module hole() {
    s=31; // Distance between holes on mount
    l=2; // Hole l
    $fn=50;

    translate([s/2, 0, s/2]) 
      rotate([90, 90, 0])
        hull() {
	  translate([l/2, 0, 0]) cylinder(h=depth, r=3/2, center=true);
	  translate([-l/2, 0, 0]) cylinder(h=depth, r=3/2, center=true);
	}
  }

  // Rotating to make 4 holes
  for (i=[0:4]) {
    rotate([0, 360/4*i, 0]) hole();
  }
}


clamp(100, 40, 10, 15, 12, 3, 50, 20, 40);
