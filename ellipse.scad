d = [120, 90];
string = 5;
step = 10;

h = 8;
wall = 2;

$fs = .2;
$fa = 2;

focus = [max(0, sqrt(pow(d[0], 2) - pow(d[1], 2)) / 2), max(0, sqrt(pow(d[1], 2) - pow(d[0], 2)) / 2)];

difference() {
	hull() for(j = [0, 1]) linear_extrude(h - j * wall * 2, center = true) difference() {
		offset(wall * (-1 + j)) scale([1 / d[1], 1 / d[0], 1]) circle(d[0] * d[1] / 2);
		for(i = [-1, 1]) translate(i * focus) circle(string / 2);
	}
	for(i = [-1, 1]) translate(i * focus) rotate_extrude() hole();
}

#translate([d[0] / sqrt(2) / 2 + wall + string / 2, d[1] / sqrt(2) / 2 + wall + string / 2, 0]) rotate_extrude() intersection() {
	translate([0, -h / 2, 0]) square([string / 2 + wall * 2, h]);
	difference() {
		hole(wall);
		hole();
	}
}



//#for(x = [2.5:5:d[0] / 2], i = [-1, 1]) polygon(i * path(x));

function path(x) = [focus, [x, sqrt(pow(d[1] / 2, 2) * (1 - pow(x / (d[0] / 2), 2)))], -focus, [x, -sqrt(pow(d[1] / 2, 2) * (1 - pow(x / (d[0] / 2), 2)))]];

module hole(offset = 0) for(m = [0, 1]) mirror([0, m, 0]) {
		square([string / 2 + offset, h]);
		translate([string / 2 + offset, h / 2 - wall, 0]) hull() for(a = [45, 90]) rotate(a) square([h, string / 2 + offset]);
	}