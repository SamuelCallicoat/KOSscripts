CLEARSCREEN.

LOCK THROTTLE TO 1.
LOCK STEERING TO Up.

STAGE.

PRINT "LAUNCH!".

WHEN MAXTHRUST = 0 THEN {
    PRINT "Fuel is Out.".
    PRINT "Deploying parachute.".
    STAGE.
}

WAIT UNTIL SHIP:ALTITUDE > 70100.
PRINT "Target Altitude reached: "+ ship.altitude.

RUN run_science.ks.
STAGE.


LOCK THROTTLE TO 0.
PRINT "Setting throttle to 0.".
STAGE.
PRINT "Deploying parachute.".

WHEN SHIP:ALTITUDE < 100 THEN {

PRINT "Script completed.".
}
