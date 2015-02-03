module rod_clam(diameter1, diameter2, length, width, thickness, span) {
  difference() {
      hull() {
      cylinder(h=width, r=diameter1/2+thickness, center=true);
      translate ([length, 0, 0]) rotate([90, 0, 0]) cylinder(h=diameter1+thickness*2, r=width/2, center=true);
      }
      union() {
        cylinder(h=width+2, r=diameter1/2, center=true);
	translate([(length+diameter1)/2, 0, 0]) cube([length+diameter1, span, width+2], center=true);
	translate([length, 0, 0]) rotate([90, 0, 0]) cylinder(h=diameter1+thickness*2+2, r=diameter2/2, center=true);
      }
  }
  
}

$fn=50;
rod_clam(8, 8, 10, 12, 3, 6);
