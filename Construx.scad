$fn=180;

module knob(){
    difference(){
    union(){
        cylinder(4.1, d=6, true) ;
        translate([-3,-3,2.4])
            minkowski(){
                cube([6,6,1.8]);
                cylinder(.1,r=.925);
            }
    };
    cylinder(5, d=4.1, true);
};
    
}

module face(){
    h = 2.1;
    translate([0,6,6])
    rotate([0,90,0])
    difference(){
        translate([-6,-6,0])cube([12,12,h]);
        translate([-6,-3,0])cube([.75,6,h]);
        translate([-3,-6,0])cube([6,.75,h]);
        translate([-3,5.25,0])cube([6,.75,h]);
        //translate([-1,-3.1,0])cube([7,6.2,h]);
        translate([6,-3.1,0])hull(){
            cube([.1,6.2,h]);
            translate([-4.65,.15,0])cube([.1,5.9,h]);
        };
        cylinder(h,d=6.7,true);
        translate([-3.35,0,0])cylinder(h,d=1.5,true);
    };
    
}

//@TODO: Put in reinforcement piece in middle of longer beams

module beam(segments){
    bl = 17.85;
    kl = 12;
    ft = 2.1;
    il = bl*segments + (segments-1)*kl - 2*ft;
    translate([ft,0,0])
    difference(){
    cube([il,12,12]);
    translate([0,1.3,0])cube([il,9.4,9.4]);
    };
    translate([il+ft,0,0])face();
    face();
    
    
}
/*
Beam lengths:
short: 17.85
*/


