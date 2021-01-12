// file conic_section.scad
// cuts a cone with a plane at height sliceheight and at angle slicetilt. 
// (c) 2020 Rich Cameron, CC-BY International license

h = 50; // height of cone, mm
n = 120;
r = h;  // radius of cone, mm

rim = 2;

slicetilt = 45;// angle of the cutting plane relative to cone base
slicerotate = 0;
 
//sliceheight = h * 3 / 4;
//slicehoffset = r * 1 / 4;
 
sliceheight = 0; // height of the rotation axis above cone base
slicehoffset = 0; // y-axist offset of slice rotation axis
//slicehoffset = r / 8 - 2 * h / tan(slicetilt);
// 2nd cone hyperbola equation if slicehoffset of other cone = -r/8. 

echo(slicehoffset );

sliceangle = [slicetilt, 0, slicerotate];

translate((slicetilt > atan2(h, r)) ? [0, -2, sliceheight] : [r * 2 + 1, 0, rim]) rotate((slicetilt > atan2(h, r)) ? sliceangle : 0) intersection() {
	shape();
	%shape();
	hull() {
		translate([0, 0, -rim]) linear_extrude() intersection() {
			offset(-rim) projection(cut = true) shape(true);
			offset(-rim) projection(cut = true) translate([0, 0, rim * 2]) shape(true);
		}
		intersection() {
			linear_extrude(1000) square(1000, center = true);
			shape();
			//%shape();
		}
	}
}

translate([0, 0, sliceheight]) rotate(sliceangle) difference() {
	shape();
	%shape();
	hull() {
		translate([0, 0, -rim]) linear_extrude() intersection() {
			offset(-rim) projection(cut = true) shape(true);
			offset(-rim) projection(cut = true) translate([0, 0, rim * 2]) shape(true);
		}
		intersection() {
			linear_extrude(1000) square(1000, center = true);
			shape();
			//%shape();
		}
	}
	linear_extrude(1000) square(1000, center = true);
}

module shape(oversize = false) rotate([-sliceangle[0], 0, 0]) rotate([0, -sliceangle[1], 0]) translate([0, -slicehoffset, -sliceheight]) rotate([0, 0, -sliceangle[2]]) cylinder(r1 = oversize ? 2 * r : r, r2 = 0, h = oversize ? 2 * h : h, center = oversize, $fn = n);