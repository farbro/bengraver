use <clamp.scad>;


// X table
module table(l,h,t,sd,md,bd,s,eh) {
  translate([0,l/2-t/2, 0]) double_clamp(l,h,t,sd,md,bd,s,eh);
  translate([0, -(l/2-t/2), 0]) mirror([1, 0, 0]) double_clamp(l,h,t,sd,md,bd,s,eh);
}

// Z table
module complete_table(l,h,t,sd,md,bd,s,eh){
  table(l,h,t,sd,md,bd,s,eh);
  translate([0, 0, eh]) rotate([0, 0, 90]) mirror([1, 0, 0]) table(l,h,t,sd,md,bd,s,eh);
}

 complete_table(100, 40, 10, 15, 12, 3, 50, 20, 40);


