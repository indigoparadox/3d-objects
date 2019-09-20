//
// prusa-i3-belt-tensioner.scad
//
// This simple belt tensioner part mounts on the top x-axis
// smooth rod and holds a 624 bearing with a 4mm screw. The
// belt goes over the bearing and the tension is adjusted by
// a screw on the top of the rod.
//
// The inner walls are meant to grip the x-axis rod to
// prevent the tensioner from sliding left in response
// to vibration. If you need to improve the grip try placing
// a wide piece of rubber band between the rod and the
// tensioner, or reprint the piece with a higher mount_tightness
// value.
//
// Once you find an ideal tension, print a new part with
// rod_top_to_screw at the new distance for an idealized
// tensioner. It's a small part so why not?
//

// basic presets
$fn = 15;
radius_3mm = 1.55;
radius_4mm = 2.1;

// How deep to make the nut trap
nut_height_3mm = 2.5 + 1.75;

// The diameter of the x-axis rod. Usually 8mm or 10mm.
rod_diameter = 8;
rod_radius = rod_diameter / 2;

// Thickness of the part walls. 3 or 4mm is springy
// higher values give more rigid front and rear walls
part_thickness = 4;

// Include a hole in the top for a tensioner
// Turn this off if printing a part at full tension
tension_is_adjustable = false;

// amount of space to remove around the rod so it fits tighter
mount_tightness = tension_is_adjustable ? 0.5 : 1.0;

// added ridges are mainly cosmetic, grip will be variable
mount_ridges = tension_is_adjustable ? 3 : 0;

// Distance from the top of the rod to the center of the bearing.
// The existing bearing distance is the no tension position.
rod_top_to_screw = tension_is_adjustable ? 28 : 18;

// Extra height added to the solid top of the part
extra_height = 0;

// The size of the 624 or other bearing
bearing_diameter = 13;
bearing_depth = 5;
bearing_hole_radius = radius_4mm;

//
// Derived values
//

bearing_radius = bearing_diameter / 2;

mt2 = mount_tightness / 2;

// Inner holders for the bearing keep it centered
holder_depth = (rod_diameter - bearing_depth - mount_tightness) / 2;

// calc the x_rod_top from the y position of the bearing screw hole
x_rod_top = part_thickness + bearing_hole_radius + rod_top_to_screw;

// center of the x rod
x_rod_ypos = x_rod_top - rod_radius;

// Position of the tensioner screw hole
tensioner_ypos = x_rod_top + (part_thickness + extra_height) / 2;

module x_rod() {
	translate([0, part_thickness + rod_radius, x_rod_ypos])
		color([0.9, 0.9, 0.9, 0.2])
			rotate([0, 90, 0])
				cylinder(r=4, h=100, center=true);
}

module belt_tensioner_x() {

//	x_rod();

	difference() {
		union() {
			difference() {
				// Main tensioner body
				color([0.8, 0.8, 1])
				union() {
					translate([0, 0, part_thickness + bearing_hole_radius])
						cube([bearing_diameter, rod_diameter + part_thickness * 2, part_thickness + bearing_hole_radius + rod_top_to_screw - rod_radius - (part_thickness + bearing_hole_radius) + extra_height]);
					translate([bearing_radius, rod_radius + part_thickness, bearing_radius])
						rotate([90, 0, 0])
							cylinder(r=bearing_radius, h=rod_diameter + part_thickness * 2, center=true, $fn=36);
					translate([bearing_radius, rod_radius + part_thickness, x_rod_ypos + extra_height])
						rotate([0, 90, 0])
							cylinder(r=part_thickness + rod_radius, h=bearing_diameter, center=true, $fn=36);
				}

				// Negative square part
				color([1, 1, 1])
					translate([-1, part_thickness + mt2, -1])
						cube([bearing_diameter + 2, rod_diameter - mount_tightness, x_rod_ypos + 1]);

				// The rounded part with optional ridges
				color([1, 1, 1])
					for(z=[0:mount_ridges])
						translate([bearing_radius, part_thickness + rod_radius, x_rod_ypos - rod_radius * z])
							rotate([0, 90, 0])
								cylinder(r=4, h=bearing_diameter + 2, center=true, $fn=24);

			}

			// Bearing holders
			color([0.2, 0.8, 0.2, 1])
			for(y=[0, rod_diameter - holder_depth])
				translate([bearing_radius, y + part_thickness + holder_depth / 2 + (y == 0 ? mt2 - 0.1 : -mt2 + 0.1), part_thickness + bearing_hole_radius])
					rotate([90, 0])
						cylinder(r1=(y == 0 ? bearing_hole_radius + 1 : bearing_hole_radius + part_thickness), r2=(y == 0 ? bearing_hole_radius + part_thickness : bearing_hole_radius + 1), h=holder_depth + 0.2, center=true, $fn=18);
		}

		// Bearing Screw Hole
		translate([bearing_radius, -1, part_thickness + bearing_hole_radius])
			rotate([0, 90, 90])
				cylinder(r=bearing_hole_radius, h=part_thickness * 2 + rod_diameter + 2, $fn=18);

		if (tension_is_adjustable) {
			// Tensioner screw hole
			translate([bearing_radius, part_thickness + rod_radius, tensioner_ypos])
				cylinder(r=radius_3mm, h=part_thickness + extra_height + 1, center=true);

			// Nut Trap
			translate([bearing_radius, part_thickness + rod_radius, x_rod_top + 0.1])
				cylinder(r=radius_3mm + 1.6, h=nut_height_3mm, center=true, $fn=6);
		}
	}
}

translate([0, 0, bearing_diameter]) rotate([0, 90]) belt_tensioner_x();

// Ruler
// translate([0,0,part_thickness + bearing_hole_radius]) color([0,0,0]) cube([10, 10, 28]);

