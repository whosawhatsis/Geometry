$fs = .2;
$fa = 2;

//width of the vertical connector
zthick = 5;
//clearance between connecting parts
clearance = .3;
//radial wall thickness of the connector tube
tubewall = 1.2;

step = 1;

function r(theta) = 100 * theta / 90;

linear_extrude(100, convexity = 5) difference() {
	union() {
		for(theta = [0:step:90 - step]) hull() for(theta = [theta, theta + step]) rotate(theta) translate([r(theta), 0, 0]) circle(r = tubewall / 2);
		circle(zthick / 2 + clearance + tubewall);
	}
	circle(zthick / 2 + clearance);
}
linear_extrude(1, convexity = 5) difference() {
	union() {
		for(theta = [0:step:90 - step]) hull() for(theta = [theta, theta + step]) rotate(theta) translate([r(theta), 0, 0]) circle(r = tubewall);
		circle(zthick / 2 + clearance + tubewall * 2);
	}
	circle(zthick / 2 + clearance);
}