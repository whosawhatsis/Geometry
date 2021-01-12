// file conic_sections_set.scad
// creates a sliced cone showing a circle, ellipse, parabola and 
// half hyperbola 
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

// it is recommended that this model be scaled in a slicer. 
// do not attempt to change relative scales in the model. 
$fs = .2;
$fa = 2;

rim = 4;

module cone(r = 50, h = 50, oversize = false) cylinder(r1 = oversize ? 2 * r : r, r2 = 0, h = oversize ? 2 * h : h, center = oversize);

rotate(180) {
	//%translate([-50, -60, 0]) square([140, 150]);
	
	translate([-10, 65, 0]) intersection() {
		translate([20, 0, -40]) cone();
		hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) translate([20, 0, -40]) cone(oversize = true);
	}
	
	translate([25, 65, 0]) rotate([0, 0, 0]) intersection() {
		rotate([0, -22.5, 0]) difference() {
			translate([20, 0, -40]) cone();
			hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) translate([20, 0, -40]) cone(oversize = true);
		}
		hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -22.5, 0]) translate([20, 0, -40]) cone(oversize = true);
	}
	
	translate([5, 0, 40]) rotate([0, 22.5 * 2, 0]) intersection() {
		rotate([0, -22.5, 0]) difference() {
			rotate([0, -22.5, 0]) translate([20, 0, -40]) cone();
			hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -22.5, 0]) translate([20, 0, -40]) cone(oversize = true);
		}
		hull() for(i = [0, 5]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -45, 0]) translate([20, 0, -40]) cone(oversize = true);
	}
	
	translate([0, 0, 40]) rotate([0, 22.5 * 4, 0]) difference() {
		rotate([0, -22.5 * 2, 0]) difference() {
			rotate([0, -22.5 * 2, 0]) translate([20, 0, -40]) cone();
			hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -45, 0]) translate([20, 0, -40]) cone(oversize = true);
			hull() for(i = [0, 5]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -45, 0]) translate([20, 0, -40]) cone(oversize = true);
		}
		mirror([0, 0, 1]) hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -67.5, 0]) translate([20, 0, -40]) cone(oversize = true);
	}
	
	translate([-5, 0, 40]) rotate([0, 22.5 * 4, 0]) intersection() {
		rotate([0, -22.5 * 4, 0]) translate([20, 0, -40]) cone();
		mirror([0, 0, 1]) hull() for(i = [0, 1]) translate([0, 0, i * rim]) linear_extrude(100) offset(-rim + i * rim) projection(cut = true) rotate([0, -67.5, 0]) translate([20, 0, -40]) cone(oversize = true);
	}
}