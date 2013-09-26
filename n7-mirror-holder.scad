/*	Nexus 7 Camera Mirror Holder Design Sept 23, 2013
	Copyright 2013 Frank Thorley
	Camera Adapter = Adapter Plate plus Mirror Holder 
	Securing posts are 0.2mm smaller than holes
	Countersink volume used to allow clearance when heat staking posts
	Reduces probabily of rubbing against N7 screen when installing
	
========================================================================
*/
//	All Dimensions in mm, Angles (s & t) in Degrees
	a = 32.0;	// Width of mirror mounting area
	b = 68.0;	// Height of mirror mounting area
	c = 2.54;	// Thickness of mirror mounting area ~ 0.1 inch
	d = 34.54;	// Distance between left & right securing holes
	f = 56.2;	// Height of side plates above adapter plate
	g = 2.54;	// Top plate thickness ~ 0.1 inch
	h = 3.592;	// Triangular extrusion to fill gap where plates meet
	i = 25.05;	// Attachment plate height
	j = 1.27;	// Left edge offset for Row 1/left securing posts centerline
	l = 36.56;	// Left edge offset for Row 2/right securing posts centerline
	m = 6.0;		// Mirror holder securing posts 1&4 offset from top
	n = 13.5;	// Mirror holder securing posts 2&5 offset from top
	p = 21.0;	// Mirror holder securing posts 3&6 offset from top
	u = 2.54;	// Securing posts length thickness of plate
	w = 1.27;	// Mounting holes(6)radius, make pin radius 0.1 mm less

/* Mirror Cover and Attachment Surface
 Recommend using double sided sticky tape to attact mirror
 Michaels has mall inexpensive mirrors that can be cut to size
 Recommended mirror size is 61mm x ????
*/
 		translate ([g,h,0])			// Mirror backing plate angle = 45 degrees
			rotate (a = [45,0,0]){
				cube ([a,b,c]);
		}	
			rotate (a = [0,90,0])	// Set holder proper orientation
			rotate (a = [0,0,-45]) 
				translate([-u,0,u])	// Triangular fill piece
		linear_extrude (height = a, center = false, convexity = 10, twist = 0)
				polygon (points = [[0,0], [u,0], [0,u]], paths= [[0,1,2]]);

// Left Side Triangular Shield
		rotate (a = [0,-90,0])
		translate([0,0,-g], [-c,0,0],[0,0,0])
		linear_extrude (height =c,center=false, convexity = 10, twist = 0)
		polygon (points = [[0,0], [0, i], [f,f]], paths = [[0,1,2]]);
// Right Side Triangular Shield
		rotate (a = [0,-90,0])
		translate([0,0,-d], [d,0,0],[0,0,0])
		linear_extrude (height =c,center=false, convexity = 10, twist = 0)
			polygon (points = [[0,0], [0, i], [f,f]], paths = [[0,1,2]]);
// Mirror Holder Left Side Securing Posts
			translate([j,i-m,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);	// Create posts 
			translate([j,i-n,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);
			translate([j,i-p,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);					
// Mirror Holder Right Side Securing Posts
			translate([d-w,i-m,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);
			translate([d-w,i-n,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);
			translate([d-w,i-p,-c])				
 				cylinder(u,w-0.1,w-0.1,center,$fn=36);


