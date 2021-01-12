// file pyramid.scad
// creates a pyramid with either external (wall = 0) or internal (wall > 0) volume equal to v
// (c) 2016-2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

// enter these three variables:

v = 25000; // volume in cubic mm (cc * 1000)
h = 50; // height in mm
n = 300; // number of sides (not including the base)

offset = [0, 0]; // for an oblique prism, this is the x-y shift of the top relative to the bottom

ball = 0; // radius of a ball on top - if less than wall thickness, will slightly round off top 
wall = 1; // set to zero to generate a solid
basewall = 2.2;

lid = false; //make true to print lids (only for hollow version) 
lip = .25;
tol = .2;

// STL files don't have curves, so a cone must be approximated by using a large number for n. Depending on size, you'll want to find a value for area that results in a side length (check the console output) around 0.2-0.5mm. Sides shorter than this will not look smoother noticeably smoother once printed.

// the rest is calculated...

a = v / h * 3; // base-sectional area
s = 2 * sqrt(a * tan(180 / n) / n);
apothem = (2 * a / n / s);
r = apothem / cos(180 / n);

$fs = .2;
$fa = 2;

difference() {
	union() {
		hull() for(i = [0, 1]) translate((1 - i) * [offset[0], offset[1], h]) cylinder(r = i * r + .00001 + wall / cos(180 / n), h = .00001, $fn = n);
		translate([offset[0], offset[1], h]) sphere(max(ball, wall));
	}
	if(wall) difference() {
		hull() for(i = [0, 1]) {
			translate((1 - i * 2) * [offset[0], offset[1], h]) cylinder(r = i * r * 2 + .00001, h = .00001, $fn = n);
		}
		linear_extrude(1, center = true, convexity = 5) difference() {
			circle(r + wall / cos(180 / n), $fn = n);
			circle(r + (wall - basewall) / cos(180 / n), $fn = n);
		}
	} 
}

if(wall && lid) translate([(r + wall) * 2 + lip + 5, 0, 0]) union() {
	cylinder(r = r + (wall + lip) / cos(180 / n), h = wall, $fn = n);
	intersection() {
		translate([0, 0, wall]) hull() for(i = [0, 1]) translate((1 - i) * [offset[0], offset[1], h]) cylinder(r = i * r + .00001, h = .00001, $fn = n);
		linear_extrude(wall * 3, convexity = 5) difference() {
			circle(r + (wall - basewall - tol) / cos(180 / n), $fn = n);
			circle(r + (wall - basewall - tol - wall) / cos(180 / n), $fn = n);
		}
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