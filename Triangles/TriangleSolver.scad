//Program TriangleSolver.scad
// (c) Rich Cameron 2020, licensed CC-BY 
// All dimensions mm 

thick = 3; //How thick the triangle is in the 3rd dimension

trianglebase = 30; //Make this larger if scaleset triangles overlap. 
// Should be equal to the base side of the triangle.

// Four options for specifying triangle are
// side-side-side (sides in mm)
//sss(10, 10, 10); 
// side-angle-side (sides in mm, angle in degrees)
//sas(10, 60, 10);
// angle-side-angle(side in mm, angles in degrees)
//asa(60, 10, 60);
// side-angle-angle(side in mm, angles in degrees)
//saa(10, 60, 60);
// First side dimension given is used as the base

// the next line uses side-side-side to create three scaled triangles.
// Parameters in scaled brackets are the scaling factor 
// from the original triangle
// replace "sas" with one of the above alternatives if desired
// If you give it a geometrically-impossible set of parameters it will
// do nothing

thicken() scaleset(trianglebase, [.5, 1, 2]) sas(30, 45, 30); 
		
module thicken() if(thick) linear_extrude(thick) children();
	else children();

module scaleset(base, sizes = [1, 2]) for(i = [0:len(sizes) - 1]) translate([base * sum(sizes, i - 1) + i, 0, 0]) scale([sizes[i], sizes[i], 1]) children();
	
function sum(v, i) = (i >= 0) ? v[i] + sum(v, i-1) : 0;


module triangle(angleA = 0, sideB = 0, angleC = 0, sideA = 0, angleB = 0, sideC = 0) {
	if(((angleA ? 1 : 0) + (sideB ? 1 : 0) + (angleC ? 1 : 0) + (sideA ? 1 : 0) + (angleB ? 1 : 0) + (sideC ? 1 : 0)) > 3) 
		echo(str("Triangle with ",
			angleA ? str("angleA = " , angleA, ", ") : "",
			sideB ? str("sideB = " , sideB, ", ") : "",
			angleC ? str("angleC = " , angleC, ", ") : "",
			sideA ? str("sideA = " , sideA, ", ") : "",
			angleB ? str("angleB = " , angleB, ", ") : "",
			sideC ? str("sideC = " , sideC, ", ") : "",
			"is over-constrained."
		));
	
	else if(((angleA ? 1 : 0) + (sideB ? 1 : 0) + (angleC ? 1 : 0) + (sideA ? 1 : 0) + (angleB ? 1 : 0) + (sideC ? 1 : 0)) < 3) 
		echo(str("Triangle with ",
			angleA ? str("angleA = " , angleA, ", ") : "",
			sideB ? str("sideB = " , sideB, ", ") : "",
			angleC ? str("angleC = " , angleC, ", ") : "",
			sideA ? str("sideA = " , sideA, ", ") : "",
			angleB ? str("angleB = " , angleB, ", ") : "",
			sideC ? str("sideC = " , sideC, ", ") : "",
			"is under-constrained."
		));
	
	else if(!angleA && sideB && !angleC && sideA && !angleB && sideC) sss(sideA, sideB, sideC);
	
	else if(angleA && sideB && angleC && !sideA && !angleB && !sideC) asa(angleA, sideB, angleC);
	else if(!angleA && !sideB && angleC && sideA && angleB && !sideC) asa(angleC, sideA, angleB);
	else if(angleA && !sideB && !angleC && !sideA && angleB && sideC) asa(angleB, sideC, angleA);
	
	else if(!angleA && sideB && angleC && sideA && !angleB && !sideC) sas(sideB, angleC, sideA);
	else if(!angleA && !sideB && !angleC && sideA && angleB && sideC) sas(sideA, angleB, sideC);
	else if(angleA && sideB && !angleC && !sideA && !angleB && sideC) sas(sideC, angleA, sideB);
	
	else if(!angleA && sideB && angleC && !sideA && angleB && !sideC) saa(sideB, angleC, angleB);
	else if(angleA && !sideB && !angleC && sideA && angleB && !sideC) saa(sideA, angleB, angleA);
	else if(angleA && !sideB && angleC && !sideA && !angleB && sideC) saa(sideC, angleA, angleC);
		
