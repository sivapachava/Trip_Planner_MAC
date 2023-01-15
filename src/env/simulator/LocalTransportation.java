package simulator;


public class LocalTransportation implements VacationActivites {

	public void book(String service) {
		System.out.println(service + " Booked");
	}
	
	public void action() {
		System.out.println("Local Transport Provided");
	}
}