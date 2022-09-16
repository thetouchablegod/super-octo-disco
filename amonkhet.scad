
module amonkhet(height) {
linear_extrude(height=height) offset(r = .5, chamfer = true){

polygon(points=[[0,0], [0,40], [30,11], [-30,11], [0,3], [0,36.5], [26,12]], paths=[[0,2,1,3], [4,5,6]]);

polygon(points=[[0,-10], [36,3], [48, -7], [0,-25], [-48,-7], [-36, 3], [0,-13], [35,0], [43,-6.5], [0,-22]], paths=[[0,1,2,3,4,5], [6,7,8,9]]);
    }
}
rotate([90,0,90])
amonkhet(5);