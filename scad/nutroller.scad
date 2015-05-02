include <dimensions.scad>;
use <2dTimingPulleyCutout.scad>;

module roller0() {
  pulley_cogs(numTeeth=64, shaftDiameter=bottle_rod_diam, materialThickness=board_thickness);
}


module roller1() {
  linear_extrude(board_thickness, center=true)
    difference() {
      projection() roller0();
      circle(r=20/2, $fn=6);
    }
  
}

module nutroller() {
  roller0();
  translate([0,0,board_thickness*1.5]) roller1();
}

nutroller();
