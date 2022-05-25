
//you just need a small boost east to splashdown.
// used with a rocket  with a small amt of fuel.

LOCK THROTTLE TO 1.
LOCK STEERING TO  HEADING(90,45).

STAGE.

PRINT "LAUNCH!".

WAIT UNTIL MAXTHRUST < 10.

LOCK THROTTLE TO 1.

PRINT "Fuel is Out.".
PRINT "Deploying parachute.".

STAGE.
chutes ON.

