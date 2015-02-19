use <formulas.scad>;

$fn=30;

// Global
span_bottom=100; 
span_bottle=100; 
bottle_rod_diam=8; 
front_rod_diam=8; 
width=450;
span_bottom= 100; // Bottom rods span
span_bottle= 120; // Bottle rods span
board_thickness=6;
nut_t=6;
back_tilt_angle=10;

// Sides
holes_margin=25; 
servo_position=[60,100];
axis_tilt=15; 
axle_position=[5,40];
axis_z=40;
break_position=[40,50];
bottom_extrusion_height=5;

bottle_top_rod_position=[span_bottom-sin(back_tilt_angle)*span_bottle, cos(back_tilt_angle)*span_bottle];
servo_rotation=atan((bottle_top_rod_position[1]-break_position[1])/(bottle_top_rod_position[0]-break_position[0]))-90;

// Right side
bottle_axis_diam=15;
stepper_slide_distance=10;
stepper_x=30;
stepper_z=13;
stepper_rotation=40;
servo_distance_from_axle=50;

// Left side


// X table
arm_width=50;
bottom_arm_width=30;
top_arm_width=30;
//span_axis=40;
span_rods=50;
rod_ext=10;
table_rod_ext=8;
arm_bending=20;
table_rods_diam=8;
table_tilt=10;

// Calculations for arms length
bottle_axle_position=[span_bottom-sin(back_tilt_angle)*span_bottle/2, cos(back_tilt_angle)*span_bottle/2];
axle_bottle_distance = distance(bottle_axle_position, axle_position);
span_axis =arm_length(span_rods/2, axle_bottle_distance, arm_bending);
echo( axle_bottle_distance);
echo( span_axis);

// Bottle
bottle_pos=30;
bottle_diam=70;
bottle_height=300;


// Bottle bar
bottle_bar_width=40;
bottle_bar_height=span_bottle;
bottle_bar_pos=bottle_height+bottle_pos+20;


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
