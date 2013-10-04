/* Nexus 7 (first edition) front-facing camera mirror holder.

   Design by Frank Thorley.
   Code by Mike Koss Jr.

   Oct 1, 2013.
*/

PART = "assembly"; // [assembly, base, holder]

// Misc constants
E = 0.01;
INCHES = 25.4;
GAP = 0.2;

// Default cylinder resolution
$fa = 3;
$fs = 1;

// Nexus 7 measurements
N7_FLANGE = 1.5;
N7_WIDTH = 119.0 + N7_FLANGE + 0.5;
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
MIRROR_WIDTH = 1.5 * INCHES;
MIRROR_HEIGHT = 2.25 * INCHES;
MIRROR_THICKNESS = 1.9;
MIRROR_LIFT = 0.0;
MIRROR_ANGLE = 50.0;

base_width = N7_WIDTH + 2 * (FRAME_WIDTH - N7_FLANGE);
base_height = 2 * (CAMERA_INSET + FRAME_WIDTH);
base_depth = N7_CASE_DEPTH + THICKNESS;

mirror_horiz_thickness = (THICKNESS + MIRROR_THICKNESS) / sin(MIRROR_ANGLE);
mirror_offset = base_height / 2 - mirror_horiz_thickness;

module assembly() {
  difference() {
    union() {
      difference() {
        base();
        field_of_view();
      }
      mirror_holder();
    }
  mirror_glass();
  }
}

module base(connector=false) {
  oculus = CAMERA_OPENING + 2 * THICKNESS * tan(FIELD_OF_VIEW / 2);

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

module field_of_view() {
  virt_cam = mirrorp(MIRROR_ANGLE, [mirror_offset, -THICKNESS]);
  virt_cam_y = virt_cam[0] - mirror_offset;
  virt_cam_z = virt_cam[1];

  // Field of view indicator
  translate([0, virt_cam_y, virt_cam_z])
    rotate(2 * (MIRROR_ANGLE - 45) - 90, v=[1, 0, 0])
      union() {
        translate([0, 0, VIEW_EXTENT])
          mirror([0, 0, 1])
            scale([2 * tan(HORIZONTAL_FIELD / 2), 2 * tan(VERTICAL_FIELD / 2), 1])
              pyramid(VIEW_EXTENT, VIEW_EXTENT + CAMERA_OPENING);
      }
}

module mirror_holder() {
  width = MIRROR_WIDTH + 2 * THICKNESS;
  height = MIRROR_HEIGHT + 2 * THICKNESS;
  depth = MIRROR_THICKNESS + THICKNESS;

  translate([0, 0, MIRROR_LIFT])
  difference() {
    translate([-width / 2, -base_height / 2, 0])
      rotate(a=MIRROR_ANGLE, v=[1, 0, 0])
        translate([0, 0, -depth])
          cube([width, height, depth]);
    translate([0, 0, -100 - E])
      cube([200, 200, 200], center=true);
  }
}

module mirror_glass() {
  translate([0, -base_height / 2 + THICKNESS / sin(MIRROR_ANGLE), MIRROR_LIFT])
    rotate(a=MIRROR_ANGLE, v=[1, 0, 0])
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

//
// Reflect in mirror at angle, a, to x axis.
//
function mirrorp(a, p) = rotp(a, ry(rotp(-a, p)));

//
// Rotate point [x, y] counter-clockwise about the origin.
//
function rotp(a, p) = [[cos(a), -sin(a)], [sin(a), cos(a)]] * p;

//
// Reflect y coordinate (about the x axis).
//
function ry(p) = [p[0], -p[1]];

% field_of_view();
% mirror_glass();

if (PART == "assembly") assembly();
if (PART == "base") base();
if (PART == "holder")
  difference() {
    mirror_holder();
    mirror_glass();
  }
