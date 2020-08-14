// file TriangleBox.scad
// This model creates a rectangular open box that holds together two
// TriangleArea triangles. 
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

base = 105;
height = 70;
thickness = 20;

top = base * 1.3;

$fs = .1;
$fa = 2;

size = [base, height];
wall = 1;
clearance = 1;

linear_extrude(1) offset(clearance + wall) polygon([[0, 0], [base, 0], [top, height]]);;

difference() {
	linear_extrude(10, convexity = 5) difference() {
		offset(wall + clearance) polygon([[0, 0], [base, 0], [top, height]]);;
		offset(clearance) polygon([[0, 0], [base, 0], [top, height]]);;
	}
	translate([base / 2, 0, 0]) rotate([90, 0, 0]) linear_extrude(100) difference() {
		square(size[0] - 15, center = true);
		for(i = [0, 1]) mirror([i, 0, 0]) translate([(size[0] - 15) / 2, 0, 0]) scale([.5, 1, 1]) circle(10);
	}
}