// file castle.scad
// Creates a simple castle wall with towers and crenellation
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

wall = 100; //length of a castle wall, mm
height = 40; //height of a castle wall, mm
thick = 4; //thickness of the wall, mm


for(side = [0:1:3]) {
	rotate(90 * side) {
		translate([-wall / 2, wall / 2, 0]) {
			translate([0, -thick / 2, 0]) {
				cube([wall, thick, height - thick]);
				for(crenellation = [0:thick * 2:wall - thick]) {
					translate([crenellation, 0, 0]) {
						cube([thick, thick, height]);
					} //end translate
				} //end for
			} //end translate

			cylinder(h = height, r = 1.5 * thick);
			translate([0, 0, height]) {
				cylinder(h = 3 * thick, r1 = 1.5 * thick, r2 = 0);
			} //end translate
		} //end translate
	} //end rotate
} //end for


