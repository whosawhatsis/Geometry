// file meissner.scad
// Creates miessner tetrahedrons 
// 
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

size = 50; // radius of the spheres, and also the constant width 
meissner = 1; // Meissner tetrahedron (1 or 2) or 0 for Reuleaux tetrahedron 

$fs = .2;
$fa = 2;

difference() {
	intersection_for(i = [0:3]) translate(size / sqrt(2) / 2 * [(i % 2) ? 1 : -1, (i == 1 || i == 2) ? -1 : 1, (i > 1) ? 1 : -1]) sphere(size);
	if(meissner) for(i = [0:2]) rotate(90 * [i ? 1 : 0, (i == 2) ? 1 : 0, i]) rotate([0, (meissner - 1) * 180, 0]) translate(size * 3/4 * sqrt(2) * [0, 0, 1]) rotate([90, 0, -45]) 
		difference() {
		scale([1 / sqrt(2), 1, 1]) rotate(45) cube(size, center = true);
		translate(size / sqrt(2) * [0, -1, 0]) rotate_extrude() intersection() {
			translate(size * [-cos(30), 0, 0]) circle(size);
			translate([0, -size / 2, 0]) square(size);
		}
	}
}