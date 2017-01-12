/*Hussain Mumtaz
husmum@gatech.edu
*/

include <constants.scad>;
include <functions.scad>;
include <head.scad>;
include <eyes.scad>;
include <hair.scad>;
include <nose.scad>;
include <smirk.scad>;
include <snout.scad>;
include <ears.scad>;

module sonic() {
    pedestal();
    head();
    eyes();
    hair();
    nose();
    smirk();
    snout();
    ears();
}

sonic();
