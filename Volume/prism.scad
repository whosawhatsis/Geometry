// file prism.scad
// creates a prism with either external (wall = 0) or internal (wall > 0) volume equal to v
// (c) 2016-2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

// enter these three variables:

v = 50000; // volume in cubic mm (cc * 1000)
h = 30; // height in mm
n = 300; // number of sides (not including the base and top) - 300 gives a cylinder

offset = [0, 0]; // for an oblique prism, this is the x-y shift of the top relative to the bottom

wall = 1; // set to zero to generate a solid, else this is wall thickness of hollow version

lid = false; //make true to print lids (only for hollow version) 
lip = .25;
tol = .2;

// STL files don't have curves, so a cone must be approximated by using a large number for n. Depending on size, you'll want to find a value for area that results in a side length (check the console output) around 0.2-0.5mm. Sides shorter than this will not look smoother noticeably smoother once printed.

// the rest is calculated...

a = v / h; // base-sectional area
s = 2 * sqrt(a * tan(180 / n) / n);
apothem = (2 * a / n / s);
r = apothem / cos(180 / n);

$fs = .2;
$fa = 2;

difference() {
hull() for(i = [0, 1]) translate(i * (1 + wall / h) * [offset[0], offset[1], h]) cylinder(r = r + wall / cos(180 / n), h = .00001, $fn = n);
	if(wall) hull() for(i = [0, 1]) translate((2 * i + wall / h) * [offset[0], offset[1], h]) cylinder(r = r, h = .00001, $fn = n);
}

if(wall && lid) translate([(r + wall) * 2 + lip + 5, 0, 0]) rotate(180) {
	hull() for(i = [0, 1]) translate(i * (wall / h) * [-offset[0], offset[1], h]) cylinder(r = r + wall / cos(180 / n), h = .00001, $fn = n);
	difference() {
		hull() for(i = [0, 1]) translate(3 * i * (wall / h) * [-offset[0], offset[1], h]) cylinder(r = r - tol / cos(180 / n), h = .00001, $fn = n);
		hull() for(i = [0, 1]) translate(i * [-offset[0], offset[1], h]) cylinder(r = r - (tol + wall) / cos(180 / n), h = .00001, $fn = n);
	}
}

echo(str("base-sectional area: ", a)); // base-sectional area
echo(str("side: ", s)); // side
echo(str("radius: ", r)); // radius
if((n % 2)) echo(str("radius + apothem: ", r + apothem)); // radius + apothem (only calculated for an odd number of sides)
echo(str("apothem: ", apothem)); // apothem
echo(str("circumscribed circle area: ", PI * pow(r, 2))); // circumscribed circle area
echo(str("inscribed circle area: ", PI * pow(apothem, 2))); // inscribed circle area
echo(str("polygon area: ", .5 * n * s * r * cos(180 / n))); // polygon area