

module pill_cutter_hole( width, length, height, wall_width ) {
    
    x = width;
    y = length;
    radius = width / 2;
    
    linear_extrude( height = height + (2 * wall_width) ) {
        hull() {
            translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0]) {
                circle( r=radius );
            }

            translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0]) {
                circle( r=radius );
            }

            translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0]) {
                circle( r=radius );
            }

            translate([(x/2)-(radius/2), (y/2)-(radius/2), 0]) {
                circle( r=radius );
            }
        }
    }
}

module pill_cutter_divots( tray_width, tray_length, tray_height, width ) {
    
    w_x = (tray_width / 2) - (width / 2);
    h_y = (tray_length / 2) - (width / 2);
    
    union() {
        translate( [-0.5, h_y, 0] ) {
            cube( [tray_width + 1, width, tray_height] );
        }
        translate( [w_x, -0.5, 0] ) {
            cube( [width, tray_length + 1, tray_height] );
        }
    }
}

module pill_cutter_bottom( width, length, height, divot_width, hole_width, hole_length, hole_x, hole_y, wall_width ) {
    difference() {
        translate( [wall_width, wall_width, -1 * wall_width] ) {
            cube( [
                width - (2 * wall_width),
                length - (2 * wall_width),
                height
            ] );
        }
        pill_cutter_divots(
            width, length, height,
            divot_width + wall_width
        );
        translate( [hole_x, hole_y] ) {
            pill_cutter_hole( hole_width + 1, hole_length + 1, height );
        }
    }
}

module pill_cutter_tray( width, length, height, divot_width, hole_width, hole_length, wall_width ) {
    
    hole_x = width / 2;
    hole_y = length / 2;
    
    difference() {
        cube( [width, length, height] );
        union() {
            translate( [0, 0, wall_width] ) {
                pill_cutter_divots( width, length, height, divot_width);
            }
            translate( [hole_x, hole_y, wall_width] ) {
                pill_cutter_hole( hole_width, hole_length, height - wall_width );
            }
            pill_cutter_bottom( width, length, height, divot_width, hole_width, hole_length, hole_x, hole_y, wall_width );
        }
    }
}

pill_cutter_tray( 23, 23, 5.5, 2.4, 5.75, 12.5, 1 );
//pill_cutter_tray( 8, 8 );
