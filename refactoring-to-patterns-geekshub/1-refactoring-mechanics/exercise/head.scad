/*Hussain Mumtaz
husmum@gatech.edu
*/

include <eye_orbits.scad>;

module pedestal() {
    offset = [-6, 0, -20];
    height = 2;
    radius = 32;

    color(BLACK)
        translate(offset)
            cylinder(h = height, r = radius);
}

module head() {
    offset_x = 15;
    radius = 20;
    color(BLUE)
        difference() {
                sphere(r = radius);
            hull()
                eye_orbits(offset_x);
        }
}
