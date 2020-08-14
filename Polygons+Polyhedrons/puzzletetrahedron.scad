// file puzzletetrahedron.scad
// Creates a "vase box"with  internal diameter that fits
// a tetrahedron with the same "size" variable
// (c) Rich Cameron 2020, License CC-BY

size = 50;

rotate([90 - acos(1/3) / 2, 0, 0]) rotate(45) scale(size / 2) {
	polyhedron([[1, 1, 1], [-1, -1, 1], [1, -1, -1], [-1, 1, -1]], [[0, 1, 2], [1, 2, 3], [0, 1, 3], [0, 2, 3]]);
	%cube(2, center = true);
}