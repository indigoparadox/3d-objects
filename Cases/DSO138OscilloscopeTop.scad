use <text_on/text_on.scad>

$fn = 35;

DSO = [117, 76, 15.5];
pcb_thick = 5.5;
wall_top = 0.9;
wall_side = 0.9;
hole_dist = 5;
hole_dia = 3;
bolt_head_dia = 5.6;
bolt_head_thick = 3;

top();

//pcb
//#translate([wall_side,wall_side,DSO[2]+pcb_thick])cube([DSO[0],DSO[1],pcb_thick]);

module top(){
	rotate([0,0,0]){
	difference(){
		union(){
			main_box();
			mount_holes();
			buttons();
			Jumper2();
		}
		screen();
		buttons_grooves();
		DC_jack();
		Jumper2_groove();
		BNC();
		bolt_heads();
	}
	bolt_heads_support();
	logo();
	}
}

module main_box(){
	difference(){
		cube ([DSO[0]+2*wall_side,DSO[1]+2*wall_side,wall_top+DSO[2]+pcb_thick]);
		translate([wall_side,wall_side,wall_top])cube ([DSO[0],DSO[1],DSO[2]+pcb_thick+0.02]);
	}
}

module mount_holes(){
	difference(){
		union(){
			//horizontal and vertical walls for hole mounts
			translate([wall_side,wall_side/2+hole_dist,wall_top])cube([hole_dist,wall_side,DSO[2]]);
			translate([wall_side+DSO[0]-hole_dist,wall_side/2+hole_dist,wall_top])cube([hole_dist,wall_side,DSO[2]]);
			translate([wall_side+DSO[0]-hole_dist,wall_side/2+DSO[1]-hole_dist,wall_top])cube([hole_dist,wall_side,DSO[2]]);
			translate([wall_side,wall_side/2+DSO[1]-hole_dist,wall_top])cube([hole_dist,wall_side,DSO[2]]);
			
			translate([wall_side/2+hole_dist,wall_side,wall_top])cube([wall_side,hole_dist,DSO[2]]);
			translate([wall_side/2+DSO[0]-hole_dist,wall_side,wall_top])cube([wall_side,hole_dist,DSO[2]]);
			translate([wall_side/2+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cube([wall_side,hole_dist,DSO[2]]);
			translate([wall_side/2+hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cube([wall_side,hole_dist,DSO[2]]);
			//cones
			translate([wall_side+hole_dist,hole_dist+wall_side,wall_top])cylinder(d1=hole_dist*2-1, d2=hole_dist*2-3, h= DSO[2]);
			translate([wall_side+DSO[0]-hole_dist,hole_dist+wall_side,wall_top])cylinder(d1=hole_dist*2-1, d2=hole_dist*2-3, h= DSO[2]);
			translate([wall_side+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cylinder(d1=hole_dist*2-1, d2=hole_dist*2-3, h= DSO[2]);
			translate([wall_side+hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cylinder(d1=hole_dist*2-1, d2=hole_dist*2-3, h= DSO[2]);
		}

		//screw holes
		translate([wall_side+hole_dist,hole_dist+wall_side,wall_top])cylinder(h=DSO[2]+0.02, d=hole_dia);
		translate([wall_side+DSO[0]-hole_dist,hole_dist+wall_side,wall_top])cylinder(h=DSO[2]+0.02, d=hole_dia);
		translate([wall_side+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cylinder(h=DSO[2]+0.02, d=hole_dia);
		translate([wall_side+hole_dist,wall_side+DSO[1]-hole_dist,wall_top])cylinder(h=DSO[2]+0.02, d=hole_dia);
	}
}

module buttons(){
	//SEL
	translate([wall_side+9,wall_side+18,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	//-
	translate([wall_side+9,wall_side+18+12.7,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	//+
	translate([wall_side+9,wall_side+18+12.7+12.7,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	//-+
	translate([wall_side+9-(6.8+wall_side*2)/2,wall_side+18+12.7,wall_top])cube([6.8+wall_side*2,12.7,8]);
	//OK
	translate([wall_side+9,wall_side+18+12.7+12.7+12.7,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	//reset
	translate([wall_side+20.5,wall_side+5,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	//led
	translate([wall_side+30,wall_side+8.5,wall_top])cylinder(d=3+wall_side*2,h=3);
	//SEN2
	translate([wall_side+DSO[0]-11,wall_side+18.2,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2-(6.8+wall_side*2)/2,wall_top])cube([6,6.8+wall_side*2,8]);
	//SEN1
	translate([wall_side+DSO[0]-11,wall_side+18.2+17.8,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8-(6.8+wall_side*2)/2,wall_top])cube([6,6.8+wall_side*2,8]);
	//CPL
	translate([wall_side+DSO[0]-11,wall_side+18.2+17.8+17.8,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8+17.8,wall_top])cylinder(d=6.8+wall_side*2,h=8);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8+17.8-(6.8+wall_side*2)/2,wall_top])cube([6,6.8+wall_side*2,8]);
	//C4
	translate([wall_side+DSO[0]-23,wall_side+44.5,wall_top])cylinder(d=4+wall_side*2,h=8);
	//C6
	translate([wall_side+DSO[0]-23,wall_side+44.5+9,wall_top])cylinder(d=4+wall_side*2,h=8);
}

module buttons_grooves(){
	//SEL
	translate([wall_side+9,wall_side+18,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	//-
	translate([wall_side+9,wall_side+18+12.7,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	//+
	translate([wall_side+9,wall_side+18+12.7+12.7,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	//-+
	translate([wall_side+9-6.8/2,wall_side+18+12.7,-0.01])cube([6.8,12.7,8+wall_top+0.02]);
	//OK
	translate([wall_side+9,wall_side+18+12.7+12.7+12.7,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	//reset
	translate([wall_side+20.5,wall_side+5,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	//led
	translate([wall_side+30,wall_side+8.5,-0.01])cylinder(d=3,h=3+wall_top+0.02);
	//SEN2
	translate([wall_side+DSO[0]-11,wall_side+18.2,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2-6.8/2,-0.01])cube([6,6.8,8+wall_top+0.02]);
	//SEN1
	translate([wall_side+DSO[0]-11,wall_side+18.2+17.8,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8-6.8/2,-0.01])cube([6,6.8,8+wall_top+0.02]);
	//CPL
	translate([wall_side+DSO[0]-11,wall_side+18.2+17.8+17.8,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8+17.8,-0.01])cylinder(d=6.8,h=8+wall_top+0.02);
	translate([wall_side+DSO[0]-17,wall_side+18.2+17.8+17.8-6.8/2,-0.01])cube([6,6.8,8+wall_top+0.02]);
	//C4
	translate([wall_side+DSO[0]-23,wall_side+44.5,-0.01])cylinder(d=4,h=8+wall_top+0.02);
	//C6
	translate([wall_side+DSO[0]-23,wall_side+44.5+9,-0.01])cylinder(d=4,h=8+wall_top+0.02);
}

module screen(){
	translate([wall_side+27,wall_side+16.5,-0.01])cube([51,40,wall_top+0.02]);
}

module DC_jack(){
	translate([wall_side+15.5,wall_side+DSO[1]-0.01,wall_top+DSO[2]-11])cube([9.5,wall_side+0.02,11+pcb_thick+0.01]);
}

module Jumper2(){
	translate([wall_side+36,wall_side+DSO[1]-6,wall_top])cube([7.5,6,DSO[2]]);
}

module Jumper2_groove(){
	translate([wall_side+37,wall_side+DSO[1]-5,wall_top])cube([5.5,wall_side+5+0.01,DSO[2]+pcb_thick+0.01]);
}

module BNC(){
	translate([wall_side+96+11/2,wall_side*2+DSO[1]+0.01,wall_top+DSO[2]-11/2])rotate([90,0,0])cylinder(d=11,h=wall_side+0.02);
	translate([wall_side+96,wall_side+DSO[1]-0.01,wall_top+DSO[2]-11+11/2])cube([11,wall_side+0.02,11-11/2+pcb_thick+0.01]);
}

module bolt_heads(){
	translate([wall_side+hole_dist,hole_dist+wall_side,-0.01])cylinder(h=bolt_head_thick+0.01, d=bolt_head_dia);
	translate([wall_side+DSO[0]-hole_dist,hole_dist+wall_side,-0.01])cylinder(h=bolt_head_thick+0.01, d=bolt_head_dia);
	translate([wall_side+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,-0.01])cylinder(h=bolt_head_thick+0.01, d=bolt_head_dia);
	translate([wall_side+hole_dist,wall_side+DSO[1]-hole_dist,-0.01])cylinder(h=bolt_head_thick+0.01, d=bolt_head_dia);
}

module bolt_heads_support(){
	difference(){
		union(){
			translate([wall_side+hole_dist,hole_dist+wall_side,0])cylinder(h=bolt_head_thick, d=hole_dia+1);
			translate([wall_side+DSO[0]-hole_dist,hole_dist+wall_side,0])cylinder(h=bolt_head_thick, d=hole_dia+1);
			translate([wall_side+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,0])cylinder(h=bolt_head_thick, d=hole_dia+1);
			translate([wall_side+hole_dist,wall_side+DSO[1]-hole_dist,0])cylinder(h=bolt_head_thick, d=hole_dia+1);
		}
		translate([wall_side+hole_dist,hole_dist+wall_side,0])cylinder(h=bolt_head_thick, d=hole_dia);
		translate([wall_side+DSO[0]-hole_dist,hole_dist+wall_side,0])cylinder(h=bolt_head_thick, d=hole_dia);
		translate([wall_side+DSO[0]-hole_dist,wall_side+DSO[1]-hole_dist,0])cylinder(h=bolt_head_thick, d=hole_dia);
		translate([wall_side+hole_dist,wall_side+DSO[1]-hole_dist,0])cylinder(h=bolt_head_thick, d=hole_dia);
	}
}

module logo(){
	difference(){
		translate([-0.3,0,0])cube([0.3,wall_side*2+DSO[1],wall_top+DSO[2]+pcb_thick]);
		translate([-0.15,(wall_side*2+DSO[1])/2,(wall_top+DSO[2]+pcb_thick)/2])rotate([-90,0,0])rotate([0,-90,0])text_extrude("HackerMagnet",extrusion_height=0.3,size=5.5,font="Spin Cycle OT",center=true);
	}
	difference(){
		translate([wall_side*2+DSO[0],0,0])cube([0.3,wall_side*2+DSO[1],wall_top+DSO[2]+pcb_thick]);
		translate([wall_side*2+DSO[0]+0.15,(wall_side*2+DSO[1])/2,(wall_top+DSO[2]+pcb_thick)/2])rotate([-90,0,0])rotate([0,-270,0])text_extrude("DSO138",extrusion_height=0.3,size=5.5,font="Spin Cycle OT",center=true);
	}
}
