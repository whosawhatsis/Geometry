// file TriangleAreaBox.scad
// This model creates a triangular open box that holds together just one
// TriangleArea triangle. 
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

base = 105;
height = 70;
thickness = 20;

$fs = .1;
$fa = 2;

size = [base, height];
wall = 1;
clearance = 1;

linear_extrude(1) offset(clearance + wall) square(size, center = true);

difference() {
	linear_extrude(10, convexity = 5) difference() {
		offset(wall + clearance) square(size, center = true);
		offset(clearance) square(size, center = true);
	}
	rotate([90, 0, 0]) linear_extrude(100) difference() {
		square(size[0] - 15, center = true);
		for(i = [0, 1]) mirror([i, 0, 0]) translate([(size[0] - 15) / 2, 0, 0]) scale([.5, 1, 1]) circle(10);
	}
}