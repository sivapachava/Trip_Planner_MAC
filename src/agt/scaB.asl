// Agent scaB in project trip_planner


{ include("common.asl") }
{ include("org_code.asl") }
{ include("org_goals.asl") }

/* Initial beliefs and rules */
my_service("Accomodation", 300).
my_service("Local_Transportation", 70).
my_service("Food", 100).
my_service("Guide", 100).
my_service_destination("Local_Transportation", "Istanbul").
my_service_destination("Food", "Istanbul").
my_service_destination("Guide", "Istanbul").
my_service_destination("Local_Transportation", "Paris").
my_service_destination("Food", "Paris").
my_service_destination("Guide", "Paris").
my_service_destination("Accomodation", "Paris").
my_service_destination("Food", "London").
my_service_destination("Guide", "London").


/* Initial goals */

!start.



/* Plans for Auction phase */

+currentBid(B)[artifact_id(ArtId)]        // there is a new value for current bid
      : service(S)[artifact_id(ArtId)] & 
      my_service(S, P) &
      not i_am_winning(ArtId)             
   <- //.print("my bid in auction artifact ", Art, " is ",math.max(V-150,P));
      bid( math.max(B-20,P) )[artifact_id(ArtId)].   // place my bid offering a cheaper service

