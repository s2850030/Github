/* Clock Battery project Box  Version 1.0
// Designed by Wile1One  5 Sept 2020
// For Project Zoomie on YouTube
// Released for private use under the standard GNU open source licence.
// This a two component assembly of a box and lid.
// It is based at the origin and not centered.
// fits LR44 button cell and terminals
*/

// Put all the variables for the project first
// Dimensions in mm
x = 13;                 // Inner Width
y = 13;                 // Inner Length
z = 12;                  // Inner Height
Thick = 2;              // Box thickness
LipHeight=4;            // Depth lid goes into box
Fa= 0.3;                // Ensure Penetration Fine Adjustment
HoleRadius = 2;         // Screw hole to accept 4mm screw or cable tie


// Sanity Checks   you can add more if you like
if (HoleRadius*2 >z) {
    echo("z is too small");
}
if (z > x)  { 
    echo("x is too small");
    }
if (z > y)  { 
    echo("y is too small");
    }
if (HoleRadius > 2)  { 
    echo("are you sure you want a > 4mm hole in your box?");
    }
if (LipHeight < 2)  { 
    echo("Your lipHeight needs to be at least 2mm to fit into the box");
    }
BuildProject();           // Build the project

module BuildProject(){
    translate([0,HoleRadius*6,0])Box();
    translate([0,HoleRadius*7+y *1.5,0])Lid();
}

// a hollow box with a lip and holes assembly.
module Box(){   
    difference(){
        union(){
            Chassis() ;  //  build the hollow box
            Lip() ;      //  add a mounting surface
        }
        Holes();         //  drill the holes where needed
    }
}
// The Chassis is the frame about which all of the objects are built. 

module Chassis() { 
     difference(){
         // outer box dimensions
         translate([0,0,0]) cube([x+Thick*2,y+Thick*2,z+Thick], center=false);
         //  cut out for the PCB Inner Dimensions
         translate([Thick,Thick,Thick]) cube([x,y,z+Fa], center=false);   
     }
 }
//  Lip is for mounting the project box
module Lip(){
    translate([0,-HoleRadius*6+Fa,0]) cube([x+Thick*2,HoleRadius*6,Thick], center=false);
}
//  Holes are all of the Holes in the chassis.
module Holes(){
    translate([Thick*2,-HoleRadius*3,-Fa]) Hole();
    translate([x,-HoleRadius*3,-Fa]) Hole();
    translate([x/2+Thick,Thick*2,Thick+HoleRadius +Fa]) rotate([90,0,0]) Hole();
}
module Hole(){
    cylinder(h=z, r=HoleRadius,$fn=60, center=false);
}

// part 2 is the lid. two boxes unioned printed upside down
module Lid(){
    // outer box dimensions
    translate([0,0,0]) cube([x+Thick*2,y+Thick*2,Thick], center=false);
    translate([Thick+Fa,Thick+Fa,Thick-Fa]) cube([x-Fa,y-Fa,LipHeight], center=false); 
    
}