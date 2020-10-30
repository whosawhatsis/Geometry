// File gnomon.scad
// Prints out a gnomon with sun angle marked 
// Long side goes on the ground, short side is the gnomon 
// (c) 20019-2020 Rich Cameron
// Released under a CC-BY 4.0 International License

size = 80; //hieght of the gnomon
max_angle = 65; //maximum sun angle that can be measured 

rotate([0, -90, 0]) {
	linear_extrude(size) square(10);
	mirror([0, 1, 0]) translate([0, -10, -10]) cube([10, size * tan(max_angle) + 10 + 1, 10 - .2]);
	mirror([0, 0, 1]) linear_extrude(10) difference() {
		mirror([0, 1, 0]) translate([0, -10, 0]) square([10, size * tan(max_angle) + 10 + 1]);
		for(i = [10:10:max_angle]) translate([10, -size * tan(i) + 1, 0]) text(str(90 - i), size = 4.5, halign = "right");
		for(i = [0:10:max_angle]) translate([0, -size * tan(i), 0]) square([10, .2]);
		for(i = [0:5:max_angle]) translate([0, -size * tan(i), 0]) square([8, .2]);
		for(i = [0:1:max_angle]) translate([0, -size * tan(i), 0]) square([2, .2]);
	}
}