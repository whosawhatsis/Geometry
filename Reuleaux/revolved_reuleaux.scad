// file revolved_reuleaux.scad
// Creates Reuleaux constant-width figures of revolultion
// 
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

width = 50; //constant width 
reuleaux = 3; // number of sides, odd numbers 3 thru 13

$fs = .2;
$fa = 2;

if((reuleaux % 2) != 1 || reuleaux < 3) {
	echo("Reuleaux polygons must have an odd number of sides.");
} else {
	rotate_extrude() intersection() {
		intersection_for(a = [0:360 / reuleaux:359]) rotate(a) translate([0, width / (sin(180 / reuleaux) / sin(90 / reuleaux)), 0]) circle(width);
		translate([0, -width, 0]) square(width * 2);
	}
}