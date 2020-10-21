r = 25;

wall = 1;
base = 1;
clearance = .3;

simple = false;
cylinder_handle = true; //add a handle to the positive cylinder to help avoid getting it stuck inside the negative one

$fs = .2;
$fa = 2;

module cyl(negative = true) difference() {
	rotate_extrude() intersection() {
		difference() {
			if(negative) square([r + wall, r + base]);
			translate([0, negative ? r + base : 0, 0]) mirror([0, negative ? 1 : 0, 0]) square([r - (negative ? 0 : clearance), r]);
		}
		square([r + wall, r + base]);
	}
	if(!negative && cylinder_handle) difference() {
		sphere(r / 2);
		rotate([90, 0, 0]) cylinder(r = 1.5, h = r, center = true);
	}
}

module hemisphere(negative = true) rotate_extrude() 
intersection() {
	difference() {
		if(negative) {
			if(simple) square([r + wall, r + base]);
			else offset(-r) offset(r)  {
				translate([wall, r + base, 0]) circle(r);
				square(r / 2);
			}
		}
		translate([0, negative ? r + base : 0, 0]) mirror([0, negative ? 1 : 0, 0]) scale([negative ? 1 : (r - clearance) / r, 1, 1]) circle(r);
	}
	square([r + wall, r + base]);
}

module cone(negative = true) rotate_extrude() 
intersection() {
	difference() {
		if(negative) {
			if(simple) square([r + wall, r + base]);
			else offset(-r) offset(r) {
				polygon([[wall, 0], [r + wall, r + base], [wall, r + base]]);
				square(r / 2);
			}
		}		translate([0, negative ? r + base : 0, 0]) mirror([0, negative ? 1 : 0, 0]) polygon((negative ? r : r - clearance) * [[0, 0], [1, 0], [0, 1]]);
	}
	square([r + wall, r + base]);
}

for(i = [0, 1]) translate(2 * (r + wall + 1) * [i - .5, -sin(60), 0]) cyl(i);
for(i = [0, 1]) translate(2 * (r + wall + 1) * [i, 0, 0]) hemisphere(i);
for(i = [0, 1]) translate(2 * (r + wall + 1) * [i - .5, sin(60), 0]) cone(i);
