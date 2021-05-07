// file hyperbola_slider.scad
// creates a hyperbola and a circular directrix 
// (c) 2020 Rich Cameron,under a Creative Commons  CC-BY license
// all dimensions in mm

a = 10;  // location of vertices (separation is 2a)
b = 25;  //a * sqrt(3) - works out well for model 
c = sqrt(pow(a, 2) + pow(b, 2));  //location of foci 

wall = 2;  //width of the directrix and its support 

holesize = 5; //size of holes for focus and slider

h = 8; // overall thickness of the 

asymptotes = 1; //notch size for asymptote string 


size = 100; //c + f(length / 2);

length = size * 2 * b / a;

function f(x) = sqrt(pow(a, 2) * (1 + pow(x, 2) / (pow(b, 2))));

$fs = .2;
$fa = 2;



rotate(45) {
	%translate([0, -c, 0]) difference() {
		translate([0, -c, 0]) circle(2 * a);
		translate([0, -c, 0]) circle();
	}
	
	difference() {
		translate([0, -c, 0]) {
			intersection() {
				for(i = [0, 1]) mirror([0, 0, i]) hull() for(i = [0, 1]) translate([0, 0, -h / 2]) linear_extrude(1 + i * h / 2) offset(i * -h / 2) intersection() {
					polygon([for(x = [-length / 2:length / 2]) [x, f(x)]]);
					translate([0, -c, 0]) offset(i * h) frame();
				}
				linear_extrude(h, center = true) translate([0, -c, 0]) frame();
			}
			translate([0, -c, 0]) linear_extrude(h, center = true) difference() {
				frame();
				offset(5) offset(-wall - 5) frame();
			}
			intersection() {
					translate([0, -c, 0]) rotate_extrude() translate([size, 0, 0]) intersection() {
					scale([.75, 1, 1]) circle(h / 2);
					translate([-wall / 2, -h, 0]) square(h * 2);
				}
				linear_extrude(h, center = true) translate([0, -c, 0]) scale((size + h) / size) frame();
			}
			linear_extrude(h, center = true) translate([0, -c, 0]) intersection() {
				frame();
				difference() {
					circle(2 * a);
					offset(-wall) circle(2 * a);
				}
			}
		}
		rotate_extrude() for(m = [0, 1]) mirror([0, m, 0]) {
			square([holesize / 2, h]);
			translate([holesize / 2, h / 2 - wall, 0]) hull() for(a = [45, 90]) rotate(a) square([h, holesize / 2]);
		}
		if(asymptotes) for(j = [1, -1]) translate([0, -c, h / 2 * j]) {
			for(i = [-1, 1]) rotate(i * atan2(a, b)) rotate([90, 0, 90]) cylinder(r = asymptotes, h = size * 2, center = true, $fn = 6);
		}
	}
	
	translate([0, a - c - 2, 1]) rotate(180) slider();
}


module frame() intersection() {
	circle(c + f(length / 2));
	intersection() {
		intersection_for(i = [0, 1]) mirror([i, 0, 0]) rotate(atan2(b, a)) translate([0, -size, 0]) square(2 * size);
		circle(size);
	}
}
	


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