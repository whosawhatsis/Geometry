// File reuleaux-n-gon.scad
// Prints out a Reuleaux n-gon and an enclosure for it to roll in
// (c) 2020 Rich Cameron
// Released under a CC-BY 4.0 International License

width = 50; // width of the object, in mm
sides = 3; // must be an odd number (>=3) 
height = 10; // height in z direction 
wall = 1; // thickness of vertical walls
base = .6; // thickness of solid base
clearance = .2; // clearance between n-gon and enclosure

$fs = .2;
$fa = 2;

if((sides % 2) != 1 || sides < 3) {
	echo("Reuleaux polygons must have an odd number of sides.");
} else {
	difference() {
		linear_extrude(height - base) intersection_for(a = [0:360 / sides:359]) rotate(a) translate([width / (sin(180 / sides) / sin(90 / sides)), 0, 0]) circle(width);
		translate([0, 0, base]) linear_extrude(height) offset(-wall) intersection_for(a = [0:360 / sides:359]) rotate(a) translate([width / (sin(180 / sides) / sin(90 / sides)), 0, 0]) circle(width);
	}
	
	translate([-width - wall * 2 - clearance, 0, 0]) difference() {
		linear_extrude(height) rotate(180 / (sides + 1)) circle((width / 2 + wall + clearance) / cos(180 / (sides + 1)), $fn = sides + 1);
		translate([0, 0, base]) linear_extrude(height) offset(-wall) rotate(180 / (sides + 1)) circle((width / 2 + wall + clearance) / cos(180 / (sides + 1)), $fn = sides + 1);
	}
	
	
	%circle(r = width / (sin(180 / sides) / sin(90 / sides)), $fn = sides);
}