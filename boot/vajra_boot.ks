wait until ship:unpacked.
clearscreen.
COPYPATH("0:/totem_two_launch", "").
COPYPATH("0:/run_science", "").
COPYPATH("0:/circularize", "").
COPYPATH("0:/reentry", "").
COPYPATH("0:/countdown", "").
//                              DGR, ALT,    REENTRY?, 2stagecirc
runpath( "totem_two_launch.ks", 90,   73000, true, false).