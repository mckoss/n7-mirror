/*	Nexus 7 ATTACHMENT PLATE Design R2 Sept 22, 2013
	Copyright 2013 Frank Thorley
	N7 CAMERA ADAPTER = ATTACHMENT PLATE + MIRROR HOLDER 
	
	X is Height Direction for Adapter Plate
	Y is Width Direction for Adapter Plate
	Z is Thickness Direction for Adapter Plate
=========================================================================
*/
//	All Dimensions in mm, s & t are perimeter metal band angles in deg.
	a = 2.438;	// Bottom wedge height
	b = 1.778;	// Top wedge height
	c = 2.54;	// Thickness of rectangular edge retainers & flat stock (0.1 inch)
	d = 4.216;	// Height of rectangular edge retainers
 	e = 0.745;	// e = tan(s) * a Top wedge maximum thickness
 	f = 1.346;	// f = tan(t) * b Bottom wedge maximum thickness
	g1 = 49.88;	// Set height of side shields to match mirror support plate
	g2 = 46.3;	// Set width at top of side shields
	g3 = 53.5;	// Set height of front edge of side shields
	h = 124.58;	// Adapter plate long direction width
	i = 25.05;	// Adapter plate short direction width
	mw = 32.15;	// Mirror support plate short direction width (1.2655 inches)
	mh = 68.0;	// Mirror support plate long direction width (2.677 inches) 
	tfb = 4.336;// Width of triangle base for Extruding filler
	j = 45.02;	// Left edge to left row securing holes centerline
	jj = 46.29;	// Left edge to left row  
	k = 62.29;	// Left edge offset for lens opening centerline
	l = 79.56;	// Left edge offset for Row 2 securing holes centerline
	m = 6.0;		// Mirror holder securing hole 1&4 offset from top
	n = 13.5;	// Mirror holder securing hole 2&5 offset from top
	p = 21.0;	// Mirror holder securing hole 3&6 offset from top
	r = 5.0;		// Lens opening radius is 5mm
	s = 17;		// Angle of top wedge in degrees
	t = 37;		// Angle of bottom wedge in degrees
	u = 2.74;	// Attachment holes 0.1 above & below surface is recommend practice
	v = 13.05;	// Camera lens opening C/L offset from top
	w = 1.27;	// Mounting holes radius, make pin radius 0.3 mm less
	x = 119.5;	// h - c -c for length of top rectangular retainer
	y = 122.04;	// Distance to right retainer rectangle y = h - c
	z = 22.51;	// Length of left and right retainer wedges

// START N7 ADAPTER PLATE DESIGN

// Top Plate at Origin	
		difference() {	
 				cube([i,h,c]); // (Height,Width,Thickness) of Plate
// Top Plate Lens Opening
			translate([v,k,-.1]) // Cylinder a little taller than plate
 				cylinder(u,r,r,center,$fn=36);
// Mirror Holder Left Side Attachment Holes
		translate([m,j,-0.1])				
 			cylinder(u,w,w,center,$fn=36);		// Top Left Hole
				translate ([m,j,-0.1])	
					cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink for Heat Riviting
		translate([n,j,-0.1])				
 			cylinder(u,w,w,center,$fn=36);		// Middle Left Hole
				translate ([n,j,-0.1])	
					cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([p,j,-0.1])				
 				cylinder(u,w,w,center,$fn=36);	// Lower Left Hole				
					translate ([p,j,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink

// Mirror Holder Right Side Attachment Holes
			translate([m,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);	// Top Right Hole
					translate ([m,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([n,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);	// MIddle Right Hole
					translate ([n,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([p,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);	// Lower Right Hole
					translate ([p,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
  		} 
// Upper & Lower Triangular Wedges Are Added to 3 Sides to Secure N7BWC to N7
// N7 Left Rectangular Perimeter w/Origin at Bottom Left Corner
  		translate([0,0,-d]) {
  			cube([i,c,d]);
//		Left Edge Upper Retainer Wedge
		rotate ([0,90,0])
			translate ([-d,c,c])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [a,0], [0,e]], paths= [[0,1,2]]);
 		}
//		Left Edge Lower Retainer Wedge
		rotate ([0,-90,0]){
			translate([-d,c,-i])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [b,0], [0,f]], paths= [[0,1,2]]);
		}

// N7 Top Rectangular Perimeter
		translate([0,0,-d]) {
		cube([c,h,d]);
		}
//		Top Edge Upper Retainer Wedge
		rotate ([-90,0,0]){
			translate ([c,0,0])
				linear_extrude (height = h, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [e,0], [0,a]], paths= [[0,1,2]]);
 		}
//		Top Edge Lower Retainer Wedge
		rotate ([90,-0,0]) 
			translate ([c,-d,-h]) {
				linear_extrude (height = h, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [f,0], [0,b]], paths= [[0,1,2]]);
		}
// 	Right Edge Rectangular Perimeter
			translate([0,y,-d]) {
				cube([i,c,d]);
		}
//		Right Edge Upper Retainer Wedge
		rotate ([-180,90,0]){
			translate([0,-h+c,-i])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [a,0], [0,e]], paths= [[0,1,2]]);
		}
//		Right Edge Lower Retainer Wedge
		rotate ([180,-90,0])
			translate ([-d,-h+c,c]){
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [b,0], [0,f]], paths= [[0,1,2]]);
 		}