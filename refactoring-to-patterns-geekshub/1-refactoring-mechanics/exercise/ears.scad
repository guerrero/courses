/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;

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
    offset_y = -10;
    rotation_x = 25;

    for (i = array_range(DIRECTIONS)) {
        ear(offset_y * DIRECTIONS[i], rotation_x * DIRECTIONS[i]);
    }
}
