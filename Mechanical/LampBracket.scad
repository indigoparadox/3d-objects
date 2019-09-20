include <pipebend.scad>


module thing() {
    difference() {
        rotate([90, 0, 0]) {
            cylinder( h=15, r=6 );
        }
        translate([0,-10.5,0]) {
            rotate([90, 0, 0]) {
                pipebend_minus( 4, 3, 12, 360  );
            }
        }
    }


    difference() {
        union() {
            translate( [-6, 0, -6] ) {
                cube( [12, 12, 12] );
            }
            difference() {
                translate( [-6, 12, -12] ) {
                    rotate( [80, 0, 0] ) {
                        cube( [12, 30, 12] );
                    }
                }
                translate( [-9, 0, -18] ) {
                    cube( [18, 28, 12] );
                }
            }
        }
        translate( [0, 24, 12] ) {
            rotate( [90, 0, 0] ) {
                cylinder( h=24, r=1.5 );
            }
        }
    }
}

thing();