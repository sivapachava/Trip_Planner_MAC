// Agent ca in project trip_planner
//Consumer Agent

// Acts on behalf of a consumer 
// Books holiday package from the tour operator

/* Initial beliefs and rules */
destination_preference("Paris", "Accomodation", "Flight", "Guide", "Food").
my_preference("Accomodation", 800).
my_preference("Flight", 400).
my_preference("Guide", 200).
my_preference("Food", 100).

//Rule for calculating total budget of the Consumer
budget(S):-
	.findall(Price, my_preference(_,Price), L)&
	S = math.sum(L).


/* Initial goals */

!go_on_vacation.
//!start

/* Plans */

//+!start : true <- .print("hello world.").
+!go_on_vacation
	<- !gather_information;
	!book_holiday_package.

+!gather_information : true
   <- .wait(8500);
   	  ?min_price(MinPrice, TourOperator);
	  println("buying a  package from ",TourOperator,"  for ",MinPrice);
	  .send(TourOperator, tell, accepted);     
      .


+!book_holiday_package
	<- !create_booking_requests.

+!create_booking_requests
	<- for(destination_preference(Destination, Service1, Service2, Service3, Service4, Service5, Service6)){
		!create_booking_request(Destination, Service1, Service2, Service3, Service4, Service5, Service6, ArtId);
	}.
	
+!create_booking_request(Destination, Service1, Service2, Service3, Service4, Service5, Service6, ArtId)
	<-  .concat("booking_request_for",Destination, bookingName);
	.

/* Plans for the purchasing phase */

//receiving Holiday packages with price and writing Holiday packages which are less than budget of consumer
+holiday_package(HPId, Destination, Budget, Reputation )[source(Agent)]: budget(S)
	<- if(Budget <= S | Reputation>0.06){
		+hp(HPId, Destination, Budget, Agent);
	}
	-holiday_package(HPId, Destination, Budget, Reputation )[source(Agent)]
	.

//Rule for calculating minimum price Holiday packages
min_price(MinPrice, TourOperator) :-
  .findall(best_offer(Price,Agent), hp(HPId, Destination, Budget, Agent ), L)&
	.min(L,best_offer(MinPrice,TourOperator)).

//Booking the minimum price Holiday package and sending Confirmation to the Tour agent.
+!confirm_booking: min_price(P, Agent)
	<- .send(Agent, tell, accepted("True")).
 
+booked(GroupeName) : true <-
							joinWorkspace("ora4mas",_);
							lookupArtifact(GroupeName, GroupId);
							adoptRole(consumer)[artifact_id(GroupId)];
         					focus(GroupId)
         					.
      
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
