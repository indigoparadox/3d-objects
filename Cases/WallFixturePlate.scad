joinfactor = 0.125;
goldenratio = 1.61803399;

gThickness = 1/4 * 25.4;
gRoundingRadius = 1/8/2*25.4;

gStandardWidth = 2.75*25.4;
gStandardHeight = 4.5 * 25.4;

gFixtureHoleDistance = 2.375*25.4;		// The separation between holes when a fixture is being covered
gFixtureHoleIR =5/32/2*25.4;
gFixtureHoleOR = 6.75/2;

gLightSwitchHeight = 0.942*25.4;		// The height of a light switch
gLightSwitchWidth = 0.406 * 25.4;		// The width of a light switch

//
// Examples
//
//roundedplate(gStandardWidth, gStandardHeight, gThickness);
hollowplate(gStandardWidth, gStandardHeight, gThickness, 1/16*25.4);

//Switch();

//Switch_1gang(gStandardWidth, gStandardHeight, gThickness);



//===============================
// Modules
//===============================
module roundedplate(width, height, thickness)
{
	smooth = 12;

	difference()
	{
		cube([width, height, thickness], center=true);

		translate([0, -height/2+gRoundingRadius, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([0, -gRoundingRadius+joinfactor, gRoundingRadius+joinfactor])
				cube([width+joinfactor*2, gRoundingRadius*2+joinfactor, gRoundingRadius*2+joinfactor], center=true);

				rotate([0, 90, 0])
				cylinder(r=gRoundingRadius, h=width+4*joinfactor, center=true, $fn=smooth);
			}
		}

		translate([0, height/2-gRoundingRadius, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([0, gRoundingRadius-joinfactor, gRoundingRadius+joinfactor])
				cube([width+joinfactor*2, gRoundingRadius*2+joinfactor, gRoundingRadius*2+joinfactor], center=true);

				rotate([0, 90, 0])
				cylinder(r=gRoundingRadius, h=width+4*joinfactor, center=true, $fn=smooth);
			}
		}


		// Negative X along Y
		translate([-width/2+gRoundingRadius, 0, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([-gRoundingRadius+joinfactor, 0, gRoundingRadius+joinfactor])
				cube([gRoundingRadius*2+joinfactor, height+joinfactor*2, gRoundingRadius*2+joinfactor], center=true);

				rotate([90, 0, 0])
				cylinder(r=gRoundingRadius, h=height+4*joinfactor, center=true, $fn=smooth);
			}
		}

		// Positive X along Y
		translate([width/2-gRoundingRadius, 0, thickness/2-gRoundingRadius])
		{
			difference()
			{
				translate([gRoundingRadius-joinfactor, 0, gRoundingRadius+joinfactor])
				cube([gRoundingRadius*2+joinfactor, height+joinfactor*2, gRoundingRadius*2+joinfactor], center=true);

				rotate([90, 0, 0])
				cylinder(r=gRoundingRadius, h=height+4*joinfactor, center=true, $fn=smooth);
			}
		}
	}
}

module hollowplate(width, height, thickness, wallthickness)
{
	hollowthickness = thickness-wallthickness;

	difference()
	{
		translate([0,0,thickness/2])
		roundedplate(width, height, thickness);
		
		translate([0,0,hollowthickness/2-joinfactor])
		roundedplate(width-wallthickness*2, height-wallthickness*2, hollowthickness);
	}
}

module Switch()
{
	union()
	{
		cube(size=[gLightSwitchWidth, gLightSwitchHeight, gThickness+2*joinfactor], center=true);

		translate([0, gFixtureHoleDistance/2, 0])
		cylinder(r=gFixtureHoleIR, h=gThickness+2*joinfactor, center=true, $fn = 12);

		translate([0, gFixtureHoleDistance/2, 0])
		cylinder(r1=gFixtureHoleIR, r2=gFixtureHoleOR, h=gThickness/2+joinfactor, $fn = 12);

		translate([0, -gFixtureHoleDistance/2, 0])
		cylinder(r=gFixtureHoleIR, h=gThickness+2*joinfactor, center=true, $fn = 12);

		translate([0, -gFixtureHoleDistance/2, 0])
		cylinder(r1=gFixtureHoleIR, r2=gFixtureHoleOR, h=gThickness/2+joinfactor, $fn = 12);
	}	
}


module Switch_1gang(width, height, thickness)
{
	difference()
	{
		roundedplate(width, height, thickness);
	
		Switch();
	}
}