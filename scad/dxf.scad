include <dimensions.scad>;
use <walls.scad>;
use <bar.scad>;
use <x_stepper_mount.scad>;
use <x_table.scad>;
use <bottle_grip.scad>;
use <electronics_mount.scad>;

$fa=0.1;
$fs=0.1;

x_stepper_bar=true;

scale([export_scale, export_scale, export_scale])
offset(delta=cut_diam/2)
  projection(cut=true) {
    if (wall_ri)           wall_ri();
    if (wall_rm)           wall_rm();
    if (wall_ro)           wall_ro();
    if (wall_li)           wall_li();
    if (wall_lm)           wall_lm();
    if (wall_lo)           wall_lo();
    if (mount_plate)       mount_plate();
    if (bearing_guide)     rotate([90, 0, 90]) bearing_guide();
    if (bottle_bar)        rotate([90, 0, 90]) bottle_bar();
    if (x_carriage0)        x_carriage(level=0);
    if (x_carriage1)        x_carriage(level=1);
    if (x_carriage2)        x_carriage(level=2);
    if (z_bar)             rotate([90, 0, 90]) z_bar();
    if (pulley)            pulley();
    if (beltguide)         beltguide();
    if (btm_plate)         btm_plate();
    if (btm_plate2)        btm_plate2();
    if (btm_grip_support)  btm_grip_support();
    if (top_grip_support)  top_grip_support();
    if (top_plate)         top_plate();
    if (top_plate2)        top_plate2();
    if (belt_tensioner)    belt_tensioner();
    if (belt_clamp)        belt_clamp();
    if (electronics_mount) electronics_mount();
    if (nut_plate0)        nut_plate(nut=true);
    if (nut_plate1)        nut_plate(nut=false);
    if (spring_plate)      spring_plate();
    if (z_stepper_bar_outer) z_stepper_bar_outer();
    if (z_stepper_bar_inner) z_stepper_bar_inner();
    if (z_bar_inner)       z_bar_inner();
    if (z_bar_outer)       z_bar_outer();
    if (bearing_axle)      bearing_axle();
    if (x_stepper_bar)      x_stepper_bar();
  }
