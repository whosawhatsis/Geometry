// file castle_advanced.scad
// Creates a castle with Gothic or circular arched windows
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

wall = 100; //length of a castle wall, mm
height = 40; //height of a castle wall, mm
thick = 4; //thickness of the wall, mm

$fs = .2;
$fa = 2;
//make the basic castle and then subtract off the windows/door
difference() {
	for(side = [0:1:3]) {
		rotate(90 * side) {
			translate([-wall / 2, wall / 2, 0]) {
				translate([0, -thick / 2, 0]) {
					cube([wall, thick, height]);
					for(crenellation = [0:thick * 2:wall - thick]) {
						translate([crenellation, 0, 0]) {
							cube([thick, thick, height + thick]);
						} //end translate
					} //end for
				} //end translate
					
				cylinder(h = height + thick, r = 1.5 * thick);
				translate([0, 0, height + thick]) {
					cylinder(h = 3 * thick, r1 = 1.5 * thick, r2 = 0);
				} //end translate
			} //end translate
		} //end rotate
	} //end for
	for(a = [1:1:3]) rotate([90, 0, a * 90]) for(i = [-2:1:2]) translate([i * wall / 6, 20, 0]) arch([5, 10, wall], true);
	rotate([90, 0, 0]) {
		for(i = [-2, 2]) translate([i * wall / 6, 20, 0]) arch([5, 10, wall], true);
		translate([0, 20, 0]) arch([25, 25, wall], false);
	}
}
//module which creates arched door on one side and windows on all

module arch(size, gothic = true) {
	if(size[2]) {
		linear_extrude(size[2]) arch([size[0], size[1], 0], gothic);
	}
	else intersection() {
		union() {
			if(gothic) intersection_for(i = [-1, 1]) translate([size[0] / 2 * i, 0, 0]) circle(size[0]);
			else circle(size[0] / 2);
			if(height > 0) translate([-size[0] / 2, -size[1], 0]) square([size[0], size[1]]);
		}
		translate([-size[0] / 2, -size[1], 0]) square([size[0], size[0] + size[1]]);
	}
}