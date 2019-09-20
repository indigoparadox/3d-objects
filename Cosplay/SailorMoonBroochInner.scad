
module brooch_inner_plate() {
    difference() {
        union() {
            cylinder( h=6.2, d=31 );
            translate( [0, 6.5, 6.2] ) {
                cylinder( h=14, d=8 );
            }
            cylinder( h=2, d=47 );
        }
        translate( [0, 6.5, 0] ) {
            cylinder( h=20.2, d=4 );
        }
        translate( [0, 6.5, 0] ) {
            cylinder( h=3, d=8 );
        }
    }
}

brooch_inner_plate();