// file cone_cylinder_net.scad
// creates 2D nets of cones and cylinders 
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License
// intended to be exported as .dxf or .sgv format and printed on paper

r = 20; // radius, mm
h = 20; // height, mm
cone = false; //set to true to make a cone, false to make cylinder
linewidth = 0; //set to nonzero for 3D 

$fs = .2;
$fa = 2;

slant_h = sqrt(pow(r, 2) + pow(h, 2));

echo(str("surface area = ", PI * r * (r + slant_h), "mm^2"));

module net() {
	circle(r);
	if(cone) {
		translate([r + slant_h, 0, 0]) sector(360 * r / slant_h, slant_h);
	} else {
		translate([h / 2 + r, 0, 0]) square([h, r * 2 * PI], center = true);
		translate([h + r * 2, 0, 0]) circle(r);
	}
}

module sector(a, r) intersection() {
	circle(r);
	if(a > 180) for(i = [-1, 1]) rotate(i * (90 + a / 2)) translate([0, -r, 0]) square(2 * r);
	else intersection_for(i = [-1, 1]) rotate(i * (90 + a / 2)) translate([0, -r, 0]) square(2 * r);
}

difference() {
	offset(linewidth / 2) net();
	if(linewidth) offset(-linewidth / 2) net();
}

%cylinder(r1 = r, r2 = cone ? 0 : r, h = h);