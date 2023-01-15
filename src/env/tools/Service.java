// CArtAgO artifact code for project trip_planner

package tools;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.ObsProperty;


public class Service extends Artifact {
	
	@OPERATION public void init(String serviceName,  String location, int maxValue)  {
        // observable properties
		defineObsProperty("location",      location);
        defineObsProperty("service",   serviceName);
        defineObsProperty("maxValue",      maxValue);
        defineObsProperty("currentBid",    maxValue);
        defineObsProperty("currentWinner", "no-winner");
        System.out.println("Service Artifact for "+location+" Service Name "+serviceName+ "has been initialized");
    }
	@OPERATION public void bid(double bidValue) {
		ObsProperty opCurrentValue  = getObsProperty("currentBid");
        ObsProperty opCurrentWinner = getObsProperty("currentWinner");
        if (bidValue < opCurrentValue.doubleValue()) {  // the bid is better than the previous
            opCurrentValue.updateValue(bidValue);
            opCurrentWinner.updateValue(getCurrentOpAgentId().getAgentName());
        }
        	
        }
    }

//	void init(int initialValue) {
//		defineObsProperty("count", initialValue);
//	}
//
//	@OPERATION
//	void inc() {
//		ObsProperty prop = getObsProperty("count");
//		prop.updateValue(prop.intValue()+1);
//		signal("tick");
//	}
	




    
