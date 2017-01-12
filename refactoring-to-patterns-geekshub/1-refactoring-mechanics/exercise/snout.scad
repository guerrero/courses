/*Hussain Mumtaz
husmum@gatech.edu
*/

function invert_y(xyz) = [xyz[0], xyz[1] * -1, xyz[2]];

module snout() {
    offset = [7, 0, 0];
    base_radius = 15;
    base_substraction_radius = 13.5;
    front_substraction_offset = [-15, -15, -15];
    front_substraction_dimensions = [15, 30, 30];
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
