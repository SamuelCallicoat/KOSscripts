function RunScienceModulebyName
{
    parameter name.
    parameter shouldTransmit. // should be bool
   

    IF SHIP:PARTSNAMED(name):LENGTH > 0
    {
        SET part TO SHIP:PARTSNAMED(name)[0].
        SET module TO part:GETMODULEBYINDEX(1).

        SET dataExists TO  module:HASDATA().
        print PART:NAME + " contains experiment: " + dataExists.
        IF NOT dataExists
        {
            module:DEPLOY().
        }
    
        IF shouldTransmit
        {
            wait until module:HASDATA().
            module:TRANSMIT().
            print part:NAME +  " transmitting...".
            wait until module:hasdata() = false.
            print "transmission complete!".

        }
    }
}

function RunProbeTelemetry
{
    parameter shouldTransmit.

    //This is for probe cores, which in one mod (probes before crew, i think) has telemetery. 

        SET probeCore TO SHIP:PARTS[0].
        //This assumes the root part is the command module TODO: fix this. check if this is hoe the vessel parts work
        IF probeCore:hasmodule("ModuleScienceExperiment")
        {
            SET module to probeCore:GETMODULE("ModuleScienceExperiment").

            SET dataExists TO module:HASDATA().
            print probeCore:NAME +  " contains experiment: " + dataExists.

            IF NOT dataExists
            {
                module:DEPLOY().
                
                IF shouldTransmit
                {
                    wait until module:HASDATA().
                    module:TRANSMIT().
                    print probeCore:NAME +  " transmitting.".
                    wait until module:hasdata() = false.
                    print "transmission complete!".
                
                }
            }

        }
    
}

RunScienceModulebyName("GooExperiment", true).
RunScienceModulebyName("sensorThermometer", true). 
RunScienceModulebyName("sensorBarometer", true).

RunProbeTelemetry(true).
// possibly add parameter for index of module




