// file puzzleBox.scad
// Creates a "vase box"with 
// internal dimensions that fits
// a tetrahedron with the same
// value of the "size" variable
// (c) Rich Cameron 2020, 
// License CC-BY

size = 50;
clearance = 1;
wall = 1;

linear_extrude(wall) square(size + clearance + wall * 2, center = true);

linear_extrude(size + clearance + wall) difference() {
	square(size + clearance + wall * 2, center = true);
	square(size + clearance, center = true);
}