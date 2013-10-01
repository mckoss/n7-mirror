/* Nexus 7 (first edition) front-facing camera mirror holder.

   Design by Frank Thorley.
   Code by Mike Koss Jr.

   Oct 1, 2013.
*/

// Misc constants
E = 0.01;
INCHES = 25.4;

// Default cylinder resolution
$fa = 3;
$fs = 1;

// Nexus 7 measurements
N7_WIDTH = 118.5;
N7_FLANGE = 1.5;
N7_CASE_DEPTH = 4.7;
CAMERA_INSET = 10.0;
CAMERA_OPENING = 5.0;

// Design constants
THICKNESS = 3.0;
FRAME_WIDTH = THICKNESS;
MIRROR_WIDTH = 1.25 * INCHES;
MIRROR_HEIGHT = 2.677 * INCHES;
MIRROR_THICKNESS = 3.5;

module mirror_holder() {
    base();
    bracket();
}

module base(connector=false) {
  width = N7_WIDTH + 2 * (FRAME_WIDTH - N7_FLANGE);
  height = 2 * (CAMERA_INSET + FRAME_WIDTH);
  depth = N7_CASE_DEPTH + THICKNESS;
  oculus = CAMERA_OPENING + 2 * THICKNESS;

  translate([0, 0, -depth / 2])
  difference() {
    cube([width, height, depth], center=true);
    cylinder(r=oculus / 2, h=depth + 2 * E, center=true);
    translate([0, -FRAME_WIDTH, -THICKNESS])
      cube([width - 2 * FRAME_WIDTH, height, depth], center=true);

    // Rout out side bezels
    translate([-N7_WIDTH  / 2 + N7_FLANGE, -height / 2 - E, -THICKNESS / 2])
      router(height=N7_CASE_DEPTH, depth=N7_FLANGE, length=height - FRAME_WIDTH);
    translate([N7_WIDTH  / 2 - N7_FLANGE, -height / 2 - E, -THICKNESS / 2])
      mirror([1, 0, 0])
          router(height=N7_CASE_DEPTH, depth=N7_FLANGE, length=height - FRAME_WIDTH);
  }
}

/* Rout a triangular bevel of specified dimensions.

   Orientation is centered along z-axis (height),
   and running length along y-axis from origin.

        1
        __________ 4
       /|        /|
    0 /_|______3/ |
      \ |       \ |
       \|________\|
        2          5

   Note that the route extends E to the right or origing
   to ensure overlap coverage of face of routed surface.
*/
module router(height, depth, length) {
   polyhedron(
      points=[[-depth, 0, 0],
              [E, 0, height / 2],
              [E, 0, -height / 2],

              [-depth, length, 0],
              [E , length, height / 2],
              [E, length, -height / 2]
              ],
      triangles=[[0, 1, 2],              // front
                 [2, 1, 4], [2, 4, 5],   // right
                 [0, 3, 4], [0, 4, 1],   // top
                 [0, 2, 5], [0, 5, 3],   // bottom
                 [3, 5, 4]               // back
                 ]);
}

module bracket() {
}

mirror_holder();
