:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

i_am_at(mall).

path(mall, n, station) :- at(key, in_hand).
path(mall, n, station) :- 
	write('The station will only open with a key.'), nl,
        !, fail.
path(station, s, mall).

path(station, w, car):- at(gun, in_hand).
path(station, w, car):- 
	write('You are missing a gun.'), nl,
        !, fail.
path(car, e,station).

at(gas, station).
at(gun, mall).
at(zombie, car).
at(key, mall).

alive(zombie).

/* These rules describe how to opick up an object. */

take(X) :-
        at(X, in_hand),
        write('You''re already holding it!'),
        nl, !.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(at(X, in_hand)),
        write('OK.'),
        nl, !.

take(_) :-
        write('I don''t see it here.'),
        nl.

/* These rules describe how to kill a zombie. */

kill :-
        i_am_at(car),
        at(gun, in_hand),
        retract(alive(zombie)),
        write('You fired your gun at the zombie and it falls.'), nl,
        write('The zombie stops moving.'),
        nl, !.

kill :-
        i_am_at(car),
        write('You find a zombie, but you are unarmed. '), nl,
        write('The zombie killed you.'), nl,
	!, die.
/* These rules describe how to escape with the car. */

drive :-
	i_am_at(car),
	at(key, in_hand),
	at(gun, in_hand),
        write('Congratulations! You have escaped the zombies'), nl,
        write('and won the game!'), nl,
	finish, !.

/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.


/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
 	write('kill.              -- to attack a zombie.'), nl,
	write('escape.            -- to escape.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
	write('You are at exit of a mall and must escape a horde of zombies. There is a gas station ahead of you and must get it to the car to escape. '),nl.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(mall) :- 
	write('You are at the exit of the mall. The gas station is in the north. You find a gun and a key on the floor. '), nl.
describe(station) :- 
	write('You in a station. The car is to the west. Pick up some gas'), nl.
describe(car) :- 
	alive(zombie),
	at(gun, in_hand),
	write('You see a zombie as you walk towards your car.'), nl,
	write('Fire your gun.'),nl.
describe(car) :-
        alive(zombie),
        write('You see a zombie but you dont have a weapon.'), nl.
	die.