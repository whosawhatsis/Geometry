// file 3_pyramid_puzzle.scad
// creates 3 oblique square pyramids which collectively form a cube
// (c) 2020 Rich Cameron
// released under a Creative Commons CC-BY 4.0 International License

size = 60; //length of the side of the cube, mm

linear_extrude(size, scale = 0) square(size);