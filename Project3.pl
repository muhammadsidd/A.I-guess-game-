/* prolog Artificial intelligence Assignment 3 Device identification game by Muhammad Siddiqui and Arasay Perez.  
	
***************READ ME*******************
    to get the program started, user should enter "run." in the swiprolog console
example:

?- run.     

*/

run :- hypothesize(Device),
      write('I guess that the Device is: '),
      write(Device),
      nl,
      undo.

/* hypotheses to be tested */
hypothesize(computer)	:- computer, !.
hypothesize(playstation):- playstation, !.
hypothesize(xbox)   	:- xbox, !.
hypothesize(cellphone)  :- cellphone, !.
hypothesize(laptop)   	:- laptop, !.
hypothesize(calculator) :- calculator,!.
hypothesize(unknown).   /* no diagnosis */

/* animal identification rules */
computer 	:- 	display, 
            		workload,
              		network,
			verify(has_operating_system),
                	verify(has_mouse).
playstation 	:-      network,
         		workload,
			verify(manufacturer_sony).
xbox        	:- 	network, 
               		workload,
	       		verify(manufacturer_microsoft).
cellphone       :- 	portable,
			display,
			network,
			verify(has_sim_card).
laptop          :-      portable,
	  		workload,
	  		network,  
         		verify(has_keyboard).
calculator	:- 	portable,
			workload,
			verify(has_digital_numbers).

/* classification rules */
display    :- verify(connects_to_tv_or_monitor), !.
display    :- verify(has_its_own_display),
		verify(is_portable).
	      
network    :- verify(can_call_phones), !.
network    :- verify(has_internet); 
              verify(has_browser).
portable   :- verify(is_not_heavy), !.
portable   :- display, 
              verify(has_charger).
console	   :- verify(needs_programming_knowledge), !.
console    :- display,
	      verify(has_joystick),
	      verify(has_cd_drive).
workload   :- verify(can_use_for_homework), !.
workload   :- console,
	      network,
	      verify(use_for_entertaining).



/* how to ask questions */
ask(Question) :-
    write('Does the device have the following attribute: '),
    write(Question),
    write('? '),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.