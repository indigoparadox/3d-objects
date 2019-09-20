
module mini_rpi_case() {
    difference() {
        import("MiniRPiCaseOrig.stl");
        translate( [-100, -50.5, 0] ) {
            cube( [200, 20, 20] );
        }
    }
}

mini_rpi_case();
