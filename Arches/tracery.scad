// file tracery.scad
// Creates a Gothic window with tracery
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

size = 80; //Overall height of the piece, mm 
wall = 1; //Thickness of the walls, mm
depth = 5; //Depth of the tracery walls, mm
backing = 0; //Thickness of a solid backing plate; 0 creates open tracery

$fs = .2;
$fa = 2;

module shape() {
	translate([0, -size / 2, 0]) square(size, center = true);
	intersection_for(i = [1, -1]) translate([i * size / 2, 0, 0]) circle(size);
}

if(backing) #linear_extrude(backing) shape();

difference() {
	union() {
				for(i = [0:4]) linear_extrude(backing + depth / (i + 1)) for(j = [0:pow(2, i) - 1]) translate([-size * (-.5 + pow(2, -i - 1) + j / pow(2, i)), 0, 0]) difference() {
			offset(wall / 2) intersection_for(k = [-1, 1]) translate([k * size * (.5 - 1 / pow(2, i + 1)), 0, 0]) shape();
			offset(-wall / 2) intersection_for(k = [-1, 1]) translate([k * size * (.5 - 1 / pow(2, i + 1)), 0, 0]) shape();
		}

		linear_extrude(backing + depth / 4) translate([0, size * .6, 0]) rotate(180) difference() {
			offset(wall / 2) trefoil(size * .1125);
			offset(-wall / 2) trefoil(size * .1125);
		}
	}
	#for(i = [0:14]) translate(size * [(i % 2) ? .03 : -.03, .11 + (i % 2) * .11, .2 * i / size]) cube([size, .1, .2], center = true);
}

module trefoil(r) for(a = [0:120:359]) rotate(a) translate([0, r, 0]) circle(r);