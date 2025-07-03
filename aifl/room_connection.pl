% Facts: room connections (bidirectional)
connected(kitchen, hall).
connected(hall, bedroom).
connected(bedroom, bathroom).
connected(hall, diningroom).

% Rule: rooms are connected if they match exactly
path(X, Y) :- connected(X, Y).
path(X, Y) :- connected(Y, X).

% Rule: recursive path (indirect connection)
path(X, Y) :- 
    connected(X, Z), 
    path(Z, Y).

path(X, Y) :- 
    connected(Z, X), 
    path(Z, Y).

--------sample query---------

🔍 Direct connection:
prolog
?- path(kitchen, hall).
true.

🔍 Indirect path (via unification):
prolog

?- path(kitchen, bedroom).
true.
🔍 Which rooms are reachable from kitchen?
prolog

?- path(kitchen, X).
X = hall ;
X = bedroom ;
X = bathroom ;
X = diningroom ;
false.
🔍 Which rooms connect to bathroom?
prolog

?- path(X, bathroom).
X = bedroom ;
X = hall ;
X = kitchen ;
false.
🔄 Explanation of Unification Here:
prolog

path(X, Y) :- connected(X, Y).
When you query:

prolog

?- path(kitchen, X).
