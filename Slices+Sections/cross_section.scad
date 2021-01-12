// file cross_section.scad
// cuts an n-sided prism with a plane at height h and at angle sliceangle([x,y,z])
// (c) 2020 Rich Cameron, CC-BY International license

h = 50; // height of the prism, in mm
n = 4; // number of sides (not counting top and bottom)
// use n = 100 for cylinder
r = h / (2 * cos(180 / n));  //radius of the prism, mm 

rim = 2;

//change next two lines to get different cross-sections 
sliceangle = ([55, 0, 0]); //rotation in degrees about x, y, z axes
sliceheight = h / 2; //height above z = 0 where plane of rotation intersects prism

translate([r + 1, 0, h - sliceheight]) rotate([180, 0, 0]) rotate(sliceangle) intersection() {
	shape();
	%shape();
	hull() {
		translate([0, 0, -rim]) linear_extrude() intersection() {
			offset(-rim) projection(cut = true) shape();
			offset(-rim) projection(cut = true) translate([0, 0, rim * 2]) shape();
		}
		intersection() {
			linear_extrude(1000) square(1000, center = true);
			shape();
		}
	}
}

translate([-r - 1, 0, sliceheight]) rotate(sliceangle) difference() {
	shape();
	%shape();
	hull() {
		translate([0, 0, -rim]) linear_extrude() intersection() {
			offset(-rim) projection(cut = true) shape();
			offset(-rim) projection(cut = true) translate([0, 0, rim * 2]) shape();
		}
		intersection() {
			linear_extrude(1000) square(1000, center = true);
			shape();
		}
	}
	linear_extrude(1000) square(1000, center = true);
}

module shape() rotate([-sliceangle[0], 0, 0]) rotate([0, -sliceangle[1], 0]) rotate([0, 0, -sliceangle[2]]) translate([0, 0, -sliceheight]) cylinder(r = r, h = h, $fn = n);