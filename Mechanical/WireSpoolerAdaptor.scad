
module spooler_holes() {
    translate( [-3.5, 6, 0] ) {
        cube( [7, 5, 34] );
    }
    translate( [-3.5, -11, 0] ) {
        cube( [7, 5, 34] );
    }
}

module spooler() {
    difference() {
        cylinder( h=34, r=12.5 );
        cylinder( h=34, r=4.8 );
        spooler_holes();
        rotate( [0, 0, 90] ) {
            spooler_holes();
        }
    }
    
}

spooler();