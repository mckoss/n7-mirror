/*	Nexus 7 MIRROR HOLDER R2 Design Sept 22, 2013
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

//	START N7 MIRROR HOLDER DESIGN 
// ====================================================================
// Describe mirror backing plate and move to bottom of Adapter Plate
	translate ([i-1.796,jj,tfb])	
		rotate ([0,-135,0]){
			cube ([mh,mw,c]);		// Mirror Backing Plate, Length, Width, Thickness
		}								// Maximum Mirror Size (2.677 x 1.25 Inches)
// Extrude small triangle as fill piece at bottom of mirror backing plate
		translate([i-1.796,jj,4.336])	//	Mirror backing plate flush to adapter plate
			rotate ([-90,45,0])		// Triangular fill piece at base of Mirror plate
				linear_extrude ( mw ) //					
					polygon (points = [[0,0], [c,0], [0,c]], paths= [[0,1,2]]);	
	
// Left Side Triangular Shield (g1,g1 sets backing plate at 45 deg.
		translate([i,jj,c], [-c,0,0],[0,0,0])
			rotate ([0,-90,90])
				linear_extrude (height =c)
					polygon (points = [[0,0],[0, i],[g2,g3],[g1,g1]], paths = [[0,1,2,3]]);	

// Right Side Triangular Shield
		translate([i,l+c/2,c], [d,0,0],[0,0,0])
			rotate ([0,-90,90])
				linear_extrude (height =c,center=false, convexity = 10, twist = 0)
					polygon (points = [[0,0],[0,i],[g2,g3],[g1,g1]], paths = [[0,1,2,3]]);

// Mirror Holder Left Side Securing Posts
			translate([m,j,0.1])								// Make sure post embedded 0.1
				cylinder(c,w-0.2,w-0.2,center,$fn=36);	// Top Left Hole 
			translate([n,j,0.1])				
 				cylinder(c,w-0.2,w-0.2,center,$fn=36); // Center Left Hole
			translate([p,j,0.1])				
 				cylinder(c,w-0.2,w-0.2,center,$fn=36);

// Mirror Holder Right Side Securing Posts
			translate([m,l,0.1])				
 				cylinder(c,w-0.2,w-0.2,center,$fn=36);
			translate([n,l,0.1])				
 				cylinder(c,w-0.2,w-0.2,center,$fn=36);
			translate([p,l,0.1])				
 				cylinder(c,w-0.2,w-0.2,center,$fn=36);
/*
========================================================================
COMMENTS 
	Securing posts are 0.2mm radius,0.4mm in diameter smaller than holes
	Countersink volume used to allow clearance when heat staking posts
		Reduces probabily of rubbing against N7 screen when installing
 	Mirror Cover and Attachment Surface
		Recommend using double sided sticky tape to attach mirror
 			Prototype used a Manco product 0.012" thick with fine woven carrier
 		Michaels has small inexpensive 3"x3" mirrors that can be cut to size
 			Recommended mirror size is less than 2.677 x 1.25 Inches 
*/

