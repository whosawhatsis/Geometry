node = 5;
edge = 1.5;
minwall = 1;

quickpreview = true;

$fs = .2;
$fa = 2;

$fn = (quickpreview && $preview) ? 3 : 0;

module transform() translate([0, 0, 45]) rotate([20, 30, 0]) children();

nodes = 25 * [[1, 1, 1], [-1, 1, 1], [1, -1, 1], [-1, -1, 1], [1, 1, -1], [-1, 1, -1], [1, -1, -1], [-1, -1, -1]];

edges = [[0, 1], [0, 2], [2, 3], [1, 3], [0, 4], [1, 5], [2, 6], [3, 7], [4, 5], [4, 6], [6, 7], [5, 7], ];

for(i = [0:len(nodes) - 1]) transform() translate(nodes[i]) sphere(node / 2);
for(i = [0:len(edges) - 1]) hull() for(end = [0, 1]) transform() translate(nodes[edges[i][end]]) sphere(edge / 2);

#intersection() {
	translate([0, 0, 1000]) cube(2000, center = true);
	union() {
		for(i = [0:len(nodes) - 1]) hull() for(m = [0, 1]) mirror([0, 0, m]) transform() translate(nodes[i]) sphere(max(minwall / 2, node / 2 * sin(45)));
		for(i = [0:len(edges) - 1]) hull() for(m = [0, 1]) mirror([0, 0, m]) for(end = [0, 1]) transform() translate(nodes[edges[i][end]]) sphere(max(minwall / 2, edge / 2 * sin(45)));
	}
}


linear_extrude(1) offset(1) projection(cut = true) {
	union() {
		for(i = [0:len(nodes) - 1]) hull() for(m = [0, 1]) mirror([0, 0, m]) transform() translate(nodes[i]) sphere(max(minwall / 2, node / 2 * sin(45)));
		for(i = [0:len(edges) - 1]) hull() for(m = [0, 1]) mirror([0, 0, m]) for(end = [0, 1]) transform() translate(nodes[edges[i][end]]) sphere(max(minwall / 2, edge / 2 * sin(45)));
	}
}
