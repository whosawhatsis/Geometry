// file circumscribed.scad
// Prints out a circle and its circumscribed specified polygon
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

wall_thickness = 1.2;
radius = 30;
n = 3; //number of sides of circumscribed polygon
height = 10;

$fs = .2;
$fa = 2;


difference(){
	cylinder(h = height, r = radius / cos(180 / n) + wall_thickness, $fn = n);
	cylinder(h = height*3, r = radius, $fn = 100, center = true);
};


linear_extrude(wall_thickness * 2) intersection() {
	circle(radius);
	union() {
		rotate(180 / n) translate([0, -wall_thickness, 0]) square([radius, 2 *wall_thickness]);
		difference() {
			offset(wall_thickness) intersection_for(a = [0, 180 + 360 / n]) rotate(a) translate([-radius * 2, 0, 0]) square(radius * 4);
			offset(-wall_thickness) intersection_for(a = [0, 180 + 360 / n]) rotate(a) translate([-radius * 2, 0, 0]) square(radius * 4);
		}
	}
}