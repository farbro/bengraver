/*
*   Generic library for fractional t-slot extrusions.
*   Rev. 1
*
*  Creative Commons Share Alike 3.0
*  Copyright (c) 2013 David Lee Miller
* 
*/

minkR_TS = 0.04*25.4;   // minkowski radius for the t-slot
minkR_IC = 0.075*25.4;   // minkowski radius for the inner cutout
minkR_PF = 0.05*25.4;   // minkowski radius for the profile corners

1010Profile(470);
//1020Profile(100);
//1030Profile(100);
//2020Profile(100);
//2040Profile(100);


module fillet(rad){
	translate([-rad,-rad,0])
	difference(){
		translate([0,0,0]) square([rad+0.01,rad+0.01]);
		circle(r=rad,center=true,$fn=32);
	}
}

module insideCutout(){
	minkowski(){
		translate([0,0,0]) circle(r=minkR_IC,center=true,$fn=32);
		hull(){
			square([0.2*25.4-minkR_IC,0.645*25.4-2*minkR_IC],center=true);
			square([0.8*25.4-2*minkR_IC,0.001*25.4],center=true);
		}
	}
}

module doubleCutout(){
	union(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_IC,center=true,$fn=32);
			union(){
			rotate([0,0,0]) hull(){
				translate([-0.5*25.4,0,0]) hull(){
					square([0.2*25.4-minkR_IC,0.645*25.4-2*minkR_IC],center=true);
					square([0.8*25.4-2*minkR_IC,0.001*25.4],center=true);
				}
				translate([0.5*25.4,0,0]) hull(){
					square([0.2*25.4-minkR_IC,0.645*25.4-2*minkR_IC],center=true);
					square([0.8*25.4-2*minkR_IC,0.001*25.4],center=true);
				}
			}
			rotate([0,0,90]) hull(){
				translate([-0.5*25.4,0,0]) hull(){
					square([0.2*25.4-minkR_IC,0.645*25.4-2*minkR_IC],center=true);
					square([0.8*25.4-2*minkR_IC,0.001*25.4],center=true);
				}
				translate([0.5*25.4,0,0]) hull(){
					square([0.2*25.4-minkR_IC,0.645*25.4-2*minkR_IC],center=true);
					square([0.8*25.4-2*minkR_IC,0.001*25.4],center=true);
				}
			}}
		}
		rotate([0,0,0]) translate([-0.645*25.4/2,-0.645*25.4/2,0]) fillet(minkR_IC);
		rotate([0,0,180]) translate([-0.645*25.4/2,-0.645*25.4/2,0]) fillet(minkR_IC);
		rotate([0,0,90]) translate([-0.645*25.4/2,-0.645*25.4/2,0]) fillet(minkR_IC);
		rotate([0,0,-90]) translate([-0.645*25.4/2,-0.645*25.4/2,0]) fillet(minkR_IC);
	}
}

module tSlot(){
	union(){
		translate([minkR_TS,0,0])
		minkowski(){
			translate([0,0,0]) circle(r=minkR_TS,center=true,$fn=32);
			hull(){
				square([0.001*25.4,0.585*25.4-2*minkR_TS],center=true);
				translate([(0.233*25.4-2*minkR_TS)/2,0,0]) square([0.233*25.4-2*minkR_TS,0.2*25.4],center=true);
			}
		}
	translate([-0.255*25.4/2+0.01,0,0]) square(0.255*25.4,center=true);
	translate([-0.35*25.4/2-0.087*25.4+0.01,0,0]) square(0.35*25.4,center=true);
	translate([0,-0.255*25.4/2,0]) fillet(minkR_TS/2);
	translate([-0.087*25.4,-.255*25.4/2,0]) rotate([0,0,90]) fillet(minkR_TS/2);
	scale([1,-1,1]) translate([0,-0.255*25.4/2,0]) fillet(minkR_TS/2);
	scale([1,-1,1]) translate([-0.087*25.4,-.255*25.4/2,0]) rotate([0,0,90]) fillet(minkR_TS/2);
	}
}

