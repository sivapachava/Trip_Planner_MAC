// Agent sca in project trip_planner
// Services Company Agent

{ include("common.asl") }
{ include("org_code.asl") }
{ include("org_goals.asl") }

/* Initial beliefs and rules */
my_service("Accomodation", 200).
my_service("Local_Transportation", 100).
my_service("Food", 100).
my_service_destination("Accomodation", "Istanbul").
my_service_destination("Local_Transportation", "Istanbul").
my_service_destination("Food", "Istanbul").
my_service_destination("Accomodation", "Paris").
my_service_destination("Local_Transportation", "London").



// Whenever the artifact is created
// the sca should check if the artifacts Service and Destination matches with it's offered services
// if it does not match do not do anything.
// if it matches then proceed with the negotiation 



// if the sca receives mulitple service artifacts then choose the best offer from toa
// and then it can negotiate. 

/* Initial goals */

!start.

/* Plans for Auction phase */

+currentBid(B)[artifact_id(ArtId)]         // there is a new value for current bid
    : service(S)[artifact_id(ArtId)] & 
      my_service(S, P) &
      not i_am_winning(ArtId)         
   <- //.print("my bid in auction artifact ", Art, " is ",P);
      bid( P )[artifact_id(ArtId)].  
      
