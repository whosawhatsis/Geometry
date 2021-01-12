// file sphere_section.scad
// creates a sphere of diameter 50mm sliced by a plane sliceheight mm from the center
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

size = 50; // sphere diameter
sliceheight = 10; // distance of cutting plane from center of sphere

$fs = .2;
$fa = 2;

intersection() {
	linear_extrude(size) square(size * 2 + 5, center = true);
	for(i = [1, -1]) translate(i * [size / 2 + 1, 0, sliceheight]) sphere(size / 2);
}
%for(i = [1, -1]) translate(i * [size / 2 + 1, 0, sliceheight]) sphere(size / 2);