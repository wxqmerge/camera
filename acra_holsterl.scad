include <Round-Anything/polyround.scad>

fittings=[[0,56.16,1],[0,0,1],[4,-1.04,1],[6,0,1],[6,56.16,1],[4,57.2,1]];
fitting=[[28,0],[0,0],[0,6],[28,6]];
fillett=[[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]];
base1 = 30;
BackHeight = 2;

// CRITICAL: arca mount interface - DO NOT MODIFY
module arca_mount_cutout() {
  translate([1, -22.9425, -10])
    linear_extrude(height = base1)
      polygon([[8.4525,43.47],[13.2825,43.47],[15.6975,45.885],[18.1125,45.885],[18.1125,0],[15.6975,0],[13.2825,2.415],[8.4525,2.415],[6.0375,0],[3.6225,0],[3.6225,45.885],[6.0375,45.885]]);
}

// CRITICAL: mounting/acetone/bottom holes - DO NOT MODIFY
module all_holes() {
  translate([-10.5,5.25-5.25, 20+BackHeight*25])
    rotate([0,90,0])
      cylinder(h=40,r=5.25);
  translate([-3.15,15.75-5.25, -15])
    rotate([0,0,90])
      cylinder(h=190,r=1.05);
  translate([-3.15,-5.25-5.25, -15])
    rotate([0,0,90])
      cylinder(h=190,r=1.05);
  translate([29.4,31.5-5.25, -15])
    rotate([-40,1,90])
      cylinder(h=19.6,r=.525);
  translate([29.4,-22.05-5.25, -15])
    rotate([-40,1,90])
      cylinder(h=19.6,r=.525);
}

// Stiffener geometry
module stiffener_pair() {
  color("coral", 0.5)
    translate([.1,1.3, -.10])
      rotate([ -8,0, -4])
        scale([1, .5, .5])
          rotate([ 90,0, 0])
            rotate([ 0,0, 90])
              {
                scale([3, 2, 1])
                  linear_extrude(5)
                    polygon(fillett);
                translate([-1,-2, -2])
                  scale([4, 3, 1])
                    linear_extrude(5)
                      polygon(fillett);
                translate([0,0, -4])
                  scale([4, 3, 1])
                    linear_extrude(5)
                      polygon(fillett);
              }

  color("tomato", 0.5)
    translate([.1,55.5, -.1])
      rotate([ 8,0, 4])
        scale([1, .5, .5])
          rotate([ 90,0, 0])
            rotate([ 0,0, 90])
              {
                scale([3, 2, 1])
                  linear_extrude(5)
                    polygon(fillett);
                translate([-1,-2, 2])
                  scale([4, 3, 1])
                    linear_extrude(5)
                      polygon(fillett);
                translate([0,0, 4])
                  scale([4, 3, 1])
                    linear_extrude(5)
                      polygon(fillett);
              }
}

difference() {
  rotate([0,90,0])
    scale([1, 1.05, 1.05])
      translate([0,-30.25, 0])
        scale([1, 1.1, 1])
          union() {
            // bottom
            color("steelblue", 0.5)
              difference() {
                scale([1, 1, 1.45])
                  translate([0,27, 0])
                    rotate([0,90,0])
                      rotate([0,0,90])
                        rotate_extrude(angle = 180)
                          polygon(fitting);
                translate([-60,0, 21])
                  cube(100);
              }
            // bottom tip
            color("cornflowerblue", 0.5)
              translate([0,27, 19.5])
                scale([1, .87, .25])
                  rotate([0,90,0])
                    rotate([0,0,90])
                      rotate_extrude(angle = 180, $fn = 100)
                        polygon(fitting);
            // corner
            color("skyblue", 0.5)
              translate([0,-1, 0])
                rotate([-90,0,0])
                  hull()
                    rotate_extrude(angle = 90)
                      polygon(polyRound(fittings,30));
            // back
            color("slateblue", 0.5)
              translate([0,27, 0])
                scale([1+BackHeight, 1, 1])
                  rotate([0,180,90])
                    rotate_extrude(angle = 180, $fn = 100)
                      polygon(fitting);
            // back thicker
            color("mediumslateblue", 0.5)
              translate([-10,27, 0])
                rotate([0,-15,0])
                  cube([23,54,5],center=true);
            // stiffeners
            stiffener_pair();
            scale([1,-1,1])
              translate([0,-27*2, 0])
                stiffener_pair();
          }

  arca_mount_cutout();
  all_holes();
}
