CLEARSCREEN.

LOCK THROTTLE TO 1.
STAGE.



PRINT "LAUNCH!".

SET currentHeading TO HEADING(90,90).
LOCK steering TO currentHeading.


SET currentStage TO 1.
WHEN MAXTHRUST = 0 THEN {
    PRINT "Stage " + currentStage + " fuel is out.".
    PRINT "Staging.".
    STAGE.
    if currentStage < 2 {
    PRESERVE.
    }
    if currentStage = 2{
        PRINT "Circularization failed. Deploying Chute".
    }
}



UNTIL SHIP:apoapsis > 80000 {
    IF SHIP:VELOCITY:SURFACE:MAG < 100{
        SET currentHeading TO HEADING(90,90).
    }    
    IF SHIP:VELOCITY:SURFACE:MAG >= 100 AND SHIP:VELOCITY:SURFACE:MAG < 200{
        SET currentHeading TO HEADING(90,85).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 200 AND SHIP:VELOCITY:SURFACE:MAG < 300{
        SET currentHeading TO HEADING(90,80).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 300 AND SHIP:VELOCITY:SURFACE:MAG < 400{
        SET currentHeading TO HEADING(90,75).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 400 AND SHIP:VELOCITY:SURFACE:MAG < 500{
        SET currentHeading TO HEADING(90,70).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 500 AND SHIP:VELOCITY:SURFACE:MAG < 600{
        SET currentHeading TO HEADING(90,60).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 600 AND SHIP:VELOCITY:SURFACE:MAG < 700{
        SET currentHeading TO HEADING(90,50).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 700 AND SHIP:VELOCITY:SURFACE:MAG < 800{
        SET currentHeading TO HEADING(90,40).
    }
}

PRINT "Calculated Apoapsis: " + APOAPSIS + " in: " + ETA:APOAPSIS.
PRINT "Stopping burn.".
LOCK THROTTLE TO 0.
LOCK STEERING to PROGRADE.



UNTIL (periapsis + 1000) > apoapsis{ // lowest point + 1000m greater than highest point: effectively circularized.

    WAIT UNTIL eta.apoapsis < 30.
    PRINT "Time to Apoapsis: " + ETA:APOAPSIS.
    PRINT "Starting burn.".
    LOCK THROTTLE TO 1.

}

LOCK THROTTLE TO 0.
PRINT "Circularization complete, conglartions!".