	else if(!angleA && !sideB && angleC && !sideA && angleB && sideC)
		translate([sideC, 0, 0]) mirror([1, 0, 0]) saa(sideC, angleC, angleB);
	else if(angleA && sideB && !angleC && !sideA && angleB && !sideC)
		translate([sideB, 0, 0]) mirror([1, 0, 0]) saa(sideB, angleB, angleA);
	else if(angleA && !sideB && angleC && AsideA && !angleB && !sideC)
		translate([sideA, 0, 0]) mirror([1, 0, 0]) saa(sideA, angleA, angleC);
	
	else echo(str("Triangle with ",
			angleA ? str("angleA = " , angleA, ", ") : "",
			sideB ? str("sideB = " , sideB, ", ") : "",
			angleC ? str("angleC = " , angleC, ", ") : "",
			sideA ? str("sideA = " , sideA, ", ") : "",
			angleB ? str("angleB = " , angleB, ", ") : "",
			sideC ? str("sideC = " , sideC, ", ") : "",
		"is not properly constrained."
	));
}

module sss(sideB, sideA, sideC) {
	polygon([
		[0, 0],
		[sideB, 0],
		[
			sideB - (((pow(sideA, 2) + pow(sideB, 2) - pow(sideC, 2)) / 2 / sideA / sideB)) * sideA,
			sin(acos((pow(sideA, 2) + pow(sideB, 2) - pow(sideC, 2)) / 2 / sideA / sideB)) * sideA
		]
	]);
	echo(str(
		"angles: ", 
		acos((pow(sideB, 2) + pow(sideC, 2) - pow(sideA, 2)) / 2 / sideB / sideC),
		", ", 
		acos((pow(sideA, 2) + pow(sideC, 2) - pow(sideB, 2)) / 2 / sideA / sideC),
		", ", 
		acos((pow(sideA, 2) + pow(sideB, 2) - pow(sideC, 2)) / 2 / sideA / sideB)
	));
	echo(str(
		"sides: ",
		sideA,
		", ",
		sideB,
		", ",
		sideC
	));
}

module sas(sideB, angleC, sideA) {
	polygon([
		[0, 0],
		[sideB, 0],
		[
			sideB - cos(angleC) * sideA,
			sin(angleC) * sideA
		]
	]);
	echo(str(
		"angles: ", 
		asin(sin(angleC) * sideA / sqrt(pow(sideA, 2) + pow(sideB, 2) - 2 * sideA * sideB * cos(angleC))),
		", ", 
		asin(sin(angleC) * sideB / sqrt(pow(sideA, 2) + pow(sideB, 2) - 2 * sideA * sideB * cos(angleC))),
		", ", 
		angleC
	));
	echo(str(
		"sides: ",
		sideA,
		", ",
		sideB,
		", ",
		sqrt(pow(sideA, 2) + pow(sideB, 2) - 2 * sideA * sideB * cos(angleC))
	));
}

module asa(angleA, sideB, angleC) {
	polygon([
		[0, 0],
		[sideB, 0],
		[
			sideB - cos(angleC) * sideB * sin(angleA) / sin(180 - angleA - angleC),
			sin(angleC) * sideB * sin(angleA) / sin(180 - angleA - angleC),
		]
	]);
	echo(str(
		"angles: ",
		angleA, 
		", ", 
		180 - angleA - angleC, 
		", ", 
		angleC
	));
	echo(str(
		"sides: ",
		sideB * sin(angleA) / sin(180 - angleA - angleC),
		", ",
		sideB,
		", ",
		sideB * sin(angleC) / sin(180 - angleA - angleC)
	));
}

module saa(sideB, angleC, angleB) {
	polygon([
		[0, 0],
		[sideB, 0],
		[
			sideB - cos(angleC) * sideB * sin(180 - angleC - angleB) / sin(angleB),
			sin(angleC) * sideB * sin(180 - angleC - angleB) / sin(angleB),
		]
	]);
	echo(str(
		"angles: ",
		180 - angleC - angleB,
		", ",
		angleB,
		", ",
		angleC
	));
	echo(str(
		"sides: ",
		sideB * sin(180 - angleC - angleB) / sin(angleB),
		", ",
		sideB,
		", ",
		sideB * sin(angleC) / sin(angleB)
	));
}
