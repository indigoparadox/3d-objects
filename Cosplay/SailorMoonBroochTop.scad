$fn=20;

module round_cylinder( d, h, c ) {
    $true_height = h - (c / 2);
    minkowski() {
        cylinder( d=d-(c * 2), h=$true_height );
        sphere( r=c, h=c );
    }
}

module round_half_cylinder( d, h, c ) {
    $mid_point = (h / 2);
    translate( [0, 0, ($mid_point * -1)] ) {
        difference() {
            round_cylinder( d, h, c );
            translate( [0, 0, (h * -1)] ) {
                cylinder( d=d, h=(h * 1.5) );
            }
        }
    }
}

module moon_shape( d, h, c ) {
    
    minkowski() {
        difference() {
            cylinder( d=(d - (2 * c)), h=(h - (c / 2)) );
            translate( [4, 4, 0] ) {
                cylinder( d=d, h=h );
            }
        }
        sphere( r=c, h=c );
    }
}

module cylinder_slice( r, h, a ) {
  $fn=64;
  intersection() {
    cylinder( r=r, h=h );
    cube( [r, r, h] );
    rotate( a - 90 ) {
        cube( [r, r, h] );
    }
  }
}

module cyilinder_inner( d, a, h, w ) {
    $i_radius = ((d / 2) - (2 * w));
    union() {
        rotate( 85 ) {
            cylinder_slice( h=h, r=$i_radius, a=10 );
        }
        rotate( 205 ) {
            cylinder_slice( h=h, r=$i_radius, a=10 );
        }
        rotate( 325 ) {
            cylinder_slice( h=h, r=$i_radius, a=10 );
        }
    }
}

module broach_legs( d, hi, wi ) {    
    translate( [0, 0, (hi * -1)] ) {
        // Inner Pegs
        difference() {
            cyilinder_inner( d=d, a=5, h=hi, w=2.9 );
            cylinder( r=($r - wi - (2 * 2.5)), h=hi );
        }
        // Bottom Catch Lips
        translate( [0, 0, -2] ) {
            difference() {
                cyilinder_inner( d=d, a=5, h=2, w=2 );
                cylinder( r=($r - wi - (2 * 2.5)), h=2 );
            }
        }
    }
}

module broach_holes( hw=6.5 ) {
    $holes_h = 100;
    union() {
        translate( [-20, 0, (($holes_h / 2) * -1)] ) {
            cylinder( d=hw, h=$holes_h );
        }
        translate( [0, -20, (($holes_h / 2) * -1)] ) {
            cylinder( d=hw, h=$holes_h );
        }
        translate( [20, 0, (($holes_h / 2) * -1)] ) {
            cylinder( d=hw, h=$holes_h );
        }
        translate( [0, 20, (($holes_h / 2) * -1)] ) {
            cylinder( d=hw, h=$holes_h );
        }
        translate( [0, 0, (($holes_h / 2) * -1)] ) {
            cylinder( d=hw, h=$holes_h );
        }
    }
}

module broach( d, h, hi, wi ) {
    $r = d / 2;
    difference() {
        union() {
            round_half_cylinder( d=d, h=h, c=3 );
            translate( [0, 0, h] ) {
                moon_shape( d=30, h=3, c=1 );
            }
            //broach_legs( d, hi, wi );
            translate( [0, 0, -5] ) {
                cylinder( r=($r - wi), h=5 );
            }
        }
        broach_holes();
    }
}

broach( d=57.5, h=3, hi=17.5, wi=2.9 );
