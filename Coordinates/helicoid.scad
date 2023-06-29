$fs = .2;
$fa = 2;

//width of the vertical connector
zthick = 5;
//clearance between connecting parts
clearance = .3;
//radial wall thickness of the connector tube
tubewall = 1.6;

linear_extrude(100, twist = -90, slices = 1000) difference() {
	union() {
		translate([-tubewall / 2, 0, 0]) square([tubewall, 100]);
		circle(zthick / 2 + clearance + tubewall, $fn = 0);
	}
	circle(zthick / 2 + clearance, $fn = 0);
}