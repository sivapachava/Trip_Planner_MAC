package simulator;


public class Guide implements VacationActivites {

	public void book(String service) {
		System.out.println(service + " Booked");
	}
	
	public void action() {
		System.out.println("Guide provided");
	}
}