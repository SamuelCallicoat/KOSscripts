DECLARE parameter targetAlt.
DECLARE parameter secsUntilApoapsis.
Declare parameter twoStageCircularization.


LOCK THROTTLE TO 0.
LOCK STEERING to PROGRADE.

   
   
    set nextCheck to time:seconds + 2.
    on (floor(time:seconds) > nextCheck)
    {

        
        print "    PeA: " + periapsis AT(10, 10).
        print "    ApA: " + apoapsis  AT(10, 11). 
        print "PeA/ApA: " + (periapsis / apoapsis)AT(10, 12).
        PRINT "ApA ETA: " + round(eta:apoapsis) AT(10, 13).
        

         if (periapsis > targetAlt)
            {
            return false.
            }
        set nextcheck to floor(time:seconds) + 2.
        
        WAIT 0.001.
        return true.
   }
wait until (eta:apoapsis < secsUntilApoapsis).

set prevEta to eta:apoapsis.
set throttleMag to 0.5.

if twoStageCircularization{
    
    lock throttle to 1.
    UNTIL apoapsis >= targetAlt{ 
        wait 0.2.
    }
    lock throttle to 0.
    


    set na to addAlarm("raw",(time:seconds+eta:apoapsis - 40), "ApA", "need to circularize in " + (eta:apoapsis - 40)).
    print na:NAME. //prints 'Test'
    print na:NOTES. 


    runpath("circularize", apoapsis, 20, false).

}


if twoStageCircularization = false{
    
    on (periapsis > 0){
        lock throttle to 0.1.
        print "periapsis above 0". 
         

        return false. 

        
    }

    UNTIL periapsis >= targetAlt{ 

        if eta:apoapsis > 100{
            lock throttle to 0.
            wait eta:apoapsis - 15.
            print "waiting : " +  (eta:apoasis - 15).
        }

        // TODO:  should prob be a PID loop 
        if prevEta < eta:apoapsis and throttleMag > 0{
            set throttleMag to throttleMag  - 0.05 .
            
            lock throttle to throttleMag.    
            wait 0.05.
        }

        if prevEta > eta:apoapsis  and throttleMag <= 1   {
        set throttleMag to throttleMag  + 0.05. 
            lock throttle to throttleMag.     
            wait 0.05.
        }
        set prevEta to eta:apoapsis.
 if eta:apoapsis > 100{
            lock throttle to 0.
            wait eta:apoapsis - 15.
            print "waiting til: " + (eta:apoapsis - 15).
        }
        WAIT 0.001.

    }
    print "Stable Orbit Complete! Congrations!".
}
LOCK THROTTLE TO 0.



SET ship:control:PILOTMAINTHROTTLE TO 0.