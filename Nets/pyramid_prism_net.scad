// file pyramid_prism_net.scad
// creates 2D nets of pyramids and prisms
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License
r = 20; //radius, mm 
h = 30; //height
sides = 4;//number of faces on side of prism or pyramid (e.g. tetrahdron =3)
pyramid = true; //true gives a pyramid, false a prism
star = true; //true lays out net in star shape, false in linear 
linewidth = 0; // cut/fold line width for 2D export. Set to zero for 3D
baselayer = 0; // height of print below (outside) the hinges to limit back-bending. Use at least 1 unless printing with TPU.
printheight = 500; // total height to truncate the pyramidal sides
hinge = .6; // thickness of the hinges. Using a negative value will leave a gap
hingeratio = 2; // length/thickness ratio for hinges. Spreads the bend out to reduce fatigue

$fs = .2;
$fa = 2;

echo(str("surface area = ", (pyramid ? 1 : 2) * sides * r * sin(180 / sides) * r * cos(180 / sides) + sides * (pyramid ? h / sin(atan(h / (r * cos(180 / sides)))) : h * 2) * r * sin(180 / sides), "mm^2"));

module end(r, sides, a, offset = 0, extrude = false) {
	if(extrude) intersection() {
		hull() for(i = [0, 1]) translate([0, 0, i * -baselayer]) linear_extrude(h / 2, scale = 0) offset(i * -baselayer) end(r, sides, a);
		translate([0, 0, -baselayer]) linear_extrude(extrude) end(r, sides, a, offset);
	} else rotate(180 / sides) offset(offset) circle(r = r, $fn = sides);
}
module rect(h, r, a, offset = 0, extrude = false) {
	if(extrude) intersection() {
		hull() for(i = [0, 1]) translate([0, 0, i * -baselayer]) translate([-h / 2, 0, 0]) linear_extrude(r * cos(180 / sides), scale = 0) translate([h / 2, 0, 0]) offset(i * -baselayer) rect(h, r, a);
		translate([0, 0, -baselayer]) linear_extrude(extrude) rect(h, r, a, offset);
	} else offset(offset) translate([-h / 2, 0, 0]) square([h, 2 * r * sin(180 / sides)], center = true);
}
module tri(slant_h, h, r, a, offset = 0, extrude = false) {
	apex_l = sqrt(pow(r * cos(180 / sides), 2) + pow(h / 2, 2));
	apex_a = a - atan2(h / 2, r * cos(180 / sides));
	if(extrude) intersection() {
		hull() for(i = [0, 1]) translate([0, 0, i * -baselayer]) translate([-slant_h + apex_l * cos(apex_a), 0, 0]) linear_extrude(apex_l * sin(apex_a), scale = 0) translate([slant_h - apex_l * cos(apex_a), 0, 0]) offset(i * -baselayer) tri(slant_h, h, r, a);
		translate([0, 0, -baselayer]) linear_extrude(extrude) tri(slant_h, h, r, a, offset);
	}
	else offset(offset) scale([slant_h, r * sin(180 / sides), 1]) polygon([[-1, -1], [0, 0], [-1, 1]]);
}

module net(fold = false, pyramid = pyramid, r = r, h = h, sides = sides, star = star, offset = 0, extrude = linewidth ? 0 : printheight) {
	slant_a = pyramid ? atan(h / (r * cos(180 / sides))) : 90;
	slant_h = pyramid ? h / sin(slant_a) : h;
	
	end(r, sides, slant_a, offset, extrude);
	if(!pyramid) translate(fold ? [0, 0, h] : 2 * [r * cos(180 / sides) + h / 2, 0, 0]) rotate(fold ? [180, 0, 0] : 180) end(r, sides, slant_a, offset, extrude);
	for(i = [0:sides - 1]) rotate((star || fold) ? i * 360 / sides : 0) translate([r * cos(180 / sides), 0, 0]) rotate([0, fold ? slant_a - 180 : 0, 0]) translate([slant_h, 0, 0]) {
		if(pyramid) rotate((star || fold) ? 0 : (i - floor(sides / 2)) * atan((r * sin(180 / sides)) / slant_h) * 2) tri(slant_h, h, r, slant_a, offset, extrude);
		else translate([0, (star || fold) ? 0 : (i - floor(sides / 2)) * 2 * r * sin(180 / sides), 0]) rect(slant_h, r, 90, offset, extrude);
	}
	//echo(atan((r * sin(180 / sides)) / slant_h) * 2);
}

if(linewidth) difference() {
	net(offset = linewidth / 2);
	net(offset = -linewidth / 2);
} else {
	net(offset = (hinge < 0) ? hinge : min(-hinge * hingeratio, -.001));
	if(hinge > 0) linear_extrude(hinge) offset(-hinge * hingeratio) {
		offset(-r * sin(180 / sides) / 3) net(offset = .001, extrude = 0);
		net(offset = -.001, extrude = 0);
	}
}
%net(true);