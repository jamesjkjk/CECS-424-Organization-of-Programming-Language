object(balloon).
object(clothesline).
object(frisbee).
object(water_tower).

enthusiast(ms_barrada).
enthusiast(ms_gort).
enthusiast(mr_klatu).
enthusiast(mr_nikto).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

solve :-
    
    object(BarradaObject), 
    object(GortObject), 
    object(KlatuObject), 
    object(NiktoObject),
    all_different([BarradaObject, GortObject, KlatuObject, NiktoObject]),
    
    day(BarradaDay),
    day(GortDay),
    day(KlatuDay), 
    day(NiktoDay),
    all_different([BarradaDay, GortDay, KlatuDay, NiktoDay]),
    
    Triples = [ [ms_barrada, BarradaObject, BarradaDay],
                [ms_gort, GortObject, GortDay],
                [mr_klatu, KlatuObject, KlatuDay],
                [mr_nikto, NiktoObject, NiktoDay]
                ],

    % 1. Mr. Klatu made his sighting at some point earlier in the week than the one whoi saw the balloon, but at somepoint later in the week that the one who spotted the frisbee(who isnt ms. gort).
    \+(member([mr_klatu, balloon, _], Triples)),
    \+(member([mr_klatu, frisbee, _], Triples)),
    \+(member([ms_gort, frisbee, _], Triples)),
    before([mr_klatu, _, _], [_, balloon, _], Triples),
    after([mr_klatu, _, _], [_, frisbee, _], Triples),

    % 2. Fridays sighting was made by either ms barrada or the one who saw a clothesline(or both).
    (member([ms_barrada, _,friday], Triples);
    member([_,clothesline, friday], Triples)),

    % 3. Mr nikto did not make his sighting on tuesday.
    \+(member([mr_nikto, _, tuesday], Triples)),

    % 4. mr klatu isnt the one whose object turned out to be a water tower.
    \+(member([mr_klatu, water_tower, _], Triples)),  

    tell(ms_barrada, BarradaObject, BarradaDay),
    tell(ms_gort, GortObject, GortDay),
    tell(mr_klatu, KlatuObject, KlatuDay),
    tell(mr_nikto, NiktoObject, NiktoDay).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

before(X, _, [X | _]).
before(_, Y, [Y | _]) :- !, fail.
before(X, Y, [_ | T]) :- before(X, Y, T). 

after(_, X, [X | _]).
after(Y, _, [Y | _]) :- !, fail.
after(X, Y, [H | _]) :- after(X, Y, H).

tell(X, Y, Z) :-
        write(X), write(' saw a '), write(Y), write(' on '), write(Z), write('.'), nl.