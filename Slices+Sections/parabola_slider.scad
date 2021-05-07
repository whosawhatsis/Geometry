// file parabola_slider.scad
// creates a hyperbola and a circular directrix 
// (c) 2021 Rich Cameron, released under a 
// Creative Commons  CC-BY 4.0 International License
// Dimensions are in mm

length = 100; //longest dimension of model 
a = length / 8;  //focus to vertex distance 
holesize = 5; //size of the hole in slider and at focus

h = 8; //thickness of model
wall = 2; //width of directrix frame 

$fs = .2;
$fa = 2;


translate([0, 0, h / 2]) difference() {
	union() {
		for(i = [0, 1]) mirror([0, 0, i]) 
		hull() for(i = [0, 1]) translate([0, 0, -h / 2]) linear_extrude(1 + i * h / 2) offset(i * -h / 2) polygon([for(x = [-length / 2:length / 2]) [x, pow(x, 2) / 4 / a - a]]);
		translate([0, pow(length / 2, 2) / 4 / a - a, 0]) rotate([0, 90, 0]) linear_extrude(length, center = true) hull() {
			scale([1, .75, 1]) circle(h / 2);
			rotate(-135) square(h / 2);
		}
		difference() {
			linear_extrude(h, center = true) translate([-length / 2, -2 * a, 0]) difference() {
				square([length, pow(length / 2, 2) / 4 / a + a]);
				offset(h) offset(-h - wall) square([length, pow(length / 2, 2) / 4 / a + a]);
			}
			translate([0, pow(length / 2, 2) / 4 / a - a, 0]) rotate([0, 90, 0]) cylinder(r = h / 2 - 1, h = length + 1, center = true, $fn = 4);
		}
	}
	rotate_extrude() for(m = [0, 1]) mirror([0, m, 0]) {
		square([holesize / 2, h]);
		translate([holesize / 2, h / 2 - wall, 0]) hull() for(a = [45, 90]) rotate(a) square([h, holesize / 2]);
	}

}


translate([0, -a - 2, h / 2 + 1]) rotate(180) slider();
	
module slider() difference() {
	linear_extrude(h + 2, convexity = 5, center = true) difference() {
		offset(1 + wall) offset(-1) circle(holesize);
		*offset(1) offset(-1) intersection() {
			rotate(45) offset(-.5) square(holesize * 2);
			circle(holesize);
			translate([-holesize, -.5, 0]) square(holesize * 2);
		}
	}
	linear_extrude(h - 2.9, center = true) offset(1) offset(-1) intersection() {
		rotate(45) offset(-.5) square(holesize * 2);
		circle(holesize);
		translate([-holesize, -.5, 0]) square(holesize * 2);
	};
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