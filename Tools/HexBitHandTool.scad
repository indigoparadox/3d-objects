
difference(){
    base();
    translate([30,5,5]) cylinder(34,3.91,3.91, $fn=6);
}

module base(){
    union(){
        translate([30,5,0]) {
            translate([0,0,10]) cylinder(10,5,5,$fn=60);
            cylinder(10,7.75,7.75,$fn=60);
        }

        translate([60,5,0]) cylinder(10,5,5, $fn=60);
        translate([0,5,0]) cylinder(10,5,5, $fn=60);
        cube([60,10,10]);
    }
}

