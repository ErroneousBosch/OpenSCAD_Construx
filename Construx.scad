$fn=180;
bl = 17.85;
kl = 12;
ft = 2.1;
function beamLength(s) = bl*s + (s-1)*kl;

function innerLength(s) = beamLength(s) - 2*ft;

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
    translate([0,6,6])
    rotate([0,90,0])
    difference(){
        translate([-6,-6,0])cube([kl,kl,ft]);
        translate([-6,-3,0])cube([.75,6,ft]);
        translate([-3,-6,0])cube([6,.75,ft]);
        translate([-3,5.25,0])cube([6,.75,ft]);
        translate([6,-3.1,0])hull(){
            cube([.1,6.2,ft]);
            translate([-4.65,.15,0])cube([.1,5.9,ft]);
        };
        cylinder(ft,d=6.7,true);
        translate([-3.35,0,0])cylinder(ft,d=1.5,true);
    };
    
}

module support(){
    difference(){
        cube([.5,kl,kl]);
        translate([0,kl*.5,kl*.5])rotate([0,90,0])cylinder(h=1, d=kl*.5);
    translate([0,kl*.25,0])cube([.5,kl*.5,kl*.5]);
    }

    
}

module beam(segments){
    il = innerLength(segments);
    translate([ft,0,0])
    difference(){
    cube([il,kl,kl]);
    translate([0,1.3,0])cube([il,9.4,9.4]);
    };
    translate([il+ft,0,0])face();
    face();
    if(segments >1){
        z = ceil(segments/2);
        c = ceil((segments+2)/2);
        d = (il + ft*2)/c;
        for(i = [1:z]){
            translate([i*d -.25,0,0])support();
        }
    }
}

module rectPanel(xs,ys){
    xl = beamLength(xs)-.2;
    yl = beamLength(ys)-.2;
    
    panelEdge(xs);
    translate([xl,yl,0])rotate([0,0,180])panelEdge(xs);
    translate([-1.5,0,0])cube([xl+3,yl,1]);
}

module edge(xl){
    difference(){
        cube([xl,1,4]);
        translate([0,0,3])rotate([45,0,0])cube([xl,2,2]);
    }
}

module panelEdge(xs){
    xl = beamLength(xs)-.2;

    oa = 1.45;
    ia = 3.65;
    gap = 8.70;
    cube([xl,1,4]);
    translate([0,-1,3])
    union(){
        for(i = [1:xs]){
            if (i == 1){
                edge(bl+oa);
            } else if(i == xs){
              translate([((bl+oa)+((i-2)*(bl+3.45))+ gap*(i-1)),0,0])edge(bl+oa);
            } else {
              translate([((bl+oa)+((i-2)*(bl+3.45))+ gap*(i-1)),0,0])edge(bl+ia);
            }
             
        }

        translate([0,0,2])rotate([0,90,0])cylinder(1,d=2);
        translate([xl-1,0,2])rotate([0,90,0])cylinder(1,d=2);
    }
    translate([0,0,4])
    difference(){
        cube([2,1,3]);
        translate([0,1,0])rotate([18,0,0])cube([2,1,4]);   
    }
    translate([xl-2,0,4])
    difference(){
        cube([2,1,3]);
        translate([0,1,0])rotate([18,0,0])cube([2,1,4]);
    }
}
