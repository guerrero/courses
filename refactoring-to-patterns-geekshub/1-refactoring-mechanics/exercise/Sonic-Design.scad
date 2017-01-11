/*Hussain Mumtaz
husmum@gatech.edu
*/

BLACK = "Black";
BLUE = [.31, .45, .69];
WHITE = "White";
SKIN = [.90,.596,.41];
LIME_GREEN = "LimeGreen";
TOP = "Top";
BOTTOM = "Bottom";

Y_90_DEGREES = [0,90,0];
RIGHT_15_DEGREES = [15, 0, 0];
LEFT_15_DEGREES = [-15, 0, 0];

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

module eye_detail(color, offset, radius, scale=[1, 1, 1]) {
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

    eye_detail(WHITE, offset, radius);
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

module nose_base() {
    internal_part_radius = 2;
    external_part_radius = 2.4;
    external_part_offset = [2,0,0];
    
    color(BLACK)
        hull(){
            sphere(r= internal_part_radius);
            
            translate(external_part_offset)
                sphere(r = external_part_radius);
        }
}

module nose_substraction(position) {
    z_offset = position == TOP ? 3 : -3;
    offset = [1, 0, z_offset];
    radius = 2;
    
    translate(offset)
        sphere(r = radius);
}

module nose() {
    offset = [20, 0, 0];
    
    translate(offset)
        difference() {
            nose_base();
            nose_substraction(TOP);
            nose_substraction(BOTTOM);
        }
}

module smirk_stroke(rotation, ratio, offsets) {
    radius = 1;
    
    rotate(rotation)
        difference() {
            translate(offsets[0])
                scale(ratio)
                    sphere(r = radius);

            translate(offsets[1])
                scale(ratio)
                    sphere(r = radius);
        }
}

function stroke(rotation, scale, offsets) = [rotation, ratio, offsets];

module smirk() {
    offset = [20, 3, -7];
    
    strokes = [
        stroke(
            rotation = RIGHT_15_DEGREES,
            ratio = [1, 4, 1],
            offsets = [
                [ 0, 0, 0],
                [ 0, 0, 1]
            ]
        ),
        stroke(
            rotation = LEFT_15_DEGREES,
            ratio = [1, 1, 4],
            offsets = [
                [0, 3, 2],
                [ 0, 3, 0]
            ]
        ),
        stroke(
            rotation = RIGHT_15_DEGREES,
            ratio = [1, 1, 4],
            offsets = [
                [0, 3.5, 0],
                [0, 3.5, 2]
            ]
        )
    ]; 
    
    color(BLACK)
        translate(offset) {
            for (i = [0:len(strokes) + ARRAY_BASE_CORRECTION]) {
                smirk_stroke(
                    rotation = strokes[i][0],
                    ratio = strokes[i][1],
                    offsets = strokes[i][2]
                );
            }
        }
}

function invert_y(xyz) = [xyz[0], xyz[1] * -1, xyz[2]];

module snout() {
    offset = [7, 0, 0];
    base_radius = 15;
    base_substraction_radius = 13.5;
    front_substraction_offset = [-15,-15,-15];
    front_substraction_dimensions = [15,30,30];
    side_substraction_offset = [8, -7.5, 6];
    side_substraction_radius = 9;
    nose_contour_offset = [15, 0, 2];
    nose_contour_radius = 4;
    
    color(SKIN)
        translate(offset)
            difference() {
                
                sphere(base_radius);
                sphere(base_substraction_radius);
                
                rotate(Y_90_DEGREES)
                    translate(front_substraction_offset)
                        cube(front_substraction_dimensions);

                translate(side_substraction_offset)
                    sphere(side_substraction_radius);

                translate(invert_y(side_substraction_offset))
                    sphere(side_substraction_radius);
        
               translate(nose_contour_offset)
                    sphere(nose_contour_radius);
            }
}

module outer_ear(pavilion) {
    base_height = 10;
    base_bottom_radius = 5;
    base_top_radius = 0;
    
    substraction_offset = [0, -5, 0];
    substraction_size = 10;
    
    color(BLUE)
        difference() {
            cylinder(base_height, base_bottom_radius, base_top_radius);
            cylinder(pavilion[0], pavilion[1], pavilion[2]);

            translate(substraction_offset)
                cube(substraction_size);
    }
}

module inner_ear(pavilion) {
    substraction_size = 8;
    substraction_offset = [0, -4, 0];
    
    color(SKIN)
        difference() {
            cylinder(pavilion[0], pavilion[1], pavilion[2]);

            translate(substraction_offset)
                cube(substraction_size);
    }
}

module ear(offset_y, rotation_x) {
    offset = [5, offset_y, 16];
    rotation = [rotation_x, 0, 0];
    
    pavilion_height = 6;
    pavilion_bottom_radius = 4;
    pavilion_top_radius = 0;
    
    pavilion = [
        pavilion_height,
        pavilion_bottom_radius,
        pavilion_top_radius
    ];
    
    translate(offset)
        rotate(rotation) {
            outer_ear(pavilion);
            inner_ear(pavilion);
        }
}

module ears() {
    left_offset_y = -10;
    left_rotation_x = 25;
    right_offset_y = 10;
    right_rotation_x = -25;
    
    ear(right_offset_y, right_rotation_x);
    ear(left_offset_y, left_rotation_x);
}

module sonic() {
    base();
    head();
    eyes();
    hair();
    nose();
    smirk();
    snout();
    ears();
}

sonic();
