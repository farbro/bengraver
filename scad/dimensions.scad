use <formulas.scad>;

$fn=50;
export_fn=100;
export_scale=0.03937; // scales down mm->inches (useful if your laser cutter uses inches)
cut_diam=0.2;

// Global
PI = 3.15159265; 


span_bottle=100; 
bottle_rod_diam=10; 
front_rod_diam=10; 
width=470;
span_bottom=160; // Bottom rods span
span_bottle=120; // Bottle rods span
board_thickness=5.65;
nut_t=6;
back_tilt_angle=20;

cable_diam=1.7;

bushings_diam=15;
bushings_length=24;
bushings_hole_length=24.2;

strap_hole_dim=[4, 2];
strap_margin=3;

// Bottle grip
bottle_axle_diam=8;
bottle_axle_pos=[span_bottom-sin(back_tilt_angle)*span_bottle/2, cos(back_tilt_angle)*span_bottle/2];

bottle_grip_bottom_diam=90;
bottle_grip_bottom_height=6;
bottle_grip_bottom_cone_height=4;

bottle_grip_top_diam=50;
bottle_grip_top_height=7;
bottle_grip_top_cone_height=20;
bottle_grip_top_diam=50;
bottle_grip_top_inner_diam=45;
bottle_pulley_teeth=62;


// Sides
holes_margin=25; 
axle_position=[0,0];
break_position=[70, 50];
axis_z=40;
bearing_extrusion_height=7.2;
bearing_extrusion_length=24;
bearing_axle_length=20;
bearing_id=8;

//x_top_rod_position=[0,bottle_axle_pos[1] + x_rods_span/2];
bottom_extrusion_height=5;
bottle_top_rod_position=[span_bottom-sin(back_tilt_angle)*span_bottle, cos(back_tilt_angle)*span_bottle];

// Right wall
bottle_axis_diam=15;
stepper_slide_distance=0;
a_stepper_pos=[span_bottom*0.4, 10];
stepper_rotation=0; //atan((bottle_axle_pos[1]-a_stepper_pos[1])/(bottle_axle_pos[0]-a_stepper_pos[0]));


// Left wall

// X table
x_carriage_pos=width/5;
x_a_distance=85;
x_table_tilt=0;
x_rods_span=50;
rod_ext=8;
table_rod_ext=0;
table_rods_diam=8;

// X stepper mount
x_stepper_mount_length = 50;
x_stepper_mount_width = x_rods_span + 10;
x_stepper_mount_shift=(22-9)/2;

x_table_width=width - board_thickness*2;

// X carriage
//carriage_length= 24; // single bushing
carriage_length=65; // double bushings
carriage_height=x_rods_span+20;
carriage_rounding_radius = 10;
carriage_bushing_hole_width = 10.5;
z_rods_length=70;
z_rods_diam=8;
z_bar_width=20;
z_pos=-10;
z_bushings_diam=15;
z_bolt_diam=3;
z_rods_span=41;
z_bushings_pos = x_rods_span/2;
solenoid_dim = [27, 22, 25];
solenoid_pos=0;
plate_distance = sqrt(pow(bushings_diam/2, 2) - pow(carriage_bushing_hole_width/2, 2)) + board_thickness/2; // Calculates plate distance (depending on carriage_bushing_hole_width
echo("Plate distance:", plate_distance*2 + board_thickness);
z_plate_dist = 5;
z_bushings_hole_width = 2*sqrt(pow(bushings_diam/2, 2) - pow(z_plate_dist, 2));

// Calculations for x table position
xz_span = plate_distance + z_plate_dist + board_thickness/2;
x_top_rod_position=[bottle_axle_pos[0] - cos(x_table_tilt)*(x_a_distance) + sin(x_table_tilt)*(-xz_span), bottle_axle_pos[1] + sin(x_table_tilt)*(x_a_distance) + cos(x_table_tilt)*(-xz_span)];
x_btm_rod_position=[bottle_axle_pos[0] - cos(x_table_tilt)*(x_a_distance + x_rods_span) + sin(x_table_tilt)*(-xz_span), bottle_axle_pos[1] + sin(x_table_tilt)*(x_a_distance + x_rods_span) + cos(x_table_tilt)*(-xz_span)];

toolbit_mount_diam=4.8;

// Bottle
bottle_pos=40;
bottle_diam=100;
bottle_height=360;

// Bottle bar
bottle_bar_width=40;
bottle_bar_height=span_bottle;
bottle_bar_pos=bottle_height+bottle_pos+30;

bearing_hole_diam=13;
bearing_guide_diam=22;


// Pulley properties
shaftDiameter = 8; // the shaft at the center, will be subtracted from the pulley. Better be too small than too wide.
hubDiameter = 30; // if the hub or timing pulley is big enough to fit a nut, this will be embedded.
hubHeight = 8; // the hub is the thick cylinder connected to the pulley to allow a set screw to go through or as a collar for a nut.
flanges = 2; // the rims that keep the belt from going anywhere
hubSetScewDiameter = 0; // use either a set screw or nut on a shaft. Set to 0 to not use a set screw.
numSetScrews = 3;
bottle_pulley_teeth = ceil(7.1*16); // this value together with the pitch determines the pulley diameter
echo("Teeth:", bottle_pulley_teeth);

toothType = 1; // 1 = slightly rounded, 2 = oval sharp, 3 = square. For square, set the toothWith a little low.

// Belt properties:
pitch = 2; // distance between the teeth
beltWidth = 6; // the width/height of the belt. The (vertical) size of the pulley is adapted to this.
beltThickness = 0.63; // thickness of the part excluding the notch depth!
notchDepth = 0.75; // make it slightly bigger than actual, there's an outward curvature in the inner solid part of the pulley
toothWidth = 1.2; // Teeth of the PULLEY, that is.
pulleyRadius = pitch*bottle_pulley_teeth/(PI*2) - notchDepth;

a_stepper_teeth=11;
a_stepper_pulley_radius=4.2;


// Belt tensioner
echo(belt_tensioner_position[1], "Tensioner position");
echo(a_stepper_pulley_radius, "11t radius");
belt_tensioner_bolt_diam=7.8;
belt_tensioner_elevation=8;
belt_tensioner_stroke=10;
belt_tensioner_axle_margin=3;
belt_tensioner_xpos = 105;
belt_tensioner_position=[belt_tensioner_xpos, a_stepper_pos[1] - a_stepper_pulley_radius + (bottle_axle_pos[1] - pulleyRadius - a_stepper_pos[1] + a_stepper_pulley_radius)/(bottle_axle_pos[0] - a_stepper_pos[0])*(belt_tensioner_xpos-a_stepper_pos[0]) + belt_tensioner_stroke/2 - 22/2];

