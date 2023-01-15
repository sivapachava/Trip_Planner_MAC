package simulator;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.ObsProperty;


public class HolidayPackage extends Artifact{
	Flight flight = new Flight();
	Accomodation acc = new Accomodation();
	Food food = new Food();
	Guide guide = new Guide();
	LocalTransportation local = new LocalTransportation();
	
	@OPERATION void bookServices(String HP) {
		if (HP == "HP1") {
			flight.book("Flight Tickets");
			acc.book("Accomodation");
			food.book("Food");
			local.book("Bus transportation");
			guide.book("Guide");	
		}
		else if (HP == "HP2") {
			flight.book("Flight Tickets");
			acc.book("Accomodation");
			food.book("Food");
			guide.book("Guide");
			
		}
		else if (HP == "HP3") {
			flight.book("Flight Tickets");
			acc.book("Accomodation");
			local.book("Bus transportation");			
		}	
	}
	
	@OPERATION void provideFlight() {
		flight.action();	
	}
	
	@OPERATION void provideAccomodation() {
		acc.action();
	}
	
	@OPERATION void provideFood() {
		food.action();
	}
	
	@OPERATION void provideLocalTransport() {
		local.action();
	}
	
	@OPERATION void provideGuide() {
		guide.action();	
	}	
	
}


