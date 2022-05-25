DECLARE PARAMETER launchDegree.
DECLARE PARAMETER targetAlt.
DECLARE PARAMETER shouldReenter.
DECLARE PARAMETER twoStageCircularization.


CLEARSCREEN.

LOCK THROTTLE TO 1.
STAGE.



PRINT "LAUNCH!".

SET currentHeading TO HEADING(launchDegree,90).
LOCK steering TO currentHeading.


SET currentStage TO 1.
WHEN MAXTHRUST = 0 THEN {
    PRINT "Stage " + currentStage + " fuel is out.".
    PRINT "Staging.".
     if currentStage >= 2{
        stage.
        PRINT "Circularization failed. Deploying Chute".
        return false.
    }
    if currentStage < 2 {
        set currentStage to currentStage + 1.
        lock throttle to 1.
        STAGE.
        return true.
    }
    
}


// based on tutorial at kos wiki
UNTIL SHIP:apoapsis > targetAlt {
    IF SHIP:VELOCITY:SURFACE:MAG < 100{
        SET currentHeading TO HEADING(launchDegree,90).
    }    
    IF SHIP:VELOCITY:SURFACE:MAG >= 100 AND SHIP:VELOCITY:SURFACE:MAG < 200{
        SET currentHeading TO HEADING(launchDegree,85).
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 200 AND SHIP:VELOCITY:SURFACE:MAG < 300{
        SET currentHeading TO HEADING(launchDegree,80).
        
        if currentStage = 1 {lock throttle to 0.7.}
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 300 AND SHIP:VELOCITY:SURFACE:MAG < 400{
        SET currentHeading TO HEADING(launchDegree,75).
        if currentStage = 1 {lock throttle to 0.6.}
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 400 AND SHIP:VELOCITY:SURFACE:MAG < 500{
        SET currentHeading TO HEADING(launchDegree,70).
        if currentStage = 1 {lock throttle to 0.5.}
            }
    IF SHIP:VELOCITY:SURFACE:MAG >= 500 AND SHIP:VELOCITY:SURFACE:MAG < 600{
        SET currentHeading TO HEADING(launchDegree,60).
    if currentStage = 2 {lock throttle to 1.}
        
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 600 AND SHIP:VELOCITY:SURFACE:MAG < 700{
        SET currentHeading TO HEADING(launchDegree,50).
    if currentStage = 2 {lock throttle to 1.}
    
    }
    IF SHIP:VELOCITY:SURFACE:MAG >= 700 AND SHIP:VELOCITY:SURFACE:MAG < 800{
        SET currentHeading TO HEADING(launchDegree,40).
    if currentStage = 2 {lock throttle to 1.}
    
    }
}

PRINT "Calculated Apoapsis: " + APOAPSIS + " in: " + ETA:APOAPSIS.
PRINT "Stopping burn.".
LOCK THROTTLE TO 0.
LOCK STEERING to PROGRADE.
set targetPeriapsis to apoapsis.

if twoStageCircularization = false{
runPath("circularize",targetPeriapsis, 34, false).
}
if twoStageCircularization{
runPath("circularize", 1000000, 30, true).
}

if shouldReenter{
WAIT 10.
RUN REENTRY.
}
// else{
//     ship:partsnamed("highgainantenna5.v2")[0]:getmodulebyindex(0):doaction("extend antenna", true).
//     ship:partsnamed("scansat-radar-poseidon-3b-1"):getmodule("scansat"):doevent("start scan: radar").
//     // extend antenna, start scansat.
// }