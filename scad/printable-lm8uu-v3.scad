// LM8UU
lm8uu_od = 15;
lm8uu_length = 24;
lm8uu_id = 8.1;
/**/

// LME8UU
/*
lm8uu_od = 16
lm8uu_length = 25
lm8uu_id = 8.1
/**/


// these values should be copied from your slicing program

layer_height = 0.2;

// SKEINFORGE calculates extrusion_width = layer_height * perimeter_width_over_thickness
// SFACT exposes this directly
// SLIC3R lists extrusion width in the header of exported gcode files as "single wall width"
//        it also allows you to specify as extrusion_width = layer_height * extrusion_width_ratio if you want to force it

extrusion_width = 0.5;

// this should also come from your slicing program, however it's usually an internal value. Most use approximately 0.15

overlap_ratio = 0.15;

// leave this as is, or punch in a value if you have an exact figure in mind
wall_width = extrusion_width * 2 - extrusion_width * overlap_ratio; 

echo("wall_width: ",wall_width);

// this is how many points of contact we have
fins = 5;

// this is how long the points of contact are vs the space between them
// if you make it too small, there's no gaps in the middle ring and we lose the springiness

contact_percent = 20;

// this is how far around the fins twist.
// 100% = the head of one overlaps the tail of the next one
twist_percent = 50;

/****************************************************
	you shouldn't need to touch anything below here
*****************************************************/

// make sure all the circles have parallel segments
$fn=64;


union() {
	// outer ring
	difference() {
		cylinder(r=lm8uu_od / 2, h=lm8uu_length - layer_height);
		translate([0, 0, -1]) cylinder(r=lm8uu_od / 2 - wall_width, h=lm8uu_length + 2);
	}
	
	// inner extruded profile
	linear_extrude(height = lm8uu_length - layer_height, twist=360 / fins * twist_percent / 100, slices = (lm8uu_length - layer_height) * 2)
		for (i=[0:fins - 1])
			rotate(360 / fins * i)
				union() /**/ {
					intersection() {
						difference() {
							circle(lm8uu_od / 2);
							translate([-lm8uu_od, -lm8uu_od]) square([lm8uu_od, lm8uu_od * 2]);
							rotate(360 / fins * contact_percent / 100)
								translate([0, -lm8uu_od])
									square([lm8uu_od, lm8uu_od * 2]);
						}
						difference() {
							circle(r=lm8uu_id / 2 + wall_width);
							circle(r=lm8uu_id / 2);
						}
					}
					
					intersection() {
						rotate(360 / fins * contact_percent / 100) difference() {
							circle(lm8uu_od / 2);
							translate([-lm8uu_od, -lm8uu_od]) square([lm8uu_od, lm8uu_od * 2]);
							rotate(360 / fins * (1 - (contact_percent / 100))) translate([0, -lm8uu_od]) square([lm8uu_od, lm8uu_od * 2]);
						}
						difference() {
							circle(r=lm8uu_id / 2 + wall_width * 2);
							circle(r=lm8uu_id / 2 + wall_width);
						}
					}
					
					rotate(360 / fins) translate([0, -lm8uu_id / 2 - wall_width / 2]) circle(wall_width / 2, $fn=16);
					rotate(360 / fins * contact_percent / 100) translate([0, -lm8uu_id / 2 - wall_width / 2]) circle(wall_width / 2, $fn=16);
					rotate(360 / fins * contact_percent / 100) translate([0, -lm8uu_id / 2 - wall_width * 1.5]) circle(wall_width / 2, $fn=16);
					rotate(360 / fins) translate([0, -lm8uu_id / 2 - wall_width * 1.5]) circle(wall_width / 2, $fn=16);
					rotate(360 / fins * contact_percent / 100) translate([-wall_width / 2, -lm8uu_id / 2 - wall_width * 1.5]) square([wall_width, wall_width]);
					rotate(360 / fins) translate([-wall_width / 2, -lm8uu_id / 2 - wall_width * 1.5]) square([wall_width, wall_width]);
					rotate(360 / fins * contact_percent / 100 + 360 / fins * (1 - (contact_percent / 100)) / 2) translate([-wall_width / 2, -lm8uu_id / 2 - wall_width * 1.5]) mirror([0, 1]) square([wall_width, (lm8uu_od / 2 - wall_width / 2) - (lm8uu_id / 2 + wall_width * 1.5)]);
	
				}
}
