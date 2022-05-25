function RunScienceModulebyName
{
    parameter name.
    parameter shouldTransmit. // should be bool
   

    IF SHIP:PARTSNAMED(name):LENGTH > 0
    {
        SET part TO SHIP:PARTSNAMED(name)[0].
        SET module TO PART:GETMODULE("ModuleScienceExperiment"). //standard name for science modules
        
        //SET module TO part:GETMODULEBYINDEX(1). //this seems to be the standard position of the module science experiment.
                                                

        SET dataExists TO  module:HASDATA().
        print PART:NAME + " contains experiment: " + dataExists.
        IF NOT dataExists
        {
            module:DEPLOY().
        }
    
        IF shouldTransmit
        {
            WAIT UNTIL module:HASDATA().
            module:TRANSMIT().
            PRINT part:NAME +  " transmitting...".
            WAIT UNTIL module:hasdata() = false.
            PRINT "transmission complete!".

        }
    }
}

FUNCTION RunProbeTelemetry
{
    PARAMETER shouldTransmit.

    //This is for probe cores, which in one mod (probes before crew, i think) has telemetery. 

        SET probeCore TO SHIP:PARTS[0].
        //This assumes the root part is the command module TODO: fix this. check if this is hoe the vessel parts work
        IF probeCore:HASMODULE("ModuleScienceExperiment")
        {
            SET module TO probeCore:GETMODULE("ModuleScienceExperiment").

            SET dataExists TO module:HASDATA().
            PRINT probeCore:NAME +  " contains experiment: " + dataExists.

            IF NOT dataExists
            {
                module:DEPLOY().
                
                IF shouldTransmit
                {
                    WAIT UNTIL module:HASDATA().
                    module:TRANSMIT().
                    PRINT probeCore:NAME +  " transmitting.".
                    WAIT UNTIL module:hasdata() = false.
                    PRINT "transmission complete!".
                
                }
            }

        }
    
}


//Should probably have a config file for each type of vessel: e.g. if 
// the vessel is supposed to be recoverd or not.
RunScienceModulebyName("GooExperiment", false).
RunScienceModulebyName("Science.Module", false).
RunScienceModulebyName("sensorThermometer", true). 
RunScienceModulebyName("sensorBarometer", true).

RunProbeTelemetry(true).

// possibly add parameter for index of module




