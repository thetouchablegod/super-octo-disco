use </home/thetouchablegod/Drivemounts/bigpun/linux-stuff/Documents/deckbox.scad>
deckwidth = 68;
deckdepth = 72;
deckheight = 93;

module deck() {
    cube([deckwidth, deckdepth, deckheight+3], center=true);
}

difference() {
union() {
        translate([0,deckdepth/2 -3.2,-5.75])
        rotate([90,0,0,])
        color("purple")
        linear_extrude(height=1.2, center=true) {
            square([deckwidth+1.2, deckheight-10],center = true);
                }
        difference() {
                roundedcube_simple([72, 75.4, 96], center=true, radius=.4); 
            translate([0,0,2])
                deck();
            translate([0,28,22])
            rotate([0,0,45])
                cube_cut();
        }
}

hull() {
translate([deckwidth/2 + 2.8, deckdepth/2 -5, -deckheight/2 + 5])
    sphere(2, $fn=16);
translate([deckwidth/2 + 2.8, -deckdepth/2 +5, -deckheight/2 +5])
    sphere(2, $fn=16);
    }
hull() {
translate([-deckwidth/2 - 2.8, deckdepth/2 -5, -deckheight/2 + 5])
    sphere(2, $fn=16);
translate([-deckwidth/2 - 2.8, -deckdepth/2 +5, -deckheight/2 +5])
    sphere(2, $fn=16);
    }
}