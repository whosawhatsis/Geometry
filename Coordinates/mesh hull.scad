thick = 1;

$fs = .2;
$fa = 2;


amax = 100;
bmax = 100;
function coord(a, b) = [a * sin(b * 90 / bmax), a * cos(b * 90 / bmax), b];

for(a = [0:amax - 1], b = [0:bmax - 2]) hull() 
	for(a = [a, a + 1], b = [b:b+2]) if((a + b) % 2 || b == 0 || b == floor(bmax)) translate(coord(a, b)) cylinder(r = thick / 2, h = .1);