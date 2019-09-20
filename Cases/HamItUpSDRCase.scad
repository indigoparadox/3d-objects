$fn=50;

brd_l = 96.7;
brd_w = 48.2;
brd_h = 15;
brd_bottom = 2;

usb_l = 12;
usb_w = 12;
usb_h = 11;

sma_l = 12;
sma_w = 7;
sma_h = 7;

sw_rad = 6/2;
sw_h = 12;

wall = 2;

mnt_rad = 3.8/2;
screw_rad = 6/2;
screw_h = brd_h + (wall*2);
screw_hole_rad = 1;

build = 0;

intersection(){
	if (build == 1) {
		union(){
		//top section
			translate([-(wall*4),-(wall*4),(brd_h/2)])	
			cube([brd_l+ (wall*8),brd_w+ (wall*8),(brd_h/2)+ (wall*2)]);
			
			translate([-1,-1,brd_h/2-2])
			cube([brd_l+2,brd_w+2,(brd_h/2)+2]);
		}
	} else {
		//Bottom section
		difference(){
			translate([-(wall*4),-(wall*4),-(wall*2)])
			cube([brd_l+ (wall*8),brd_w+ (wall*8),(brd_h/2)+ (wall*2)]);

			translate([-1,-1,brd_h/2-2])
			cube([brd_l+2,brd_w+2,(brd_h/2)+2]);
		}
	}
	
	difference(){
		union(){
			translate([-wall,-wall,-wall])
			cube([brd_l + (wall*2),brd_w + (wall*2),brd_h + (wall*2)]);	

			translate([-wall,-wall,-wall])
			cylinder(r=screw_rad, h= screw_h);

			translate([-wall,brd_w+wall,-wall])
			cylinder(r=screw_rad, h= screw_h);
			
			translate([brd_l+ wall,-wall,-wall])
			cylinder(r=screw_rad, h= screw_h);
			
			translate([brd_l+wall,brd_w+wall,-wall])
			cylinder(r=screw_rad, h= screw_h);				
						
		}

		color("red")
		union(){
			cube([brd_l,brd_w,brd_h]);
			
			// USB
			translate([3.2,-11,brd_h-usb_h-.25])
			cube([usb_l,usb_w,usb_h]);
			
			// SMA IN
			translate([-11,36,1.25])
			cube([sma_l,sma_w,sma_h]);

			//SMA OUT
			translate([brd_l-1,23.5,1])
			cube([sma_l,sma_w,sma_h]);			

			// SWITCH
			translate([brd_l-1,37.5+sw_rad,4.75+sw_rad])
			rotate([0,90,0])
			cylinder(r=sw_rad,h=sw_h);
		}
		
		translate([4,brd_w/2+8,brd_h+wall-.5])
		union(){
			cube([.5,12,1]);
			
			translate([0,8,0])
			rotate([0,0,30])
			cube([.5,4,1]);
			
			translate([0,8,0])
			rotate([0,0,-30])
			cube([.5,4,1]);
		}
		
		translate([-wall,-wall,-wall-1])
		cylinder(r=screw_hole_rad ,h=screw_h+2);

		translate([-wall,brd_w+wall,-wall-1])
		cylinder(r=screw_hole_rad ,h=screw_h+2);
		
		translate([brd_l+wall,-wall,-wall-1])
		cylinder(r=screw_hole_rad ,h=screw_h+2);
		
		translate([brd_l+wall,brd_w+wall,-wall-1])
		cylinder(r=screw_hole_rad ,h=screw_h+2);
		
	}
}