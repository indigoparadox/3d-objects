//
// CP2102 USB to Serial Module Case by Russ Hughes
//	License:  Creative Commons Attribution-ShareAlike 4.0 International
//	http://creativecommons.org/licenses/by-sa/4.0/
//	
//

bw=17.5;
bl=34.5;
bt=8.5;

th= 0.45*2;
st= th*2;

label_font = "Stencil Gothic";		// font to use for label
label = 1;							// 1 to print label

print_upper=0;						// 1 to print upper part
print_lower=1;						// 1 to print lower part

module upper_screw(){
	difference() {
		union() {
			cylinder(d=4,h=bt+st, $fn=32);
			translate([0,-2,0])
				cube([2,4,bt+st]);
		}
		cylinder(d=2.4, h=bt, $fn=32);
	}
}

module lower_screw(){
	difference() {
		union() {
			cylinder(d=4,h=bt+st, $fn=32);
			translate([-2,-2,0])
				cube([2,4,bt+st]);
		}
		cylinder(d=2.4, h=bt, $fn=32);
	}
}

module shell_outer() {
	cube([bw+st,bl+st,bt+st]);
	translate([-2,2,0]) 
		upper_screw();

	translate([-2,bl+st-2,0]) 
		upper_screw();

	translate([bw+3.8,2,0]) 
		lower_screw();

	translate([bw+3.8,bl+st-2,0]) 
		lower_screw();
	
}

module shell_lower() {
	difference() {
		shell_outer();
		translate([th,th,th])
			cube([bw,bl+1,bt]);

		translate([(bw+st)/2-(12.10/2), -1, 3])
			cube([12.10,10, 6]);
		
		translate([(bw+st)/2-(2.4/2)+st, bl+1.2-7, 8])
		{
			$fn=32;
			
			translate([-5,-1,0]) 
				cube([10,3,3]);
			
			translate([-5,0.5,0]) 
				cylinder(d=3, h=3);
			
			translate([5,0.5,0]) 
				cylinder(d=3, h=3);
		}
	}
}

module shell_upper() {
	difference() {
		shell_outer();
		translate([th,th,th])
			cube([bw,bl,bt]);
		translate([(bw)/2-8+th, 2, 0])
			cube([16,5,3]);
		
		if (label) { 
			translate([12,35,.45])
				rotate([0,180,90])
				linear_extrude(height=4)
					#text("CP2102", font=label_font, size=6);
		}
	}
}

if (print_lower) {
	translate([0,0,10])
	rotate([0,180,0]) {
		difference() {
			shell_lower();
			translate([-25,-1,-1])
				cube([50,50,4]);
		}
	}
}

if (print_upper) {
	translate([10,0,0])

	difference() {
		shell_upper();
		translate([-25,-1,3])
			cube([50,50,12]);
	}
}
