// file TraingleArea.scad
//This models consists of a three-part triangle. 
// Print out two sets to demonstrate the area of a triangle.
// (c) 2020 Rich Cameron, CC-BY
// measurements in mm

base = 105;
height = 70;
thickness = 20;
twosets = true;

top = base * 1.3; //This is the position of the highest point of the triangle

%translate([0, 0, .1]) square([base, height]);
%color([0, 1, 1, .1]) for(i = [0:base:top]) translate([-i, 0, .1]) polygon([[0, 0], [base, 0], [top, height]]);
#%translate([0, 0, .2]) intersection() {
	for(i = [0:base:top]) translate([-i, 0, 0]) polygon([[0, 0], [base, 0], [top, height]]);
	square([top % base, height]);
}
color([1, 0, 0, .1]) translate([0, 0, .1]) %square([top % base, height]);

//made triangles thicker for easier handling 
linear_extrude(thickness) for(j = twosets ? [0, 1] : [0]) translate(j * [(top % base), height + ceil(top / base) * 2 - 1, 0]) rotate(j * 180) {
	for(i = [0:base:top]) translate([0, i / base * 2, 0]) intersection() {
		translate([-i, 0, 0]) polygon([[0, 0], [base, 0], [top, height]]);
		square([top % base, height]);
	}
	
	for(i = [0:base:top]) translate([1 + j * -(base + 2), i / base * 2, 0]) intersection() {
		translate([-i, 0, 0]) polygon([[0, 0], [base, 0], [top, height]]);
		translate([top % base, 0, 0]) square([base - (top % base), height + ceil(top / base)]);
	}
}

echo((((base % base))));