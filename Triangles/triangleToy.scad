// File TriangleToy.scad
// Prints out a triangle with swingable sides
// (c) 2020 Rich Cameron
// Released under a CC-BY 4.0 International License

length = [50, 170]; // [short side, long sides]
hole = 12;
width = 8;
thick = 2;

$fs = .2;
$fa = 2;

angles = [-45, -45];

translate([width * 2 + 1, 0, 0]) rotate(180) linear_extrude(thick) difference() {
	union() {
		for(i = [1, -1]) translate([0, i * length[0] / 2, 0]) circle(width);
		translate([0, -length[0] / 2, 0]) square([width, length[0]]);
	}
	for(i = [1, -1]) translate([0, i * length[0] / 2, 0]) circle(hole / 2);
}

for(i = [0, 1]) rotate(i * 180) translate([i * (width + 1), -length[1] / 2 + width / 2, 0]) linear_extrude(thick) difference() {
	union() {
		circle(width);
		square([width, length[1]]);
	}
	circle(hole / 2);
}

for(i = [0, 1]) mirror([0, i, 0]) translate([width * 3 + 2, 1, hole * sin(45) / 2]) intersection() {
	rotate([-90, 0, 0]) rotate_extrude(convexity = 5) {
		square([width, thick]);
		square([hole / 2, thick * 3  +1]);
		translate([0, thick * 3 + .2, 0]) hull() {
			square([hole / 2 + 1, 1]);
			square([hole / 2 - 1, thick * 2]);
		}
	}
	linear_extrude(hole * sin(45), center = true, convexity = 5) for(i = [0, 1]) mirror([i, 0, 0]) difference() {
		square([width, thick * 5]);
		translate([hole * sin(45) / 2, thick, 0]) offset(.2) offset(-.2) square([width, .5]);
		translate([0, hole * sin(45) / 2, 0]) {
			square([1.5, thick * 5]);
			circle(hole * sin(45) / 2 - 1);
		}
	}
}