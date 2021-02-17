// file areaWedges.scad
//Prints out wedges making up a circle, and a rectangular enclosure
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

r = 30;
sides = 6;
thick = 10;
notch = 2;
spacing = 3;

frame = 10;

$fs = .2;
$fa = 2;

for(a = [0:360 / sides:359]) rotate(a) translate([0, spacing / sin(360 / sides), 0]) if(a == 0) {
	for(i = [1, -1]) translate([i * spacing / 3, 0, 0]) if(thick) {
		intersection() {
			translate([i * r, r, 0]) cube(r * 2, center = true);
			union() {
				linear_extrude(thick / 2) wedge(true);
				linear_extrude(thick) wedge();
			}
		}
	} else intersection() {
		translate([i * r, r, 0]) square(r * 2, center = true);
		wedge(true);
	}
} else {
	if(thick) {
		linear_extrude(thick / 2) wedge(true);
		linear_extrude(thick) wedge();
	} else wedge(true);
}

if(frame) translate([1, 1, 0] * (-r - frame - spacing * (1 + 1 / sin(360 / sides)))) {
	if(thick) linear_extrude(thick / 2) frame();
	else frame();
}
	
module frame() difference() {
	square([r + frame, r * PI + frame]);
	translate([frame, frame, 0]) square([r + frame, r * PI + frame]);
}

module wedge(round = false) {
	difference() {
		intersection() {
			if(round) circle(r);
			else circle(r, $fn = sides);
			intersection_for(a = [-1, 1]) rotate(a * (90 - 180 / sides)) translate([-r, 0, 0]) square(r * 2);
		}
		rotate(-180 / sides) translate([0, r / 2, 0]) circle(notch, $fn = 4);
	}
	rotate(180 / sides) translate([0, r / 2, 0]) circle(notch, $fn = 4);
}