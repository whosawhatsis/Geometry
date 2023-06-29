// file Triangle Angles.scad
// Demonstrates that the angles of a triangle sum to 180 degrees
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

base = 105;
height = 70;
thickness = 20;

top = base * 1.3;

r = 30;

$fs = .1;
$fa = 2;

corners = [[0, 0], [top, height], [base, 0]];// - [for(i = [0:2]) [top / 2, height / 2]];

%linear_extrude(thickness) {
	difference() {
		polygon(corners);
		for(c = corners) translate(c) circle(r);
	}
	for(i = [0:2]) translate([i - 1, (i - 1) ? -1 : 1, 0]) intersection() {
		polygon(corners);
		translate(corners[i]) circle(r);
	}
}

for(i = [0:2]) translate(2 * [base / 2 + i - 1, -1, 0]) rotate(180) %offset(0) intersection() {
	rotate(180 * i) translate(-corners[i]) polygon(corners);
	circle(r);

}