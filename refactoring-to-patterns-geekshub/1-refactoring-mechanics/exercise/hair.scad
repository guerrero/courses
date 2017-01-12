/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;

module lock_of_hair(lock){
    iterations = 25;
    segment_height = 5;

    for (i = [0:iterations]) {
        rotation = [0, 90 - i, 0];
        offset_x = lock[0] - i / iterations;
        offset_y = lock[1];
        offset_z = lock[2] - i;
        radius = 8 - i/3.125;

        color(BLUE)
            rotate(rotation)
                translate([offset_x, offset_y, offset_z])
                    cylinder(h = segment_height, r = radius);
    }
}

module hair() {
    offset_z = -8;
    locks_offsets = [
        [-12, 0, offset_z],
        [-5, 8, offset_z],
        [-5, -8, offset_z],
        [5, 8, offset_z],
        [5, -8, offset_z],
        [0, 0, offset_z]
    ];

    for (i = array_range(locks_offsets)) {
        lock_of_hair(locks_offsets[i]);
    }
}
