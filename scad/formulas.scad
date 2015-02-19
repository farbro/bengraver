
// Arm length function
function arm_length(l2, R, v) = 1/2*(sqrt(2)*sqrt(pow(l2, 2)*cos(2*v)-pow(l2, 2)+2*pow(R, 2))-2*l2*cos(v));
  
//Distance between 2 points
function distance(p1, p2) = sqrt(pow(p2[0]-p1[0], 2) + pow(p2[1]-p1[1], 2));

// Maximum distortion for angular x
function max_distortion(R, d1, d2) = R-sqrt(pow(R, 2) - pow((d2-d1), 2)/4);
  
