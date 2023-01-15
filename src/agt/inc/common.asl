// Agent common in project trip_planner

/* auxiliary rules for agents */

i_am_winning(Art)   // check if I placed the current best bid on auction artifact Art
   :- currentWinner(W)[artifact_id(Art)] &
      .my_name(Me) & .term2string(Me,MeS) & W == MeS.
      


// a rule to help the agent infer whether it can commit to another task
can_commit :-
   .my_name(Me) & .term2string(Me,MeS) &
   .findall( ArtId, currentWinner(MeS)[artifact_id(ArtId)], L) &
   .length(L,S) & S < 5.

//discover artifact
+!start : true
               <- for ( my_service_destination(Service, Destination) ) {
                     .concat("auction_for", Service, ServiceName);
                     .concat(ServiceName, Destination, ArtName);
                     !discover_art(ArtName);
                      };
                  .


// try to find a particular artifact and then focus on it
+!discover_art(ArtName)
   <- lookupArtifact(ArtName,ArtId);
      focus(ArtId)
      .
// keep trying until the artifact is found
-!discover_art(ArtName)
   <- .wait(100);
      !discover_art(ArtName).



{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
{ include("$moiseJar/asl/org-obedient.asl") }

