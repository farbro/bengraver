include <dimensions.scad>;
use <walls.scad>;
use <bar.scad>;
use <x_stepper_mount.scad>;
use <x_table.scad>;
use <bottle_grip.scad>;

minkowski() {
  circle(cut_diam/2);
  projection() {
    if (wall_ri)           wall_ri();
    if (wall_ro)           wall_ro();
    if (wall_li)           wall_li();
    if (wall_lm)           wall_lm();
    if (wall_lo)           wall_lo();
    if (mount_plate)       mount_plate();
    if (bearing_guide)     rotate([90, 0, 90]) bearing_guide();
    if (bottle_bar)        rotate([90, 0, 90]) bottle_bar();
    if (x_carriage)        x_carriage();
    if (z_bar)             rotate([90, 0, 90]) z_bar();
    if (pulley)            pulley();
    if (beltguide)         beltguide();
    if (btm_plate)         btm_plate();
    if (btm_plate2)        btm_plate2();
    if (btm_grip_support)  btm_grip_support();
    if (top_grip_support)  top_grip_support();
    if (top_plate)         top_plate();
    if (top_plate2)        top_plate2();

    cogs();
  }
}
