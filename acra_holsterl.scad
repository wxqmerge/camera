include <Round-Anything/polyround.scad>
include <Round-Anything/minkowskiRound.scad>
include <boltsos/BOLTS.scad>

// Profile polygon - smoothed curve for holster shape
profile = [
  [0,0],
  [2,0],
  [8,1],
  [15,2],
  [22,3],
  [28,4],
  [32,5],
  [35,6],
  [37,7],
  [38,8],
  [38,10],
  [38,12],
  [38,14],
  [38,15],
  [36,15],
  [34,15],
  [32,15],
  [30,15],
  [28,15],
  [26,14],
  [24,13],
  [22,12],
  [20,11],
  [18,10],
  [16,9],
  [14,8],
  [12,7],
  [10,6],
  [8,5],
  [6,4],
  [4,3],
  [2,2],
  [0,1],
  [0,0]
];

// Mount polygon
arca=[[36,7],[36,11],[38,13],[38,15],[0,15],[0,13],[2,11],[2,7],[0,5],[0,3],[38,3],[38,5]];
tps = [
  [0, 1.15],
  [1.15, 0]
];
base1 = 30;
BackHeight=2;

// Create main body - mirrored and smoothed
module holster_body() {
    // Right half (original profile)
    rotate([0,90,0])
    translate([0,-25,0])
    scale([1,1.1,1])
    rotate_extrude(angle=180,$fn=100)
    polygon(profile);
    
    // Left half (mirrored)
    rotate([0,90,0])
    translate([0,-25,0])
    scale([1,1.1,1])
    rotate([0,0,180])
    rotate_extrude(angle=180,$fn=100)
    polygon(profile);
}

scale([1.05, 1.05, 1])
difference()
{
    union()
    {
        // Main body - mirrored and smoothed
        holster_body();
        
        // Back reinforcement
        translate([-10,27.1,0])
        rotate([0,-15,0])
        cube([23,55,5],center=true);
        
        // Bottom stiffeners
        translate([0.1,1.3,-0.1])
        rotate([-8,0,-4])
        scale([1,0.5,0.5])
        rotate([90,0,0])
        rotate([0,0,90])
        {
            scale([3,2,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
            translate([-1,-2,-2])
            scale([4,3,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
            translate([0,0,-4])
            scale([4,3,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
        }
        
        // Top stiffeners
        translate([0.1,55.5,-0.1])
        rotate([8,0,4])
        scale([1,0.5,0.5])
        rotate([90,0,0])
        rotate([0,0,90])
        {
            scale([3,2,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
            translate([-1,-2,2])
            scale([4,3,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
            translate([0,0,4])
            scale([4,3,1])
            linear_extrude(5)
            polygon([[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]]);
        }
        
        // Front curve reinforcement
        translate([0,-1.1,0])
        scale([1,1.04,1])
        rotate([-90,0,0])
        hull()
        rotate_extrude(angle=90,$fn=100)
        polygon(polyRound([[0,54,1],[0,0,1],[4,-1,1],[6,0,1],[6,54,1],[4,55,1]],30));
    }
    
    // Mount cutout
    translate([1,-17,-10])
    linear_extrude(height=base1)
    polygon(points=arca*tps);
    
    // Mounting hole
    translate([-10,5,20+BackHeight*25])
    rotate([0,90,0])
    cylinder(h=40,r=5);
    
    // Acetone release holes
    translate([-3,15,-15])
    rotate([0,0,90])
    cylinder(h=190,r=1);
    translate([-3,-5,-15])
    rotate([0,0,90])
    cylinder(h=190,r=1);
    
    // Bottom attachment holes
    translate([28,30,-15])
    rotate([-40,1,90])
    cylinder(h=19.6,r=0.5);
    translate([28,-21,-15])
    rotate([-40,1,90])
    cylinder(h=19.6,r=0.5);
}