module 1010Profile(height){
	linear_extrude(height=height,center=true)
	union(){
	difference(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_PF,center=true,$fn=32);
			square([1*25.4-2*minkR_PF,1*25.4-2*minkR_PF],center=true);
		}
		translate([0,0,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4+0.087*25.4,0,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,0,0]) tSlot();
		translate([0,-0.5*25.4+0.087*25.4,0]) rotate([0,0,90]) tSlot();
		translate([0,0.5*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
	}}
}

module 1020Profile(height){
	linear_extrude(height=height,center=true)
	difference(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_PF,center=true,$fn=32);
			square([1*25.4-2*minkR_PF,2*25.4-2*minkR_PF],center=true);
		}
		translate([0,0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,-0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,0,0]) insideCutout();
		translate([-0.5*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		translate([-0.5*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		translate([0,-1*25.4+0.087*25.4,0]) rotate([0,0,90]) tSlot();
		translate([0,1*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
	}
}

module 1030Profile(height){
	linear_extrude(height=height,center=true)
	difference(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_PF,center=true,$fn=32);
			square([1*25.4-2*minkR_PF,3*25.4-2*minkR_PF],center=true);
		}
		translate([0,0,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,1*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,-1*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,-0.5*25.4,0]) insideCutout();
		translate([0,0.5*25.4,0]) insideCutout();
		translate([-0.5*25.4+0.087*25.4,0,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,0,0]) tSlot();
		translate([-0.5*25.4+0.087*25.4,1*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,1*25.4,0]) tSlot();
		translate([-0.5*25.4+0.087*25.4,-1*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4+0.087*25.4,-1*25.4,0]) tSlot();
		translate([0,-1.5*25.4+0.087*25.4,0]) rotate([0,0,90]) tSlot();
		translate([0,1.5*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
	}
}

module 2020Profile(height){
	linear_extrude(height=height,center=true)
	difference(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_PF,center=true,$fn=32);
			square([2*25.4-2*minkR_PF,2*25.4-2*minkR_PF],center=true);
		}
		translate([0.5*25.4,0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0.5*25.4,-0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,-0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,0,0]) doubleCutout();
		translate([-1*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		translate([-1*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		translate([-0.5*25.4,1*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4,1*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		translate([0.5*25.4,1*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		rotate([0,0,180]) translate([0.5*25.4,1*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
	}
}

module 2040Profile(height){
	linear_extrude(height=height,center=true)
	difference(){
		minkowski(){
			translate([0,0,0]) circle(r=minkR_PF,center=true,$fn=32);
			square([2*25.4-2*minkR_PF,4*25.4-2*minkR_PF],center=true);
		}
		translate([0.5*25.4,1.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,1.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0.5*25.4,0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0.5*25.4,-1.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,-1.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0.5*25.4,-0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([-0.5*25.4,-0.5*25.4,0]) circle(r=0.2*25.4/2,$fn=24);
		translate([0,1*25.4,0]) doubleCutout();
		translate([0,-1*25.4,0]) doubleCutout();
		translate([0.5*25.4,0,0]) insideCutout();
		translate([-0.5*25.4,0,0]) insideCutout();
		translate([-1*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,0.5*25.4,0]) tSlot();
		translate([-1*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,-0.5*25.4,0]) tSlot();
		translate([-1*25.4+0.087*25.4,1.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,1.5*25.4,0]) tSlot();
		translate([-1*25.4+0.087*25.4,-1.5*25.4,0]) tSlot();
		rotate([0,0,180]) translate([-1*25.4+0.087*25.4,-1.5*25.4,0]) tSlot();
		translate([-0.5*25.4,2*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		rotate([0,0,180]) translate([-0.5*25.4,2*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		translate([0.5*25.4,2*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
		rotate([0,0,180]) translate([0.5*25.4,2*25.4-0.087*25.4,0]) rotate([0,0,-90]) tSlot();
	}
}
