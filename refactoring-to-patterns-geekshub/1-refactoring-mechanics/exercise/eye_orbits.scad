/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;

module eye_orbits(offset_x) {
    orbit_deviation = 8;
    offset_z = 4;
    radius = 5;

    for (i = array_range(DIRECTIONS)) {
        translate([offset_x, orbit_deviation * DIRECTIONS[i], offset_z])
            sphere(r = radius);
    }
}
