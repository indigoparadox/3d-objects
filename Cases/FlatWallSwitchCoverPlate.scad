// flat wall switch cover
// John Ridley
// December 1 2012

screw_spacing = 97;
inside_height = 20;
inside_width = 35;
inside_length = 68;
wall_thickness = 2;

// Y and X spacing beyond screw (for Y) or outside width (for x)
length_perimeter = 10;
width_perimeter = 0;

screw_dia = 3;
head_dia  = 8;
head_ht = 2;

outside_height = inside_height + wall_thickness;
outside_width = inside_width + wall_thickness;
outside_length = inside_length + wall_thickness * 2;

radius = 11;


	difference()
	{
		union()
		{
			base();
			translate([width_perimeter, 
				(screw_spacing+length_perimeter*2-outside_length)/2, 0])
				round_top_box(width=outside_width,length=outside_length, height=outside_height, rradius = radius);
		}
		translate([width_perimeter+wall_thickness + 0.01, 
				(screw_spacing+length_perimeter*2-outside_length)/2+wall_thickness, 0])
			round_top_box(width=inside_width,length=inside_length,height=inside_height, rradius = radius - wall_thickness/2);

		for (y=[0:1])
			translate([(outside_width+width_perimeter*2)/2,length_perimeter+y*screw_spacing,0])
				screwhole(rad1 = screw_dia/2, rad2 = head_dia/2, ht=wall_thickness, hd_ht = head_ht);
	}

module screwhole(rad1, rad2, ht, hd_ht)
{
	cylinder(r=rad1, h=ht);
	translate([0,0,ht-head_ht])
		cylinder(r1=rad1, r2=rad2, h=hd_ht, $fn=20);
}

module base()
{
	difference()
	{
		cube([outside_width + width_perimeter*2, screw_spacing + length_perimeter*2, wall_thickness]);
		for (x=[0:1])
			for (y=[0:1])
			{
				translate([x*(outside_width+width_perimeter*2 - radius),y*(screw_spacing + length_perimeter*2 - radius),0])
					cube([radius, radius, wall_thickness]);
			}
	}
	for (x=[0:1])
		for (y=[0:1])
		{
			translate([x*(outside_width+width_perimeter*2 - radius*2)+radius,y*(screw_spacing + length_perimeter*2 - radius*2)+radius,0])
			cylinder(r=radius, h=wall_thickness);
		}
}


module round_top_box(width, length, height, rradius)
{
	difference()
	{
		cube([width, length, height]);
		for (y=[0,1])
			translate([0,(length-rradius)*y, height-rradius])
				cube([width, rradius, rradius]);
	}
	for (y=[0,1])
		translate([0,(length-rradius*2)*y+rradius, height-rradius])
			rotate([0,90,0])
				cylinder(r=rradius, h=width,$fn=20);
}
