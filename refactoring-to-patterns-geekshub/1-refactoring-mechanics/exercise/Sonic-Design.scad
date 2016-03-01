/*Hussain Mumtaz
husmum@gatech.edu
*/

BLACK = "Black";
BLUE = [.31, .45, .69];
WHITE = "White";
LIME_GREEN = "LimeGreen";

SCALE_1_1 = [1, 1, 1];

ARRAY_BASE_CORRECTION = -1;

module base() {
    offset = [-6,0,-20];
    height = 2;
    radius = 32;

    color(BLACK)
        translate(offset)
            cylinder(h=height,r=radius);
}

module eye_orbits(offset_x) {
    orbit_deviation = 8;
    directions = [-1, 1];
    offset_z = 4;
    radius = 5;

    for (i = [0:len(directions) + ARRAY_BASE_CORRECTION]) {
        translate([offset_x, orbit_deviation * directions[i], offset_z])
            sphere(r=radius);
    }
}

module head() {
    offset_x = 15;
    radius = 20;

    difference(){
        color(BLUE)
            sphere(r=20);
        hull() {
            eye_orbits(offset_x);
        }
    }
}

module scleras() {
    offset_x = 14;

    color(WHITE){
        difference(){
            hull(){
                eye_orbits(offset_x);
            }
        }
    }
}

module eye_detail(color, offset, radius, scale) {
    color(color){
        translate(offset) {
            scale(scale)
                sphere(r=radius);
        }
    }
}

module iris(offset_y) {
    offset = [18.3, offset_y, 4];
    scale = [2, 2, 3];
    radius = 1;

    eye_detail(LIME_GREEN, offset, radius, scale);
}

module pupil(offset_y) {
    offset = [19.6, offset_y, 3];
    scale = [1, 1, 2];
    radius= 1;

    eye_detail(BLACK, offset, radius, scale);
}

module brightness(offset_y) {
    center_deviation = .2;
    offset = [20.1, offset_y - center_deviation, 2];
    radius = .4;

    eye_detail(WHITE, offset, radius, SCALE_1_1);
}

module eyes() {
    y_offsets = [-7, 7];

    scleras();

    for (i = [0:len(y_offsets) + ARRAY_BASE_CORRECTION]) {
        iris(y_offsets[i]);
        pupil(y_offsets[i]);
        brightness(y_offsets[i]);
    }
}

module lock_of_hair(lock){
    for (i = [0:25]) {
        rotate_y = 90 - i;
        offset = [
            lock[0] -i/25,
            lock[1],
            lock[2] - i
        ];
        radius = 8 - i/3.125;

        color(BLUE)
            rotate([0, rotate_y, 0])
                translate(offset)
                    cylinder(h=5,r=radius);
    }
}

module hair() {
    initial_locks_offsets = [
        [-12, 0, -8],
        [-5, 8, -8],
        [-5, -8, -8],
        [5, 8, -8],
        [5, -8, -8],
        [0, 0, -8]
    ];

    for (i = [0:len(initial_locks_offsets) + ARRAY_BASE_CORRECTION]) {
        lock_of_hair(initial_locks_offsets[i]);
    }
}

//Nose

translate([20,0,0])
difference(){
	color("Black")
	hull(){
		sphere(r=2);

	translate([2,0,0])
		sphere(r=2.4);}

	translate([1,0,3])
		sphere(r=2);

	translate([1,0,-3])
		sphere(r=2);}

//Mouth Area

color([.90,.596,.41])
translate([7,0,0])
	difference(){
		sphere(r=15);

		translate([-15,-15,-15])
			cube([15,30,30]);

		rotate([0,90,0])
		translate([-15,-15,-15])
			cube([15,30,30]);

		sphere(r=13.5);

		translate([8,-7.5,6])
			sphere(r=9);

		translate([8,7.5,6])
			sphere(r=9);

		translate([15,0,2])
			sphere(r=4);}

//Smirk

color("Black")
translate([-10,3,-7]){
difference(){
rotate([15,0,0])
translate([30,0,0])
scale([1,4,1])
	sphere(r=1);

rotate([15,0,0])
translate([30,0,1])
scale([1,4,1])
	sphere(r=1);
}

difference(){
rotate([-15,0,0])
translate([30,3,2])
scale([1,1,4])
	sphere(r=1);

rotate([-15,0,0])
translate([30,3,0])
scale([1,1,4])
	sphere(r=1);
}

difference(){
rotate([15,0,0])
translate([30,3.5,0])
scale([1,1,4])
	sphere(r=1);

rotate([15,0,0])
translate([30,3.5,2])
scale([1,1,4])
	sphere(r=1);
}}

//Ears

module ear() {
color([.31, .45, .69])
difference(){
cylinder(h=10, r1=5, r2=0);

cylinder(h=6, r1=4, r2=0);

translate([0,-5,0])
cube([10,10,10]);
}

//Inner lobes. The difference shading is eh,
//but it is needed to indicate the inner lobes

color([.90,.596,.41])
difference(){
cylinder(h=6, r1=4, r2=0);

translate([0,-4,0])
cube([8,8,8]);}
}
translate([5,10,16])
rotate([-25,0,0])
ear();

translate([5,-10,16])
rotate([25,0,0])
ear();

module sonic() {
    base();
    head();
    eyes();
    hair();
}

sonic();
