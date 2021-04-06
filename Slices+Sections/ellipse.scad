d = [120, 90];
string = 5;

h = 8;
wall = 2;

$fs = .2;
$fa = 2;

focus = [max(0, sqrt(pow(d[0], 2) - pow(d[1], 2)) / 2), max(0, sqrt(pow(d[1], 2) - pow(d[0], 2)) / 2)];

difference() {
	for(i = [0, 1]) mirror([0, 0, i]) 
		hull() for(i = [0, 1]) translate([0, 0, -h / 2]) linear_extrude(1 + i * h / 2) offset(i * -h / 2) scale([1 / d[1], 1 / d[0], 1]) circle(d[0] * d[1] / 2);
	for(i = [-1, 1]) translate(i * focus) rotate_extrude() for(m = [0, 1]) mirror([0, m, 0]) {
		square([string / 2, h]);
		translate([string / 2, h / 2 - wall, 0]) hull() for(a = [45, 90]) rotate(a) square([h, string / 2]);
	}
}

rotate((d[0] > d[1]) ? 0 : -90) translate([0, min(d) / 2 + 2, 0]) difference() {
	linear_extrude(h, center = true, convexity = 5) translate([0, 0, 0]) difference() {
		offset(1 + wall) offset(-1) circle(string);
		offset(1) offset(-1) intersection() {
			rotate(45) offset(-.5) square(string * 2);
			circle(string);
			translate([-string, -.5, 0]) square(string * 2);
		}
	}
	rotate([0, 90, 0]) linear_extrude(string * 3, center = true) for(i = [0, 1]) mirror([i, 0, 0]) hull() for(i = [0, 1]) translate([-h / 2, -string - h / 2, 0]) square([2 + i * h, string * 2 + h - i * h], center = true);
	for(i = [0, 1]) mirror([0, 0, i]) translate([0, 0, h / 2 - 1.5]) intersection() {
		rotate([0, 90, 0]) rotate_extrude() rotate(90) offset(1) offset(-1) intersection() {
			rotate(45) offset(-.5) square(string * 2);
			circle(string);
			translate([-string, -.5, 0]) square(string * 2);
		};
		translate([0, 0, string]) cube(string * 2, center = true);
	}
}