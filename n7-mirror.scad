/* Nexus 7 (first edition) front-facing camera mirror holder.

   Design by Frank Thorley.
   Code by Mike Koss Jr.

   Oct 1, 2013.
*/

// Misc constants
E = 0.01;
INCHES = 25.4;
GAP = 0.2;

// Default cylinder resolution
$fa = 3;
$fs = 1;

// Nexus 7 measurements
N7_WIDTH = 119.0 + 1.0;      // Add slop for looser fit.
N7_FLANGE = 1.5;
N7_CASE_DEPTH = 4.7;
CAMERA_INSET = 10.0;
CAMERA_OPENING = 6.0;

// Max field of view (degrees)
VERTICAL_FIELD = 60.0;
HORIZONTAL_FIELD = 45.0;
FIELD_OF_VIEW = max(VERTICAL_FIELD, HORIZONTAL_FIELD);
VIEW_EXTENT = 75;

// Design constants
THICKNESS = 2.0;
FRAME_WIDTH = 4.0;
MIRROR_WIDTH = 1.25 * INCHES;
MIRROR_HEIGHT = 2.25 * INCHES;
MIRROR_THICKNESS = 1.9;

base_width = N7_WIDTH + 2 * (FRAME_WIDTH - N7_FLANGE);
base_height = 2 * (CAMERA_INSET + FRAME_WIDTH);
base_depth = N7_CASE_DEPTH + THICKNESS;
module assembly() {
  difference() {
    union() {
      base();
      mirror_holder();
    }
  # mirror_glass();
  }
}

module base(connector=false) {
  oculus = CAMERA_OPENING + 2 * THICKNESS * tan(FIELD_OF_VIEW / 2);
  mirror_dist = THICKNESS + base_height / 2 - THICKNESS - MIRROR_THICKNESS;
  virt_cam_y = -mirror_dist;
  virt_cam_z = mirror_dist - THICKNESS;

   % translate([0, virt_cam_y, virt_cam_z])
      rotate(-90, v=[1, 0, 0])
      union() {
        translate([0, 0, VIEW_EXTENT])
          mirror([0, 0, 1])
            scale([2 * tan(HORIZONTAL_FIELD / 2), 2 * tan(VERTICAL_FIELD / 2), 1])
              pyramid(VIEW_EXTENT, VIEW_EXTENT + CAMERA_OPENING);
      }
  translate([0, 0, -base_depth / 2])
  difference() {
    cube([base_width, base_height, base_depth], center=true);
    translate([0, 0, base_depth / 2 - THICKNESS - E])
      cylinder(r1=CAMERA_OPENING / 2, r2=oculus / 2, h=THICKNESS + 2 * E);
    translate([0, -FRAME_WIDTH, -THICKNESS])
      cube([base_width - 2 * FRAME_WIDTH, base_height, base_depth], center=true);

    // Rout out side bezels
    translate([-N7_WIDTH  / 2 + N7_FLANGE, -base_height / 2 - E, -THICKNESS / 2])
      router(height=N7_CASE_DEPTH, depth=N7_FLANGE, length=base_height - FRAME_WIDTH);
    translate([N7_WIDTH  / 2 - N7_FLANGE, -base_height / 2 - E, -THICKNESS / 2])
      mirror([1, 0, 0])
        router(height=N7_CASE_DEPTH, depth=N7_FLANGE, length=base_height - FRAME_WIDTH);
  }
}

module mirror_holder() {
  width = MIRROR_WIDTH + 2 * THICKNESS;
  height = MIRROR_HEIGHT + 2 * THICKNESS;
  depth = MIRROR_THICKNESS + THICKNESS;


  difference() {
    translate([-width / 2, -base_height / 2, 0])
      rotate(a=45, v=[1, 0, 0])
        translate([0, 0, -depth])
          cube([width, height, depth]);
    translate([0, 0, -100 - E])
      cube([200, 200, 200], center=true);
  }
}

module mirror_glass() {
  translate([0, -(CAMERA_INSET + FRAME_WIDTH) + THICKNESS * sqrt(2), 0])
  rotate(a=45, v=[1, 0, 0])
    translate([0, MIRROR_HEIGHT / 2, - MIRROR_THICKNESS / 2])
      cube([MIRROR_WIDTH, MIRROR_HEIGHT, MIRROR_THICKNESS + E], center=true);
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
              ]
  );
}

/* Pyramid centered about origin (view from above):

    3-----2
    |\  /|
    | \/ |
    | /\4|
    |/__\|
    0    1

*/
module pyramid(base, height) {
  polyhedron(
    points=[[-base / 2, -base / 2, 0],
            [base / 2, -base / 2, 0],
            [base / 2, base / 2, 0],
            [-base / 2, base / 2, 0],
            [0, 0, height]
            ],
    triangles=[[0, 1, 2], [0, 2, 3],   // bottom
               [4, 3, 2],             // N
               [4, 2, 1],             // E
               [4, 0, 3],             // W
               [4, 1, 0]              // S
               ]
  );
}

/*
difference() {
  mirror_holder();
  mirror_glass();
}
*/
assembly();
