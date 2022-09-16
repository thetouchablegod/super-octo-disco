
// outer dimensions are set as variables to help
// align things later.
od_width = 76.6;  //77.5
od_depth = 80;    //66.3
od_height = 100;   //100

// module for the logo array. I figured out how to array the array.
// I also kinda figured out the random rotations. It rotates randomly
// however I have it rotating based on the index. I would like to 
// have each one rotate a random amount but not based on the index
// so I dont have to scale each rotation seperately. For now I have each 
// rotating a set amount and I like the result. I would like to figure
// out how to rotate the first one in some way if I try to keep it this way.
// Maybe turning the whole array at an angle A la LV. 
module logo_array(h_count, count, dist ) {
    
    for(x = [0: 1: h_count -1]){
        //the number here acts as a scale factor
        //for the translation. it needs to be set
        //larger for lower numbers in order to 
        //scale the spacing properly across the 
        //face
        translate([0,0,h_count*1.5 *x])
        for(i = [1: 1: count ]) {
        random_rot = rands(20, 50 , 1)[0];
            //rot = [-random_rot, -random_rot/2, -random_rot/3, -random_rot/4, //-random_rot, -random_rot];
            translate([0, dist*i*1.4, 0])
            //rotate([rot[i-1]*i, 0, 0])
            rotate([7*i, 0, 0])
            children();
        }
    }
}

use <amonkhet.scad>

// More information: https://danielupshaw.com/openscad-rounded-corners/
// Imported module for rounding the box
module roundedcube_simple(size = [1, 1, 1], center = false, radius = 0.5) {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate = (center == false) ?
		[radius, radius, radius] :
		[
			radius - (size[0] / 2),
			radius - (size[1] / 2),
			radius - (size[2] / 2)
	];

	translate(v = translate)
	minkowski() {
		cube(size = [
			size[0] - (radius * 2),
			size[1] - (radius * 2),
			size[2] - (radius * 2)
		]);
		sphere(r = radius);
	}
}


//modules for the main box
module cube_od() { 
    roundedcube_simple(size =[od_width, od_depth, od_height], center = true, radius = 0.75);
}
module cube_id() {
    cube([72.6, 76, 100], center = true);
}

module cube_cut() {
    cube([40, 40, 94], center = true);
}         

module knobby() {
    difference() {
    hull() {
        sphere(2, $fn=16);
        translate([0,16,0])
            sphere(2,$fn=16);
        }
   hull()  {
   translate([2,0,0])
     cube(4, center = true);
     translate([2 , 46, 0])
        cube(4, center = true);
        }
    }
}





module box_top() {
// Main box is created from parts here.
rotate([0, 180 ,0])        
difference() {
    cube_od();
    translate([0, 0, 2])
        cube_id();
    translate([0, 28, 22])
    rotate([0, 0, 45])
        cube_cut();
    }
}
           
difference() {
 union() {   
// logo array is called and translated here. 
// Could possibly build all surface arrays 
// into one function. IDK yet. 
     translate([od_width/2 -.3, od_depth/-2 -7, od_height/-2 + 8])
            logo_array( 8, 4, od_depth/6) 
        rotate([90,0,90])
        scale([0.155, 0.155, 0.12])
        color("blue")
            amonkhet(5);
     translate([od_width/-2 +.3, od_depth/-2 -7  , od_height/-2 +8])
            logo_array( 8, 4, od_depth/6) 
        rotate([90,0,90])
        scale([0.155, 0.155, -0.12])
        color("red")
            amonkhet(5);
            box_top();
     translate([od_width/2 -.8, od_depth/2 -24, -od_height/2 +5])
            knobby();
     translate([od_width/2 -.8, od_depth/2 -73, -od_height/2 +5])
            knobby();
     translate([-od_width/2 +.8, -od_depth/2 +8, -od_height/2 +5])
     rotate([0,180,0])
            knobby();
     translate([-od_width/2 +.8, -od_depth/2 +58, -od_height/2 +5])
     rotate([0,180,0])
            knobby();
    //text goes here
color("green")
rotate([0,90,90])
translate([-40,od_height/-2 +18,od_width/2 +1])
linear_extrude(height = 1) {
    
    offset(delta = .27, chamfer = true)
    text("Amonkhet", size = 12, $fn = 192);
}
}
rotate([90,0,90])
translate([0,-od_height/2 - 2,0])
scale([1.5,1.2,1])
cylinder(h=120, r = 10, center = true, $fn = 64);
}