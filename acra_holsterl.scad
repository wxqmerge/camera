include <Round-Anything/polyround.scad>
include <Round-Anything/minkowskiRound.scad>
include <boltsos/BOLTS.scad>

//arca=[[35,8],[35,10],[38,13],[38,15],[0,15],[0,13],[3,8],[3,8],[-4,0],[0,0],[1,1],[40,1],[42,0]];
arca=[[36,7],[36,11],[38,13],[38,15],[0,15],[0,13],[2,11],[2,7],[0,5],[0,3],[38,3],[38,5]];
fittings=[[0,54,1],[0,0,1],[4,-1,1],[6,0,1],[6,54,1],[4,55,1]];
fitting=[[28,0],[0,0],[0,6],[28,6],[29,4]];
fillett=[[10,0],[0,0],[0,17],[1,15],[2,10],[5,4]];
tps = [
  [0, 1.15],
  [1.15, 0]
];
tpf = [
  [0, 1],
  [1, 0]
];
base1 = 30;
base2 = 30;
BackHeight=2;
scale([1.05, 1.05, 1])
union() 
{
    difference()
 //   union()
    {
        rotate([ 0,90, 0])
             translate([0,-25, 0])
            scale([1, 1.1, 1])
    union (){
//bottom
        difference()
        {
         scale([1, 1, 1.45])
             translate([0,26.9, 0])
                rotate([ 0,90, 0])
                    rotate([ 0,0, 90])
                        rotate_extrude(angle = 180)
                            polygon(fitting);
             translate([-60,-0, 21])
            cube(100);
        }
// bottom tip

             translate([0,27, 19.5])
                     scale([1, .87, .25])
                rotate([ 0,90, 0])
                    rotate([ 0,0, 90])
                        rotate_extrude(angle = 180, $fn = 100)
                            polygon(fitting);

//corner
             translate([0,-1.1, 0])
         scale([1, 1.04, 1])
        rotate([ -90,0, 0])
                hull()
                    rotate_extrude(angle = 90)
                         polygon(polyRound(fittings,30));
//back
             translate([0,27, 0])
        scale([1+BackHeight, 1, 1])
                rotate([ 0,180, 90])
                     rotate_extrude(angle = 180, $fn = 100)
                            polygon(fitting);
//back thicker
                   translate([-10,27.1, 0])
            rotate([ 0,-15, 0])
                           cube([23,55,5],center=true);
//stiffeners
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
//*/
                    }
                            
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
        union() 
        {                        
            //arca mount
             translate([1,-17, -10])
                linear_extrude(height = base1)
                   polygon(points = arca * tps);
            //holes
             translate([-10,5, 20+BackHeight*25])
                rotate([ 0,90, 0])
            cylinder(h=40,r=5);
//            translate([-10,-10, 5+BackHeight*15])
//                rotate([ 0,90, 0])
//            cylinder(h=40,r=5);
//             translate([-10,15, 20+BackHeight*15])
//                rotate([ 0,90, 0])
//            cylinder(h=40,r=5);
            
//acetone holes
             translate([-3,15, -15])
                rotate([ 0,0, 90])
            cylinder(h=190,r=1);
             translate([-3,-5, -15])
                rotate([ 0,0, 90])
            cylinder(h=190,r=1);
//bottom holes     
            translate([28,30, -15])
                rotate([-40,1, 90])
            cylinder(h=19.6,r=.5);
            translate([28,-21, -15])
                rotate([-40,1, 90])
            cylinder(h=19.6,r=.5);
     
        }
  };
};
