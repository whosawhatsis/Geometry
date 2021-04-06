// file golden_ratio.scad
// Creates successive rectangles whose smallest side is the large side of 
// the next rectangle. Rectangle sides in ratio of phi to each other
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License
phi = (1 + sqrt(5)) / 2;

for(i = [0:10]) rotate(i * 0) mirror((i % 2) * [1, -1, 0]) linear_extrude(12 - i) square(pow(phi, i) * [1, phi]);