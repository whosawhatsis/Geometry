size = 60;
wall = 1;


$fs = .2;
$fa = 2;



module shape() {
	translate([0, -size / 2, 0]) square(size, center = true);
	intersection_for(i = [1, -1]) translate([i * size / 2, 0, 0]) circle(size);
}

#linear_extrude(.5) shape();

for(i = [0:4]) linear_extrude(.5 + 10 / (i + 1)) for(j = [0:pow(2, i) - 1]) translate([-size * (-.5 + pow(2, -i - 1) + j / pow(2, i)), 0, 0]) difference() {
	offset(wall / 2) intersection_for(k = [-1, 1]) translate([k * size * (.5 - 1 / pow(2, i + 1)), 0, 0]) shape();
	offset(-wall / 2) intersection_for(k = [-1, 1]) translate([k * size * (.5 - 1 / pow(2, i + 1)), 0, 0]) shape();
}




