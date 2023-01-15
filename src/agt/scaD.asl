// Agent scaD in project trip_planner


{ include("common.asl") }
{ include("org_code.asl") }
{ include("org_goals.asl") }

/* Initial beliefs and rules */
my_service("Accomodation", 500).
my_service("Local_Transportation", 200).
my_service("Food", 120).
my_service_destination("Accomodation", "Istanbul").
my_service_destination("Food", "Paris").
my_service_destination("Local_Transportation", "Paris").
my_service_destination("Local_Transportation", "London").
my_service_destination("Accomodation", "London").

/* Initial goals */

!start.

/* Plans */


+currentBid(B)[artifact_id(ArtId)]         // there is a new value for current bid
    : service(S)[artifact_id(ArtId)] &
      not i_am_winning(ArtId)  &           // I am not the current winner
      my_service(S, P)           				   // I can offer a better bid
   <- //.print("my bid in auction artifact ", Art, " is ",P);
      bid( P )[artifact_id(ArtId)].                          // place my bid offering a cheaper service

