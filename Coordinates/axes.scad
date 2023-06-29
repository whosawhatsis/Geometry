// file axes.scad
// Creates 3D axis visualizations
// (c) 2021 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License
// All measurements in mm

piece = "x/y grid"; // [x/y grid, polargrid, protractor, zgrid, altgrid, x/y axes]

//radius/length of axes
radius = 100;
//maximum angle for polargrid/protractor
angle = 90;
//thickness of the base part
base = 2;
//length for x/y axes
axes_length = 90;
//width of the xy axes
axes_thick = 4;
//width of the vertical connector
zthick = 5;
//length of the vertical connector
zlength = 25;
//clearance between connecting parts
clearance = .3;
//radial wall thickness of the connector tube
tubewall = 1.2;
//thickness of lines on grids
line = 2;

{}

$fs = .2;
$fa = 2;

if(piece == "x/y grid") xygrid();
if(piece == "polargrid") polargrid();
if(piece == "protractor") protractor();
if(piece == "zgrid") zgrid();
if(piece == "altgrid") altgrid();
if(piece == "x/y axes") xyaxes();


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
		cylinder(r = zthick / 2, h = zlength);
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
		cylinder(r = zthick / 2, h = zlength);
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
				linear_extrude(base + line / 2, convexity = 5) square(radius);
				linear_extrude(base, convexity = 5) offset(line / 2) square(radius);
			}
			union() {
				for(x = [0:10:radius]) translate([x, 0, base]) rotate([0, 90, 90]) cylinder(r = line / 2, h = radius + line, $fn = 4);
				for(y = [0:10:radius]) translate([0, y, base]) rotate([0, 90, 0]) cylinder(r = line / 2, h = radius + line, $fn = 4);
			}
		}
		cylinder(r = zthick / 2, h = zlength);
	}
}

module xyaxes() {
	linear_extrude(axes_thick) difference() {
		union() for(a = [0, 1]) mirror([a, -a, 0]) {
			hull() for(i = [0, axes_length - axes_thick / 2]) translate([i, 0, 0]) circle(axes_thick / 2, $fn = 4);
			translate([axes_length, 0, 0]) rotate(135) difference() {
				square(axes_thick * 3);
				translate([axes_thick, axes_thick, 0]) square(axes_thick * 3);
			}
			circle(axes_thick * 1.5);
		}
		circle(zthick / 2 + clearance);
	}
	*cylinder(r = zthick / 2, h = axes_thick + axes_length);
	linear_extrude(zlength - axes_thick) difference() {
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
		linear_extrude(axes_thick, convexity = 5) difference() {
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

module altgrid() intersection() {
	rotate([90, 0, 0]) linear_extrude(zthick * 2, center = true, convexity = 5) intersection() {
		translate([-zthick, 0, 0]) square([radius + zthick, radius]);
		offset(5) offset(-5) square([radius * 2, radius * 2], center = true);
		difference() {
			circle(radius);
			for(a = [0:90]) rotate(a) translate([radius, 0, 0]) rotate(180) circle(.5, $fn = 4);
				*circle(zthick / 2 + clearance);
		}
		
	}
	union() {
		linear_extrude(axes_thick, convexity = 5) difference() {
			circle(zthick);
			circle(zthick / 2 + clearance);
		}
		linear_extrude(radius, convexity = 5) difference() {
			union() {
				offset(tubewall) circle(zthick / 2 + clearance);
				square([radius, zthick / 2 + clearance + tubewall]);
			}
			circle(zthick / 2 + clearance);
		}
		difference() {
			rotate([90, 0, 0]) union() {
				for(a = [0:15:90]) rotate(a) translate([radius, 0, 0]) rotate([0, 90, 0]) cylinder(r = line / 2, h = radius * 2, center = true, $fn = 4);
				for(a = [0:5:90]) rotate(a) translate([radius, 0, 0]) rotate([0, 90, 0]) intersection() {
					cylinder(r = line / 2, h = 6 + line, center = true, $fn = 4);
					hull() for(i = [-1, 1]) translate([0, 0, i * 3]) rotate([90, 0, 0]) cylinder(r = line / 2, h = line, center = true, $fn = 4);
				}
				intersection() {
					linear_extrude(base + line / 2) arc(angle = 90);
					rotate_extrude() for(i = [10:10:radius - 5]) translate([i, 0, 0]) circle(r = line / 2, $fn = 4);
				}
			}
			translate([0, 0, -1]) cylinder(r = zthick / 2 + clearance + tubewall / 2, h = radius + 2);
		}
	}
}

module arc(radius = radius, angle = angle) intersection() {
	circle(radius);
	if(angle < 180) intersection_for(a = [0, 180 - angle]) rotate(-a) translate([-radius, 0, 0]) square(radius * 2);
	else union() for(a = [0, 180 - angle]) rotate(-a) translate([-radius, 0, 0]) square(radius * 2);
}