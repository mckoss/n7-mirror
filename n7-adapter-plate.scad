/*	Nexus 7 ATTACHMENT PLATE Design Sept 22, 2013
	Copyright 2013 Frank Thorley
	N7 CAMERA ADAPTER = ATTACHMENT PLATE + MIRROR HOLDER 
	
	X is Height Direction for Adapter Plate
	Y is Width Direction for Adapter Plate
	Z is Thickness Direction for Adapter Plate
=========================================================================
*/
//	All Dimensions in mm, Angles (s & t) in Degrees
	a = 2.438;	// Bottom wedge height
	b = 1.778;	// Top wedge height
	c = 2.54;	// Thickness of rectangular edge retainers
	d = 4.216;	// Height of rectangular edge retainers
 	e = 0.745;	// e = tan(s) * a Top wedge thickness
 	f = 1.346;	// f = tan(t) * b Bottom wedge thickness
	g = 2.54;	// Top plate thickness ~ 0.1"
	h = 124.58;	// Top plate width
	i = 25.05;	// Top plate height
	j = 45.02;	// Left edge offset for Row 1 securing holes centerline
	k = 62.29;	// Left edge offset for lens opening centerline
	l = 79.56;	// Left edge offset for Row 2 securing holes centerline
	m = 6.0;		// Mirror holder securing hole 1&4 offset from top
	n = 13.5;	// Mirror holder securing hole 2&5 offset from top
	p = 21.0;	// Mirror holder securing hole 3&6 offset from top
	r = 5.0;		// Lens opening 5mm radius
	s = 17;		// Angle of top wedge in degrees
	t = 37;		// Angle of bottom wedge in degrees
	u = 2.74;	// 0.1 above & 0.1 below surface to clear ALL holes
	v = 13.05;	// Lens opening offset from top
	w = 1.27;	// Mounting holes(6)radius, make pin radius 0.2 mm less
	x = 119.5;	// h - c -c for for length of top rectangular retainer
	y = 122.04;	// Distance to right retainer rectangle y = h - c
	z = 22.51;	// Length of left and right retainer wedges
// Top Plate at Origin	
		difference() {	
 				cube([i,124.58,g]); // "h" not working for dimension???
// Top Plate Lens Opening
			translate([v,k,-.1]) // Cylinder a little taller than plate
 				cylinder(u,r,r,center,$fn=36);
// Mirror Holder Left Side Securing Holes
			translate([m,j,-0.1])				
 				cylinder(u,w,w,center,$fn=36);	// Top Left Hole
					translate ([m,j,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink for Heat Riviting
			translate([n,j,-0.1])				
 				cylinder(u,w,w,center,$fn=36);
					translate ([n,j,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([p,j,-0.1])				
 				cylinder(u,w,w,center,$fn=36);					
					translate ([p,j,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
// Mirror Holder Right Side Securing Holes
			translate([m,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);
					translate ([m,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([n,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);
					translate ([n,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
			translate([p,l,-0.1])				
 				cylinder(u,w,w,center,$fn=36);
					translate ([p,l,-0.1])	
						cylinder (0.8,1.7*w,w,center,$fn=36); // Countersink
  		} 
// Upper & Lower Triangular Wedges Are Added to 3 Sides to Secure N7BWC to N7
// N7 Left Rectangular Perimeter w/Origin at Bottom Left Corner
  		translate([0,0,-d]) {
  			cube([i,c,d]);
//		Left Edge Upper Retainer Wedge
		rotate (a = [0,90,0])
			translate ([-d,c,c])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [a,0], [0,e]], paths= [[0,1,2]]);
 		}
//		Left Edge Lower Retainer Wedge
		rotate (a = [0,-90,0]){
			translate([-d,c,-i])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [b,0], [0,f]], paths= [[0,1,2]]);
		}

// N7 Top Rectangular Perimeter
		translate([0,0,-d]) {
		cube([c,h,d]);
		}
//		Top Edge Upper Retainer Wedge
		rotate (a = [-90,0,0]){
			translate ([c,0,0])
				linear_extrude (height = h, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [e,0], [0,a]], paths= [[0,1,2]]);
 		}
//		Top Edge Lower Retainer Wedge
		rotate (a = [90,-0,0]) 
			translate ([c,-d,-h]) {
				linear_extrude (height = h, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [f,0], [0,b]], paths= [[0,1,2]]);
		}
// 	Right Edge Rectangular Perimeter
			translate([0,y,-d]) {
				cube([i,c,d]);
		}
//		Right Edge Upper Retainer Wedge
		rotate (a = [-180,90,0]){
			translate([0,-h+c,-i])
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [a,0], [0,e]], paths= [[0,1,2]]);
		}
//		Right Edge Lower Retainer Wedge
		rotate (a = [180,-90,0])
			translate ([-d,-h+c,c]){
				linear_extrude (height = z, center = false, convexity = 10, twist = 0)
					polygon (points = [[0,0], [b,0], [0,f]], paths= [[0,1,2]]);
 		}