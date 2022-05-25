print "STARTING REENTRY".
LOCK steering to retrograde.
WAIT 1.
LOCK throttle TO 1.

WAIT UNTIL maxThrust = 0.


STAGE.

UNTIL chutessafe = true
{
chutesSafe ON.
WAIT 1.
}
print "chute deployed.".


