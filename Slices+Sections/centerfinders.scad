// file centerfinders.scad
// Creates nested "D" shapes to construct parabolas and hyperbolas
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License


w = 2; //width of the D lines, mm
h = 2; //thickness of the D lines, mm
hole = 1; //size of notch to mark parabola, mm
enclosed = false; //if true makes a circle around the marking hole

radii = [10:6:60]; //radii of the "D" shapes

$fs = .2;
$fa = 2;

echo(len([for(i = radii) i]) - 1);

for(i = [0:len([for(i = radii) i]) - 1], radius = [for(i = radii) i][i]) translate([0, -i * (enclosed ? 2 : 1) * (w + hole / 2 + .5), 0]) difference() {
	if(h) {
		linear_extrude(h, convexity = 2) shape(radius, hole, w, enclosed);
		if(enclosed) cylinder(r1 = 0, r2 = h * 2, h = h * 2);
	} else shape(radius, hole, w, enclosed);
}

module shape(radius, hole, w, enclosed = false) difference() {
			intersection() {
				circle(radius);
				translate([-radius, enclosed ? -w / 2 : 0, 0]) square(radius * 2);
			}
			circle(hole / 2);
			offset(-w) difference() {
				intersection() {
					circle(radius);
					translate([-radius, enclosed ? -w / 2 : 0, 0]) square(radius * 2);
				}
				circle(hole / 2);
			}
		}
		if(enclosed) difference() {
			offset(w) circle(hole / 2);
			circle(hole / 2);
		}