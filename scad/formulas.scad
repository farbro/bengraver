  
//Distance between 2 points
function distance(p1, p2) = sqrt(pow(p2[0]-p1[0], 2) + pow(p2[1]-p1[1], 2));
  
// distance between 2 arc end points
function arc_distance(r, depth) = sqrt(8*r*depth - 4*pow(depth, 2));
