
module mini_rpi_case() {
    difference() {
        import("FTDITopOrig.stl");
        translate( [-10, -5, 0] ) {
            cube( [20, 20, 20] );
        }
    }
}

mini_rpi_case();