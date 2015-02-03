module rod_smooth(diameter, length) {
  color("silver") rotate([-90, 0, 0]) cylinder(h=length, r=diameter/2);
}

module rod_threaded(diameter, length) {
  color("gray") rotate([-90, 0, 0]) cylinder(h=length, r=diameter/2);
}

rod(8, 400);
