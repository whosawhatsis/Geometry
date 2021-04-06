// file arches.scad
// Creates Gothic or circular arches, made up of smaller "stones
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

size = 80; //diameter of the arch opening at the base, mm
w = 10; //width of the bricks that make the arch, mm
thick = w; //height of the print, set to 0 for 2D printing on paper
segments = 11; // Number of stones; use 10.01 for a small keystone (the stone on top of a Gothic arch)
gap = 0.1; //Gap between stones (to leave space for mortar, for example), mm
separate = 0; //Extra spacing between the stones for printing (to ensure that they don't stick together).

gothic = false; //Make this true to print a Gothic arch, false for a circular one 

$fs = .2;
$fa = 2;
	

if(thick) linear_extrude(thick) {
	arch();
} else {
	arch();
}


module arch() {
	if(gothic) for(i = [0:segments / 2 - .0001], j = [0, 1]) mirror([j, 0, 0]) translate([separate * (floor((segments / 2 - .0001)) - i), separate * i, 0]) intersection() {
		difference() {
			translate([-size / 2, 0, 0]) circle(size + w);
			translate([-size / 2, 0, 0]) circle(size);
		}
		square(size + w);
		if(segments > 1) offset(-gap / 2) translate([-size / 2, 0, 0]) rotate(120 / segments * i) intersection() {
			square(size + w * 2);
			if((segments % 2) || (i < (segments / 2 - 1))) rotate(-90 + 120 / segments) square(size + w * 2);
			else rotate(-120 / segments * i) translate([size / 2, 0, 0]) square(size + w);
		}
	} else for(i = [0:segments / 2 - .0001], j = [0, 1]) mirror([j, 0, 0]) translate([separate * (floor((segments / 2 - .0001)) - i), separate * i, 0])intersection() {
		difference() {
			circle(size / 2 + w);
			circle(size / 2);
		}
		square(size + w);
		if(segments > 1) offset(-gap / 2) rotate(180 / segments * i) intersection() {
			square(size + w);
			rotate(-90 + 180 / segments) square(size + w);
		}
	}
	
	translate([0, -2 - separate, 0]) difference() {
		translate([-size / 2 - w * 2, -w, 0]) square([size + w * 4, w + 2]);
		translate([-size / 2 - w * 1, 0, 0]) square([size + w * 2, w + 2]);
	}
}