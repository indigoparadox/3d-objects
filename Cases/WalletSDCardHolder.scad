include <boxes.scad>;

sdw=24;
sdh=32;
sdd=2.1;

microw=11;
microh=15;
microd=1;

miniw=20;
minih=21.5;
minid=1.5;

ccw=85.5;
cch=54;
ccd=2.6;

difference(){
translate([ccw/2,cch/2,ccd/2]){roundedBox([ccw,cch,ccd+.2],3.5,true);} //Credit card platform

translate([4,(cch-sdh)/2,ccd-sdd]){cube([sdw,sdh,sdd+1]);}
translate([sdw/2+4,cch-(cch-sdh)/2,ccd-sdd-.2]){cylinder(4,6,6);}

translate([ccw-sdw-4,(cch-sdh)/2,ccd-sdd]){cube([sdw,sdh,sdd+1]);}
translate([ccw-4-sdw/2,cch-(cch-sdh)/2,ccd-sdd-.2]){cylinder(4,6,6);}


translate([(ccw-microh)/2,cch*.65,ccd-microd]){cube([microh,microw,microd+1]);}
translate([ccw/2,cch*.65+microw,ccd-microd-.2]){cylinder(4,4,4);}

translate([(ccw-miniw)/2,cch*.15,ccd-minid]){cube([miniw,minih,minid+1]);}
translate([ccw/2,cch*.15,ccd-microd-.2]){cylinder(4,4.5,4.5);}
}
