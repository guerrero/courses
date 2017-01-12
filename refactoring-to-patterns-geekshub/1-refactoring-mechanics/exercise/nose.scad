/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;

module nose_base() {
    internal_part_radius = 2;
    external_part_radius = 2.4;
    external_part_offset = [2, 0, 0];

    color(BLACK)
        hull(){
            sphere(r = internal_part_radius);

            translate(external_part_offset)
                sphere(r = external_part_radius);
        }
}

module nose_substractions(position) {
    offset_x = 1;
    offset_y = 0;
    offset_z = 3;
    radius = 2;

    for (i = array_range(DIRECTIONS)) {
        color(BLACK)
            translate([offset_x, offset_y, offset_z * DIRECTIONS[i]])
                sphere(r = radius);
    }
}

module nose() {
    offset = [20, 0, 0];

    translate(offset)
        difference() {
            nose_base();
            nose_substractions();
        }
}
