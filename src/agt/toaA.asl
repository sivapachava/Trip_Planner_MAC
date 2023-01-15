// Agent tao in project trip_planner
// Tour Operator Agent


// Has predefined holidat packages(of Itinerary and Content)
// Contract with service company to realise the services offered by the holiday packages


/* Initial beliefs and rules */
holiday_package("HP1", "Istanbul", "Accomodation", "Local_Transportation", "Guide", "Food", "Flight").
my_budget("Accomodation", 500).
my_budget("Local_Transportation", 100).
my_budget("Guide", 150).
my_budget("Food", 200).
my_budget("Flight", 600).
reputation(0.6).
// rule for counting number of tasks(services) based on the observable properties of the auction artifacts.
number_of_services(NS):- .findall( S, task(S), L) & .length(L, NS).

// rule for testing if we have the right number of winner service agents
enough_winners :- number_of_services(NS) & 
	.findall( ArtId, currentWinner(A)[artifact_id(ArtId)] & A \== "no_service_agent", L) &
	.length(L, NS).

/* Initial goals */

!book_services.

/* Plans */
 
// Contracting phase 

+!book_services
	<- !contract;
	   !advertise_packages.
	
+!contract: true
	<- !create_auction_artifacts;
	   !wait_for_bids;
	.

+!create_auction_artifacts: holiday_package(HPId, Destination, Service1, Service2, Service3, Service4, Service5)
	<- 
	!create_auction_artifact(Service1, Destination);	
	!create_auction_artifact(Service2, Destination);
	!create_auction_artifact(Service3, Destination);
	!create_auction_artifact(Service4, Destination);
	!create_auction_artifact(Service5, Destination);
	. 

//Plan for creation a Service Artifact for a given service and destination
+!create_auction_artifact(Service, Destination): my_budget(Service, MaxPrice)
	<- .concat("auction_for", Service, ServiceName);
	.concat( ServiceName, Destination, ArtName);
	makeArtifact(ArtName, "tools.Service", [Service, Destination, MaxPrice], ArtId);
	focus(ArtId);
	.

   
// Plan for bidding and getting the winner of an auction.
+!wait_for_bids
	<- println("Waiting bids for 5 seconds...");
	   .wait(5000);
	   !show_winners;
	   .

+!show_winners
	<- 
	+totalBudget(0);
	for (currentWinner(Ag)[artifact_id(ArtId)]){
		?totalBudget(Budget);
		?currentBid(Price)[artifact_id(ArtId)];
		?service(Service)[artifact_id(ArtId)];
		-+totalBudget(Budget+Price);
		+contracted_sca(Ag,Service);		
		println("Winner of the service ", Service, " is ", Ag, " for ", Price )
	};
	.   

// advertise holiday_package to consumer, if accepted then confirm the booking and execute delivery phase
+!advertise_packages
	<- 
	?holiday_package(HPId, Destination, Service1, Service2, Service3, Service4, Service5);
	?reputation(Reputation);
	?totalBudget(Budget);
	.send(ca, tell, holiday_package(HPId, Destination, Budget, Reputation));
	.

// when the customer confirms the booking toa should supervise the execution phase
+accepted
	<- !go.
	
// Execution phase
+!go <-  .my_name(Me);
         createWorkspace("ora4mas");
         joinWorkspace("ora4mas",WOrg);
         makeArtifact(ora4mas, "ora4mas.nopl.OrgBoard", ["src/org/org_hp_A.xml"], OrgArtId)[wid(WOrg)];
      	focus(OrgArtId);
      	
      // create the group and adopt the role tour_operatorB
      createGroup(hsh_group, holiday_package_group, GrArtId);
      debug(inspector_gui(on))[artifact_id(GrArtId)];
      adoptRole(tour_operator)[artifact_id(GrArtId)];
      focus(GrArtId);
      
      // sub-goal for contracting the winner and making them enter enter into the group
      .send(ca , tell, booked("hsh_group"));
      !service_winners("hsh_group");
      
      // create the scheme
      createScheme(bhsch, go_on_trip_sch, SchArtId);
      debug(inspector_gui(on))[artifact_id(SchArtId)];
      focus(SchArtId);
      
      ?formationStatus(ok)[artifact_id(GrArtId)]; // see plan below to ensure we wait until it is well formed
      addScheme("bhsch")[artifact_id(GrArtId)];
      commitMission("management_of_tour")[artifact_id(SchArtId)];
      .

+!service_winners(GrpName): enough_winners
	<- for(contracted_sca(Agent,Service)){
			.send(Agent,achieve,contract(Service,GrpName))
		}
		.	
		
// plan for contracting in case we don't have enough services
+!service_winners(_)
   <- println("** I didn't find enough service providers!");
      .fail.
      

// Wait until the group is formed
// Makes this intention suspend until the group is believed to be well formed
+?formationStatus(ok)[artifact_id(G)]
   <- .wait({+formationStatus(ok)[artifact_id(G)]}).

+!tour_managed: holiday_package(HPId, Destination, Service1, Service2, Service3, Service4, Service5)
 <- bookServices(HPId).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }
