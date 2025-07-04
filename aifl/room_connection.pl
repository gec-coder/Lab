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




----------------OR--------------------

% Define connections between rooms
connected(living_room, kitchen).
connected(living_room, bedroom).
connected(living_room, balcony).
connected(kitchen, dining_room).
connected(bedroom, bathroom).

% Ensure the connections are bidirectional
path(X, Y) :- connected(X, Y).
path(X, Y) :- connected(Y, X).

% Define items in each room
item_in(living_room, sofa).
item_in(living_room, tv).
item_in(kitchen, fridge).
item_in(kitchen, oven).
item_in(dining_room, table).
item_in(dining_room, chairs).
item_in(bedroom, bed).
item_in(bedroom, wardrobe).
item_in(bathroom, mirror).
item_in(bathroom, shower).
item_in(balcony, chair).
item_in(balcony, plants).

% Display room details based on user input
room_details(CurrentRoom) :-
    format('Current location: ~w~n', [CurrentRoom]),

    % Show items in the current room
    findall(Item, item_in(CurrentRoom, Item), Items),
    format('Items in ~w: ~w~n', [CurrentRoom, Items]),

    % Find and display connected rooms
    findall(Room, path(CurrentRoom, Room), ConnectedRooms),
    format('Connected rooms: ~w~n', [ConnectedRooms]),

    % Show items in connected rooms
    forall(path(CurrentRoom, Room), (
        findall(Item, item_in(Room, Item), RoomItems),
        format('Items in ~w: ~w~n', [Room, RoomItems])
    )).

% Entry point to get user input and display room details
start :-
    write('Enter your current location (e.g., living_room, kitchen, bedroom, balcony): '),
    read(UserLocation),
    (   room_details(UserLocation)
    ->  true
    ;   write('Invalid room. Try again.'), nl, start
    ).


    
