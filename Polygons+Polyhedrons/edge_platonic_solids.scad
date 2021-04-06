// file edge_platonic_solids.scad
// creates platonic solids specified by length of an edge in mm
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

edge = 50 / sqrt(2); //length of the edge of each solid
// to get just one solid, comment out the others

%rotate([45, 35, 0]) cube(48.8, center = true);

//translate(edge * [.75, -.75, 0]) tetrahedron(edge);
//translate(edge * [1.5, 1.5, 0]) cube(edge);
octahedron(edge, true);
//translate(edge * [2, 0, 0]) dodecahedron(edge);
//translate(edge * [.5, 1.6, 0]) icosahedron(edge);

//%cube(1, center = true);

phi = (1 + sqrt(5)) / 2;

module tetrahedron(edge = 1, center = false) translate([0, 0, center ? 0 : edge * sqrt(2) / sqrt(3) / 2]) cylinder(r1 = edge / sqrt(3), r2 = 0, h = edge * sqrt(2) / sqrt(3), center = true, $fn = 3);

module octahedron(edge = 1, center = false) translate([0, 0, center ? 0 : edge * sqrt(2) / sqrt(3) / 2]) hull() for(i = [0, 1]) mirror([0, 0, i]) mirror([i, 0, 0]) tetrahedron(edge, true);
	
module dodecahedron(edge = 1, center = false) scale(pow(phi, 5 / 2) / pow(5, 1 / 4)) translate([0, 0, center ? 0 : edge / 2]) intersection_for(a = [0:72:360]) rotate([0, a ? atan(2) : 0, a]) cylinder(r = edge, h = edge, center = true, $fn = 10);

module icosahedron(edge = 1, center = false) scale(pow(phi, 2) / sqrt(3)) translate([0, 0, center ? 0 : edge / 2]) intersection_for(a = [0:120:360], b = [-60, 0, 60]) rotate([0, a ? acos(sqrt(5) / 3) : 0, a]) rotate([0, b ? acos(sqrt(5) / 3) : 0, a ? b : 0]) cylinder(r = edge, h = edge, $fn = 6, center = true);