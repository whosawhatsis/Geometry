// file sun_dial_gnomon.scad
// Creates a gnomon for a sundial to be used at the given latitude
// 
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

length = 100; //length of the base of the triangle, mm 
base = 30; //width of the base of the triangle, mm
latitude = 34.1; //latitude of user, degrees 
thickness = 2.2; //thickness of the piece, mm

rotate([90, 0, 90]) linear_extrude(thickness, center = true) polygon([[0, 0], [0, length], [length * tan(abs(latitude)), 0]]);
translate([-base / 2, -thickness, 0]) cube([base, thickness, length]);
