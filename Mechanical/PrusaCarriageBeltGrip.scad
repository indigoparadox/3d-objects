
module prusa_carriage_belt_grip() {
    difference() {
        cube( [17, 13.5, 7.75] );
        translate( [2.25, 3.10, 0] ) {
            cylinder( d=4, h=7.75 );
        }
        translate( [2.25, 10.3, 0] ) {
            cylinder( d=4, h=7.75 );
        }
        translate( [13.33, 3.10, 0] ) {
            cylinder( d=4, h=7.75 );
        }
        translate( [6, 3.30, 0] ) {
            cube( [3.25, 10.25, 7.75] );
        }
        translate( [4.85, 8, 0] ) {
            cube( [5.75, 3, 7.75] );
        }
    }
}

prusa_carriage_belt_grip();