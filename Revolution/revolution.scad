// file revolution.scad
// creates 3D surface of revolution from 2D shape
// (c) 2020-2021 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License


wall = 4; //width of 2D shape 
thick = 4; // thickness of 2D shape
hole = 2; // size of hole in 3D shape for pivot
clearance = .3; //clearance between 2D and 3D shape 

$fs = .2;
$fa = 2;

translate([40, 70, 0]) frame();
revolution();
translate([80, 0, 0]) revolution(true);

// The following lines define different shapes of rotation. 
// Remove the "//" from one, and only one, of these lines. 

// Create a double cone from a square rotated about a diagonal 
// Note: makes 2 cones, need to be assembled 
//module shape() rotate(45) square(50, center = true);

// Create a cylinder from a square rotated about a line parallel to a side:
//module shape() translate([0, 25, 0]) rotate(0) square(50, center = true);

// Create a sphere from a circle rotated about a diameter 
// Note: makes 2 hemispheres  need to be assembled 
//module shape() circle (25, center = true);

//Create a shape from a hexagon rotated about line thru vertices:
//module shape() translate([0, 25 * cos(180 / 6), 0]) rotate(0) circle(r = 25, $fn = 6);

//Create a shape from an octagon rotated about a line parallel to a side
//module shape() translate([0, 25 * cos(180 / 8), 0]) rotate(180 / 8) circle(r = 25, $fn = 8);

// Create a shape from a triangle, rotate in x 
//module shape() translate([0, 25 * cos(180 / 3), 0]) rotate(-30) circle(r = 25, $fn = 3);  

//End definitions 


module outline() for(i = [0, 1]) mirror([i, 0, 0]) shape();

module frame() translate([0, 0, thick / 2]) {
	difference() {
		linear_extrude(thick, center = true, convexity = 5) difference() {
			offset(wall + clearance) outline();
			offset(clearance) outline();
		}
		rotate([90, 0, 0]) cylinder(r = hole / 2, h = 1000, center = true);
	}
	#%linear_extrude(.1) shape();
}

module revolution(bottom = false) rotate_extrude() intersection() {
	mirror([0, bottom ? 1 : 0, 0]) outline();
	translate([hole / 2, 0, 0]) square(1000); 
}
