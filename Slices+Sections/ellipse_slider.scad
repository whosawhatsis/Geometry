// file ellipse_slider.scad
// creates an ellipse with two holes and a slider so that 
// one can prove that the sum of the distances from the two foci
// to a point on the ellipse is constant
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

d = [80, 60]; // minor and major axes, mm 
holesize = 5; //diameter of the focus holes 
h = 8; // thickness of the piece 
wall = 2;

$fs = .2;
$fa = 2;

focus = [max(0, sqrt(pow(d[0], 2) - pow(d[1], 2)) / 2), max(0, sqrt(pow(d[1], 2) - pow(d[0], 2)) / 2)];

translate([0, 0, h / 2]) difference() {
	union() for(i = [0, 1]) mirror([0, 0, i]) 
		hull() for(i = [0, 1]) translate([0, 0, -h / 2]) linear_extrude(1 + i * h / 2) offset(i * -h / 2) scale([1 / d[1], 1 / d[0], 1]) circle(d[0] * d[1] / 2);
	for(i = [-1, 1]) translate(i * focus) rotate_extrude() for(m = [0, 1]) mirror([0, m, 0]) {
		square([holesize / 2, h]);
		translate([holesize / 2, h / 2 - wall, 0]) hull() for(a = [45, 90]) rotate(a) square([h, holesize / 2]);
	};
}

rotate((d[0] > d[1]) ? 0 : -90) translate([0, min(d) / 2 + 2, h / 2 + 1]) slider();

module slider() difference() {
	linear_extrude(h + 2, convexity = 5, center = true) difference() {
		offset(1 + wall) offset(-1) circle(holesize);
	}
	linear_extrude(h - 2.9, center = true) offset(1) offset(-1) intersection() {
		rotate(45) offset(-.5) square(holesize * 2);
		circle(holesize);
		translate([-holesize, -.5, 0]) square(holesize * 2);
	}
	rotate([0, 90, 0]) linear_extrude(holesize * 3, center = true, convexity = 5) difference() {
		translate([0, -h, 0]) square(h * 2, center = true);
		circle(h / 2 - 1, $fn = 4);
	}
	for(i = [0, 1]) mirror([0, 0, i]) translate([0, 0, h / 2 - 1.5]) intersection() {
		rotate([0, 90, 0]) rotate_extrude() rotate(90) offset(1) offset(-1) intersection() {
			rotate(45) offset(-.5) square(holesize * 2);
			circle(holesize);
			translate([-holesize, -.5, 0]) square(holesize * 2);
		}
		translate([0, 0, holesize]) cube(holesize * 2, center = true);
	}
}