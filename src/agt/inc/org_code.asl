// Common code for the organisational part of the system

service_roles("accomodation",  			[accomodation_contractor]).
service_roles("local_transportation",      [local_transportation_contractor]).
service_roles("food",            			[food_contractor]).
service_roles("guide",             		[guide_contractor]).
service_roles("flight",     				[flight_contractor]).
service_roles("management_of_tour",        [tour_operator]).

+!contract(Service,GroupName)
    : service_roles(Service,Roles)
   <- !in_ora4mas;
      lookupArtifact(GroupName, GroupId);
      for ( .member( Role, Roles) ) {
         adoptRole(Role)[artifact_id(GroupId)];
         focus(GroupId)
      }.

-!contract(Service,GroupName)[error(E),error_msg(Msg),code(Cmd),code_src(Src),code_line(Line)]
   <- .print("Failed to sign the contract for ",Service,"/",GroupName,": ",Msg," (",E,"). command: ",Cmd, " on ",Src,":", Line).


+!in_ora4mas : in_ora4mas.
+!in_ora4mas : .intend(in_ora4mas)
   <- .wait({+in_ora4mas},100,_);
      !in_ora4mas.
@lin[atomic]
+!in_ora4mas
   <- joinWorkspace("ora4mas",_);
      +in_ora4mas.
      
{ include("$moiseJar/asl/org-obedient.asl") }
