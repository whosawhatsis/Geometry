//Program hypotenuse.scad
// (c) Rich Cameron 2020, licensed CC-BY 
// All dimensions mm 

// Length of the hypotenuse (and gauges on side)
hypotenuse = 120;
// Peg height in Z - one bigger than other
peg = 6;

wall = 4;
// Height of the frame in Z dimension 
height = 8;
// Height of the slider in Z dimension (not including pegs)
hypotenuse_height = 4;

//Clearance of pegs
clearance = .25;
// Next function is for future capability- ignore for now
anglegauge = 40;

$fs = .2;
$fa = 2;

translate([-1 - peg - clearance - wall, 1 + peg + clearance + wall, 0]) hypotenuse(0);
//Following line is for possible future capability
//translate([2 * (-1 - peg) - clearance - wall, 1 + peg + 2 * (clearance + wall), 0]) hypotenuse();
frame();

//%mirror([1, 0, 0]) translate([1, 1, 0] * -(peg/2 + clearance + wall)) square([140, 150]);

module hypotenuse(anglegauge = anglegauge) difference() {
	union() {
		linear_extrude(height + hypotenuse_height + 1, convexity = 5) difference() {
			circle(peg/2);
			circle(.2);
		}
		linear_extrude(height + hypotenuse_height, convexity = 5) translate([0, hypotenuse, 0]) difference() {
			circle(peg/2 + .5);
			circle(.2);
		}
		linear_extrude(hypotenuse_height, convexity = 5) difference() {
			hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2);
			for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(.2);
		}
		if(anglegauge) linear_extrude(hypotenuse_height, convexity = 5) mirror([1, 0, 0]) difference() {
			for(i = [0]) translate([0, i * hypotenuse, 0]) intersection() {
				difference() {
					circle(anglegauge / 100 + sqrt(pow(anglegauge, 2) + pow(peg / 2 + clearance + wall, 2)));
					circle(anglegauge / 100 + sqrt(pow(anglegauge, 2) + pow(peg / 2 + clearance + wall, 2)) - wall);
				}
				translate([0, -(clearance + wall), 0]) {
					translate([0, -peg/2, 0]) square(hypotenuse);
					hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2);
				}
			}
			for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(.2);
			for(a = [0:10:90]) rotate(a) translate([anglegauge, -(peg / 2 + clearance + wall), 0]) rotate(-45) square(10);
		}
	}
	if(anglegauge) translate([0, 0, hypotenuse_height]) linear_extrude(hypotenuse_height, center= true, convexity = 5) mirror([1, 0, 0]) intersection() {
		translate([peg / 2, -peg/2 - clearance - wall - 1, 0]) square(hypotenuse);
		for(a = [0:1:90]) rotate(a) translate([anglegauge, -(peg / 2 + clearance + wall), 0]) rotate(-45) offset(-.01) square(10);
	}
	translate([0, hypotenuse / 2, 0]) cube([.01, hypotenuse, 1], center = true);
}
	
module frame() {
	difference() {
		linear_extrude(height + 1, convexity = 5) difference() {
			for(a = [0, 1]) mirror([a, a, 0]) hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2 + clearance + wall);
			for(a = [0, 1]) mirror([a, a, 0]) hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2 + clearance + .5 * (1 - a));
		}
		translate([0, 0, height + 1]) for(a = [0, 1]) mirror([a, a, 0]) {
			linear_extrude(height * 2, center = true, convexity = 5) for(i = [0:10:100]) translate([i * -hypotenuse / 100, -peg/2 - clearance - wall, 0]) rotate(45) square(hypotenuse / 100 / sqrt(2), center = true);
			linear_extrude(height, center = true, convexity = 5) for(i = [0:100]) translate([i * -hypotenuse / 100, -peg/2 - clearance - wall, 0]) rotate(45) square(hypotenuse / 100 / sqrt(2) * .9, center = true);
		}
		*for(a = [0, 1]) mirror([a, a, 0]) {
			for(i = [0:10]) translate([i * -hypotenuse / 10, -peg/2 - clearance - wall, height + 1]) cube([.1, 1, height * 2], center = true);
			for(i = [0:100]) translate([i * -hypotenuse / 100, -peg/2 - clearance - wall, height + 1]) cube([.1, 1, height], center = true);
		}
		*for(a = [0, 1]) mirror([a, a, 0]) {
			for(i = [0:9]) translate([sin(i * 10) * -hypotenuse, peg/2 + clearance + wall, height + 1]) cube([.1, 1, height * 2], center = true);
			for(i = [0:50]) translate([sin(i) * -hypotenuse, +peg/2 + clearance + wall, height + 1]) cube([.1, 1, height], center = true);
		}
	}
	
	linear_extrude(1, convexity = 5) difference() {
		hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2 + clearance + wall / 2);
		mirror([1, 1, 0]) hull() for(i = [0, 1]) translate([0, i * hypotenuse, 0]) circle(peg/2 + clearance);
	}
}