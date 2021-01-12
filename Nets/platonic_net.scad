// file platonic_net.scad
// creates 2D nets of pyramids and prisms
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

faces = 4; // tetrahedron
//faces = 6; // cube
//faces = 8; // octahedron
//faces = 12; // dodecahedron
//faces = 20; // icosahedron

edge = 10; // edge length, used to determine the size.
linewidth = 0; // cut/fold line width for 2D export. Set to zero for 3D
baselayer = 1; // height of print below (outside) the hinges
printheight = 50; // total height to truncate the pyramidal sides
hinge = .201; // thickness of the hinges. Using a negative value will leave a gap


solid = // Schläfli symbol
(faces == 4) ? [3, 3] :
(faces == 6) ? [4, 3] :
(faces == 8) ? [3, 4] :
(faces == 12) ? [5, 3] :
(faces == 20) ? [3, 5] :
0;

assert(solid, str("There are no ", faces, "-sided platonic solids. Please choose either 4, 6, 8, 12, or 20."));

face = solid[0]; // vertices touching each face
vertex = solid[1]; // faces touching each vertex

size = edge / 2 / tan(180 / face); // apothem of the polygonal sides

echo(str("surface area = ", faces * face * size * size * tan(180 / face), "mm^2"));

dihedral = 2 * asin(cos(180 / vertex) / sin(180 / face));

module face(outer = 0) rotate(180 / face) {
	if(linewidth) offset((outer ? 1 : -1) * linewidth / 2) circle(size / cos(180 / face), $fn = face);
	else if(outer) intersection() {
		union() {
			linear_extrude(size * tan(dihedral / 2), scale = 0) circle(size / cos(180 / face), $fn = face);
			mirror([0, 0, 1]) linear_extrude(size * tan(max(90 - dihedral / 2, 45)), scale = 0) circle(size / cos(180 / face), $fn = face);
		}
		translate([0, 0, -baselayer]) linear_extrude(printheight) offset(min(hinge, -.001)) circle(size / cos(180 / face), $fn = face);
	}
	else circle(size / cos(180 / face), $fn = face);
}
	

module iterate(fold = false, a = face, branch = 0, outer = 0) {
	face(outer);
	if(a || (!branch && (vertex != face))) mirror([0, (a < 0) ? 0 : 1, 0]) for(i = [0:abs(abs(a) - 1)]) rotate((i + floor(face / 2)) * 360 / face) translate([size, 0, 0]) rotate([0, fold ? dihedral - 180 : 0, 0]) translate([size, 0, 0]) rotate(180) {
		if(a == face) iterate(fold, face - vertex, branch + i, outer);
		else if(a == -2) iterate(fold, i ? -1 : 1, branch + i * 3 - 3, outer);
		else if(a == 2 && !i) iterate(fold, 0, branch + i, outer);
		else if(a == -1) iterate(fold, 1, branch + i, outer);
		else if(a == 1 && vertex == 5) iterate(fold, 0, branch + i, outer);
		else if(!branch && !i) iterate(fold, 0, 1, outer);
	}
}
difference() {
	iterate(outer = true);
	if(linewidth) iterate();
}
if(!linewidth && (hinge > 0)) #linear_extrude(hinge) offset(-size / vertex) offset(.001) iterate();
%iterate(true, outer = true);


/*face();
for(i = [0:face - 1]) rotate(i * 360 / face) translate([size, 0, 0]) rotate([0, fold ? dihedral - 180 : 0, 0]) translate([size, 0, 0]) rotate(180) {
	face();
	for(j = [(vertex > 3) ? 1 : 2:face - ((vertex > 3) ? 1 : 3)]) rotate(j * 360 / face) translate([size, 0, 0]) rotate([0, fold ? dihedral - 180 : 0, 0]) translate([size, 0, 0]) rotate(180) {
		face();
		for(k = [(vertex > 3) ? j - 1 : 1:face - ((vertex > 3) ? 2 : 4)]) rotate((j + k) * 360 / face) translate([size, 0, 0]) rotate([0, fold ? dihedral - 180 : 0, 0]) translate([size, 0, 0]) rotate(180) {
			face();
		}
	}
}*/
