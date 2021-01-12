// theodorus.scad
// makes a spiral of theodorus
// (c) 2020, Rich Cameron, licensed Creative Commons CC-BY4.0

max = 53; // number of triangles to be made -1 
// if max = 16, 17 triangles will be made
// triangles are right triangles with sides  1 : sqrt(n-1) :sqrt(n)
// 1 <= n <= max +1

xyscale = 10;
wall = 1;
base = 1;

zstep = .2; //should be a multiple of layer height

$fs = .2;
$fa = 2;


function angle(n) = (n > 1) ? asin(1 / sqrt(n)) + angle(n - 1) : 0;

for(i = [1:max]) rotate(angle(i)) linear_extrude(base + (max + 1 - i) * zstep) difference() {
	offset(wall / 2) polygon(xyscale * [[0, 0], [sqrt(i), 0], [sqrt(i), 1]]);
	offset(-wall / 2) polygon(xyscale * [[0, 0], [sqrt(i), 0], [sqrt(i), 1]]);
}

for(i = [1:max]) rotate(angle(i)) linear_extrude(base) difference() {
	polygon(xyscale * [[0, 0], [sqrt(i), 0], [sqrt(i), 1]]);
}

echo(angle(max + 1) % 360);