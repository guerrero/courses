/*Hussain Mumtaz
husmum@gatech.edu
*/

include <functions.scad>;

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
            for (i = array_range(strokes)) {
                smirk_stroke(
                    rotation = strokes[i][0],
                    ratio = strokes[i][1],
                    offsets = strokes[i][2]
                );
            }
        }
}
