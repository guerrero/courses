/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;
include <eye_orbits.scad>;

module scleras() {
    offset_x = 14;

    color(WHITE)
        difference()
            hull()
                eye_orbits(offset_x);
}

module eye_detail(color, offset, scale, radius) {
    color(color)
        translate(offset)
            scale(scale)
                sphere(r = radius);
}

module iris(offset_y) {
    offset = [18.3, offset_y, 4];
    scale = [2, 2, 3];
    radius = 1;

    eye_detail(LIME_GREEN, offset, scale, radius);
}

module pupil(offset_y) {
    offset = [19.6, offset_y, 3];
    scale = [1, 1, 2];
    radius= 1;

    eye_detail(BLACK, offset, scale, radius);
}

module brightness(offset_y) {
    center_deviation = 0.2;
    offset = [20.1, offset_y - center_deviation, 2];
    scale = [1, 1, 1];
    radius = 0.4;

    eye_detail(WHITE, offset, radius);
}

module eyes() {
    offset = 7;

    scleras();

    for (i = array_range(DIRECTIONS)) {
        offset_y = DIRECTIONS[i] * offset;
        iris(offset_y);
        pupil(offset_y);
        brightness(offset_y);
    }
}
