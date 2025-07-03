% Facts
parent(john, mary).
parent(mary, alice).
parent(john, mike).
parent(mike, tom).

% Rules
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).

% Additional facts
male(john).
male(mike).
male(tom).
female(mary).
female(alice).

-----sample query------
?- parent(john, mary).
true.

?- grandparent(john, alice).
true.

?- father(john, mary).
true.

?- mother(mary, alice).
true.
