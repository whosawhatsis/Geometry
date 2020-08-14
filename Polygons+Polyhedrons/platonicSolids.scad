// file platonicSolids.scad
// makes platonic solids of radius size
// (c) 2020 Rich Cameron, CC-BY 

size = 35;

rotate(72 * 1) translate([size * 1.2, 0, 0]) tetrahedron(size);
rotate(72 * 2) translate([size * 1.2, 0, 0]) cube(size, center = true);
rotate(72 * 3) translate([size * 1.2, 0, 0]) octahedron(size);
rotate(72 * 4) translate([size * 1.2, 0, 0]) dodecahedron(size);
rotate(72 * 5) translate([size * 1.2, 0, 0]) icosahedron(size);
/**/

/*tetrahedron(size);
translate([-size * 1, 0, 0]) cube(size, center = true);
translate([-size * 2.5, 0, 0]) octahedron(size);
translate([-size * 4, 0, 0]) dodecahedron(size);
translate([-size * 5.5, 0, 0]) icosahedron(size);
/**/


module tetrahedron(size = 1) cylinder(r1 = size / sqrt(2), r2 = 0, h = size, center = true, $fn = 3);

module octahedron(size = 1) hull() for(i = [0, 1]) mirror([0, 0, i]) mirror([i, 0, 0]) tetrahedron(size);

module dodecahedron(size = 1) intersection_for(a = [0:72:360]) rotate([0, a ? atan(2) : 0, a]) cylinder(r = size, h = size, center = true, $fn = 10);

module icosahedron(size = 1) intersection_for(a = [0:120:360], b = [-60, 0, 60]) rotate([0, a ? acos(sqrt(5) / 3) : 0, a]) rotate([0, b ? acos(sqrt(5) / 3) : 0, a ? b : 0]) cylinder(r = size, h = size, $fn = 6, center = true);