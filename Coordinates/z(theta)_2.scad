$fs = .2;
$fa = 2;

//width of the vertical connector
zthick = 5;
//clearance between connecting parts
clearance = .3;
//radial wall thickness of the connector tube
tubewall = 1.2;

step = 1;

function z(theta) = 100 * theta / 90;

difference() {
	union() {
		for(theta = [0:90/step - 1], r = [0:100/step - 2]) hull() for(theta = [theta, theta + 1]) rotate(theta * step) translate([0, 0, z(theta * step)]) linear_extrude(0.1) for(r = [r:r + 2]) if((theta + r) % 2 || r == 0 || r == 100/step) translate([r * step, 0, 0]) circle(r = tubewall / 2);
		cylinder(r = zthick / 2 + clearance + tubewall, h = 100);
	}
	translate([0, 0, -1]) cylinder(r = zthick / 2 + clearance, h = 102);
}