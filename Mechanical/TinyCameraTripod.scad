//Constants
inchInMM = 25.4;
$fs=0.4;

//Create thread which matches the http://en.wikipedia.org/wiki/Unified_Thread_Standard
//Dmax is the outer diameter, P is the pitch, and height is the total length of thread made.
module thread(Dmax = 0.25 * inchInMM, P = inchInMM / 20, height = 6, bottom=0,top=0)
{

	//Calculate the inner radius
	Dmin = Dmax - ((5 * sqrt(3)) / 8) * P;
	
	capHeight = (Dmax-Dmin)/2;

	intersection() {
		linear_extrude(height=height,twist=-360*height/P, slices=height*10, convexity=2) {
			rinterpoly(Dmax/2,P/16*(0),     Dmax/2,P/16*(4),       steps=4*2, P=P);
			rinterpoly(Dmax/2,P/16*(4),     Dmin/2,P/16*(4+5),     steps=5*2, P=P);
			rinterpoly(Dmin/2,P/16*(4+5),   Dmin/2,P/16*(4+5+2),   steps=2*2, P=P);
			rinterpoly(Dmin/2,P/16*(4+5+2), Dmax/2,P/16*(4+5+2+5), steps=5*2, P=P);
		}
		union() {
			if (bottom == 1)
				cylinder(r1=Dmin/2,r2=Dmax/2,h=capHeight);
			else
				cylinder(r=Dmax,h=capHeight);
			translate([0,0,capHeight]) cylinder(r=Dmax,h=height-capHeight*2);
			if (top == 1)
				translate([0,0,height-capHeight]) cylinder(r1=Dmax/2,r2=Dmin/2,h=capHeight);
			else
				translate([0,0,height-capHeight]) cylinder(r=Dmax,h=capHeight);
		}
	}
	if (bottom == 2)
		cylinder(r1=Dmax/2*1.1,r2=Dmin/2,h=P/2);
	if (top == 2)
		translate([0,0,height-capHeight]) cylinder(r2=Dmax/2*1.1,r1=Dmin/2,h=P/2);
}

//Functions to help creating the thread
function rp(x, y, P) = [x*cos(y/P*360), x*sin(y/P*360)];

module rinterpoly(x0,y0,x1,y1,steps=3, P=-1)
{
	union() for(i=[0:(steps-1)]) polygon([
		[0,0],
		rp((x0*(steps - i)+x1*i)/steps,(y0*(steps - i)+y1*i)/steps, P),
		rp((x0*(steps - (i+1))+x1*(i+1))/steps,(y0*(steps - (i+1))+y1*(i+1))/steps, P)
	]);
}

module roundedCube(size=[1,1,1], r=1)
{
	intersection() {
		linear_extrude(height=size[2],center=true) {
			minkowski() {
				square([size[0]-r*2, size[1]-r*2], center=true);
				circle(r=r);
			}
		}
		rotate([90,0,0]) linear_extrude(height=size[1],center=true) {
			minkowski() {
				square([size[0]-r*2, size[2]-r*2], center=true);
				circle(r=r);
			}
		}
		rotate([0,90,0]) linear_extrude(height=size[0],center=true) {
			minkowski() {
				square([size[2]-r*2, size[1]-r*2], center=true);
				circle(r=r);
			}
		}
	}
}

thread(top=1,bottom=2);

translate([0,0,-3]) difference() {
	intersection() {
		translate([-1,0,0]) roundedCube([15,20,6], r=1.5);
		translate([ 2,0,0]) rotate([0,0,45]) roundedCube([20,20,6], r=1.5);
	}
	translate([ 1, 4, 1]) rotate([0,30,-120]) rotate([180,0,0]) cylinder(r=5/2,h=100);
	translate([-1, 0, 1]) rotate([0,30,   0]) rotate([180,0,0]) cylinder(r=5/2,h=100);
	translate([ 1,-4, 1]) rotate([0,30, 120]) rotate([180,0,0]) cylinder(r=5/2,h=100);
}
