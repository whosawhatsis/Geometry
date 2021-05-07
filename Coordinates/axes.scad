// file axes.scad
// Creates 3D axis visualizations
// (c) 2021 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License
// All measurements in mm

radius = 100; //radius of the base
base = 2; //thickness of the base part
axes = 90; //length of the xy axes
xythick = 4; //width of the xy axes
zthick = 5; //width of the z axis
zlength = 20; //length of the z axis
angle = 90; //degrees of the wedge on the protractor
clearance = .3; //clearance between connecting parts
tube = 20;//length of the z axis connector
tubewall = 1.2; //radial wall thickness of the connector tube
line = 2; //thickness of lines on grids 

$fs = .2;
$fa = 2;

// Remove comments from one of the next five code lines to get the element you want.
// Make sure to keep the other parameters consistent so that the pieces will fit together. 

// Uncomment next line to get xy axes.
//translate(-(xythick * 2.5 + zthick) * [1, 1, 0]) xyaxes();

// Uncomment next line to get vertical grid. 
//translate(-(xythick * 2.5 + zthick) * [1, 1, 0]) rotate(angle) zgrid();

// Uncomment next line to get the protractor-style wedge. 
//protractor();

// Uncomment the next line to get the xy grid.
//xygrid();

// Uncomment the next line to get the polar wedge grid. 
//polargrid();



module protractor() difference() {
	union() {
		linear_extrude(base, convexity = 5) offset(zthick) arc(radius - zthick);
		cylinder(r = zthick, h = base + line / 2);
		intersection() {
			cylinder(r = radius, h = base + line / 2);
			union() {
				for(a = [0:10:angle]) rotate(a) translate([radius, 0, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = 20, center = true, $fn = 4);
				for(a = [0:5:angle]) rotate(a) translate([radius, 0, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = 6, center = true, $fn = 4);
			}
		}
		cylinder(r = zthick / 2, h = xythick + zlength);
	}
	linear_extrude(base + line / 2, convexity = 5) for(a = [0:angle]) rotate(a) translate([radius, 0, 0]) rotate(180) circle(.5, $fn = 4);
			*circle(zthick / 2 + clearance);
}

module polargrid() difference() {
	union() {
		linear_extrude(base, convexity = 5) offset(zthick) arc(radius - zthick);
		cylinder(r = zthick, h = base + line / 2);
		intersection() {
			cylinder(r = radius, h = base + line / 2);
			union() {
				for(a = [0:15:angle]) rotate(a) translate([radius, 0, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = radius * 2, center = true, $fn = 4);
				for(a = [0:5:angle]) rotate(a) translate([radius, 0, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = 6, center = true, $fn = 4);
			}
		}
		intersection() {
			linear_extrude(base + line / 2) arc();
			rotate_extrude() for(i = [10:10:radius - 5]) translate([i, base, 0]) circle(r = line / 2, $fn = 4);
		}
		cylinder(r = zthick / 2, h = xythick + zlength);
	}
	linear_extrude(base + line / 2, convexity = 5) for(a = [0:angle]) rotate(a) translate([radius, 0, 0]) rotate(180) circle(.5, $fn = 4);
			*circle(zthick / 2 + clearance);
}

module xygrid() {
	union() {
		linear_extrude(base, convexity = 5) offset(zthick) square(radius);
		cylinder(r = zthick, h = base + line / 2);
		intersection() {
			hull() {
				linear_extrude(base + line / 2, convexity = 5)square(radius);
				linear_extrude(base, convexity = 5) offset(line / 2) square(radius);
			}
			union() {
				for(x = [0:10:radius]) translate([x, 0, base]) rotate([0, 90, 90]) cylinder(r = line / 2, h = radius + line, $fn = 4);
				for(y = [0:10:radius]) translate([0, y, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = radius + line, $fn = 4);
			}
		}
		cylinder(r = zthick / 2, h = xythick + zlength);
	}
}

module xyaxes() {
	linear_extrude(xythick) difference() {
		for(a = [0, 1]) mirror([a, -a, 0]) {
			hull() for(i = [0, axes - xythick / 2]) translate([i, 0, 0]) circle(xythick / 2, $fn = 4);
			translate([axes, 0, 0]) rotate(135) difference() {
				square(xythick * 3);
				translate([xythick, xythick, 0]) square(xythick * 3);
			}
			circle(xythick * 1.5);
		}
		circle(zthick / 2 + clearance);
	}
	*cylinder(r = zthick / 2, h = xythick + axes);
	linear_extrude(tube) difference() {
		offset(tubewall) circle(zthick / 2 + clearance);
		circle(zthick / 2 + clearance);
	}
}

module zgrid() intersection() {
	rotate([90, 0, 0]) linear_extrude(zthick * 2, center = true, convexity = 5) intersection() {
		translate([-zthick, 0, 0]) square([radius + zthick, radius]);
		offset(5) offset(-5) square([radius * 2, radius * 2], center = true);
	}
	union() {
		linear_extrude(xythick, convexity = 5) difference() {
			circle(zthick);
			circle(zthick / 2 + clearance);
		}
		linear_extrude(radius, convexity = 5) difference() {
			union() {
				offset(tubewall) circle(zthick / 2 + clearance);
				square([radius, zthick / 2 + clearance + tubewall]);
				for(x = [0:10:radius]) translate([x, 0, 0]) circle(line / 2, $fn = 4);
			}
			circle(zthick / 2 + clearance);
		}
		for(z = [0:10:radius]) translate([zthick / 2 + clearance, 0, z]) rotate([0, 90, 0]) cylinder(r = line / 2, h = radius - zthick / 2 - clearance, $fn = 4);
	}
}

module arc(radius = radius, angle = angle) intersection() {
	circle(radius);
	if(angle < 180) intersection_for(a = [0, 180 - angle]) rotate(-a) translate([-radius, 0, 0]) square(radius * 2);
	else for(a = [0, 180 - angle]) rotate(-a) translate([-radius, 0, 0]) square(radius * 2);
}