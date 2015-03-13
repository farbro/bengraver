use <formulas.scad>;

$fn=30;

// Global
span_bottle=100; 
bottle_rod_diam=8; 
front_rod_diam=8; 
width=470;
span_bottom= 130; // Bottom rods span
span_bottle= 120; // Bottle rods span
board_thickness=5;
nut_t=6;
back_tilt_angle=20;

// Bottle grip
bottle_axle_diam=20;
bottle_axle_pos=[span_bottom-sin(back_tilt_angle)*span_bottle/2, cos(back_tilt_angle)*span_bottle/2];

bottle_grip_bottom_diam=100;
bottle_grip_bottom_height=4;
bottle_grip_bottom_cone_height=20;

bottle_grip_top_diam=50;
bottle_grip_top_height=5;
bottle_grip_top_cone_height=20;
bottle_grip_top_diam=50;
bottle_grip_top_inner_diam=45;
bottle_pulley_teeth=62;


// Sides
holes_margin=25; 
axle_position=[0,0];
axis_z=40;
//x_top_rod_position=[0,bottle_axle_pos[1] + span_rods/2];
bottom_extrusion_height=5;
bottle_top_rod_position=[span_bottom-sin(back_tilt_angle)*span_bottle, cos(back_tilt_angle)*span_bottle];

// Right side
bottle_axis_diam=15;
stepper_slide_distance=3;
a_stepper_pos=[span_bottom*0.3, 10];
stepper_rotation=atan((bottle_axle_pos[1]-a_stepper_pos[1])/(bottle_axle_pos[0]-a_stepper_pos[0]));
servo_distance_from_axle=50;

// Left side

// X table
x_a_distance=80;
x_table_tilt=15;
span_rods=75;
rod_ext=10;
table_rod_ext=0;
table_rods_diam=8;

// X carriage
//carriage_length= 24; // single bushing
carriage_length=55; // double bushings
carriage_rounding_radius = 10;
carriage_bushing_hole_width = 12;
z_rods_length=70;
z_rods_diam=8;
z_rods_span=41;
z_bar_width=20;
z_pos=45;
z_bushings_diam=15;
z_bolt_diam=3;
plate_distance = sqrt(pow(15/2, 2) - pow(carriage_bushing_hole_width/2, 2)) + board_thickness/2; // Calculates plate distance (depending on carriage_bushing_hole_width
echo("Plate distance:", plate_distance*2 + board_thickness);
nut_hole_width = 2*tan(60)*(15-plate_distance-board_thickness/2)/2;
x_nut_span=carriage_length-5;

// Calculations for x table position
x_top_rod_position=[bottle_axle_pos[0]-x_a_distance*cos(x_table_tilt)+sin(x_table_tilt)*span_rods/2, bottle_axle_pos[1] + x_a_distance*sin(x_table_tilt) + cos(x_table_tilt)*span_rods/2];
x_btm_rod_position=[bottle_axle_pos[0]-x_a_distance*cos(x_table_tilt)-sin(x_table_tilt)*span_rods/2, bottle_axle_pos[1] + x_a_distance*sin(x_table_tilt) - cos(x_table_tilt)*span_rods/2];

// Bottle
bottle_pos=30;
bottle_diam=100;
bottle_height=360;

// Bottle bar
bottle_bar_width=40;
bottle_bar_height=span_bottle;
bottle_bar_pos=bottle_height+bottle_pos+40;

bearing_hole_diam=17;
bearing_guide_diam=22.1;


// Pulley properties
shaftDiameter = 8; // the shaft at the center, will be subtracted from the pulley. Better be too small than too wide.
hubDiameter = 30; // if the hub or timing pulley is big enough to fit a nut, this will be embedded.
hubHeight = 8; // the hub is the thick cylinder connected to the pulley to allow a set screw to go through or as a collar for a nut.
flanges = 2; // the rims that keep the belt from going anywhere
hubSetScewDiameter = 0; // use either a set screw or nut on a shaft. Set to 0 to not use a set screw.
numSetScrews = 3;
numTeeth = 63; // this value together with the pitch determines the pulley diameter
toothType = 2; // 1 = slightly rounded, 2 = oval sharp, 3 = square. For square, set the toothWith a little low.

// Belt properties:
pitch = 2; // distance between the teeth
beltWidth = 6; // the width/height of the belt. The (vertical) size of the pulley is adapted to this.
beltThickness = 0.65; // thickness of the part excluding the notch depth!
notchDepth = 1.8; // make it slightly bigger than actual, there's an outward curvature in the inner solid part of the pulley
toothWidth = 1.4; // Teeth of the PULLEY, that is.
