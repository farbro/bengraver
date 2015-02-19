// By Rob Gilson
// Based on a script by Erik de Bruijn <reprap@erikdebruijn.nl> 
// License: GPLv2 or later
//
// Goal: the goal of this parametric model is to generate a high quality custom timing pulley that is cuttable by a laser cutter or 3 axis cnc mill.
// NOTE: The diameter of the gear parts are determined by the belt's pitch and number of teeth on a pully.

// //////////////////////////////
// USER PARAMETERS
// //////////////////////////////

// Pulley properties
shaftDiameter = 4.85; // the shaft at the center, will be subtracted from the pulley. Better be too small than too wide.
numTeeth = 11; // this value together with the pitch determines the pulley diameter
toothType = 3; // 1 = slightly rounded, 2 = oval sharp, 3 = square. For square, set the toothWith a little low. (TODO, not yet implemented)

// Belt properties:
pitch = 4; // distance between the teeth
beltThickness = 1.2; // thickness of the part excluding the notch depth!
beltWidth = 5; // the width/height of the belt. The (vertical) size of the pulley is adapted to this.
notchDepth = 2.4-1.2; // make it slightly bigger than actual, there's an outward curvature in the inner solid part of the pulley
toothWidth = 2; // Teeth of the PULLEY, that is.

//Nut Trap Properties
screwWidth = 1.5; //The width of the screw hole (make this slightly larger then the screw)
//The width and length of the nut to make the nut trap
nutWidth = 3; //The width of the nut trap (dimension perpendicular to the screw)
nutLength = 2;//The length of the nut trap (dimension along the screw)

//Assembly properties:
sideScrews = true; //If true generates 2 screw holes through the lenght of the pulley to use to hold it together instead of gluing the layers together.
setScrew = true; //if true generates a nut trap for a set screw to hold the pulley to the motor shaft.

//Layer Material properties:
materialThickness = 5.95; //TODO: the thickness of your layer material (to determine how many layers to cut)

//DXF Generation options (allows cutting of individual components)
pulley = true; //enables rendering of the pulley
beltguide = true;//enables rendering of the belt guide

// //////////////////////////////
// OpenSCAD SCRIPT
// //////////////////////////////

PI = 3.15159265; 
$fs=0.2; // def 1, 0.2 is high res 
$fa=3; //def 12, 3 is very nice

pulleyRadius = pitch*numTeeth/(PI*2); 
shaftRadius = shaftDiameter/2;

//Pulley Component
if (pulley==true)
//	for (layer = [0:(beltWidth/materialThickness)])
//		translate(v = [(pulleyRadius+notchDepth+1)*layer*2,0,0]) 
			pulleyOutline(r =pulleyRadius);
for ( i = [0:numTeeth] ) {
	rotate(a = [0,0,i*360/numTeeth])
	{
		translate(v = [pulleyRadius, 0, 0])
		{
			//tooth profile (toothType = 2)
			square(size = [notchDepth,toothWidth], center = true);
			translate(v = [notchDepth*0.5, 0, 0])
				scale([notchDepth/4, toothWidth/2, 1]) 
					circle(r=1);
		}
	}
}

//Nut Trap Clamp/Belt Guide Component
if (beltguide == true)
{
	translate(v = [-(pulleyRadius+notchDepth+2)*2,0,0])
	{
		pulleyOutline(r=pulleyRadius+notchDepth+beltThickness);
	}
}

//Nut Trap Component
if (setScrew == true)
{
translate(v = [-(pulleyRadius+notchDepth+2)*4,0,0])
{
	difference()
	{
		pulleyOutline(r=pulleyRadius+notchDepth);
		union()
		{
			translate([0,-screwWidth/2])
				square([pulleyRadius+notchDepth,screwWidth], center=false);
			translate([(pulleyRadius+shaftRadius+notchDepth)/2,0])
				square([nutLength,nutWidth], center=true);
		}
	}
}
}

//Pulley Outline Module
module pulleyOutline(r)
{
	difference()
	{
		circle(r=r, center=true); //outer
		union()
		{
			circle(r=shaftRadius, center=true); //shaft
			if (sideScrews == true)
			{
				translate([0,(pulleyRadius+shaftRadius)/2,0])
				circle(screwWidth,true);
				translate([0,-(pulleyRadius+shaftRadius)/2,0])
				circle(screwWidth,true);
			}
		}
	}
}
