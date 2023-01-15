// Agent scaC in project trip_planner


{ include("common.asl") }
{ include("org_code.asl") }
{ include("org_goals.asl") }

/* Initial beliefs and rules */
my_service("Accomodation", 250).
my_service("Food", 70).
my_service("Guide", 120).
my_service("Flight", 120).
my_service_destination("Guide", "Istanbul").
my_service_destination("Accomodation", "Paris").
my_service_destination("Food", "Paris").
my_service_destination("Guide","Paris").
my_service_destination("Flight","Paris").
my_service_destination("Flight","Istanbul").

/* Initial goals */

!start.

/* Plans */

+currentBid(B)[artifact_id(ArtId)]         // there is a new value for current bid
    : service(S)[artifact_id(ArtId)] &
      not i_am_winning(ArtId)  &           // I am not the current winner
      my_service(S, P)              				   // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",P);
      bid( P )[artifact_id(ArtId)].                          // place my bid offering a cheaper service

	
