$fs = .2;
$fa = 2;

//width of the vertical connector
zthick = 5;
//clearance between connecting parts
clearance = .3;
//radial wall thickness of the connector tube
tubewall = 1.2;

step = 1;

function z(theta) = [100 * theta / 90, 100 * (theta + 1) / 90];
function r(theta) = [0:step:100];

difference() {
	union() {
		for(theta = [0:step:90 - step]) hull() for(theta = [theta, theta + step]) rotate(theta) for(r = r(theta), z = z(theta)) translate([r, 0, z]) linear_extrude(0.1) circle(r = tubewall / 2);
		cylinder(r = zthick / 2 + clearance + tubewall, h = 100);
	}
	translate([0, 0, -1]) cylinder(r = zthick / 2 + clearance, h = 102);
}