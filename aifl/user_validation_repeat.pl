% Declare dynamic predicate for storing user data
:- dynamic user/2.

% ---------- User Registration ----------
register_user :-
    write('Register New User'), nl,
    write('Enter username: '), read(Username),
    write('Enter password: '), read(Password),
    assertz(user(Username, Password)),
    write('User registered successfully!'), nl.

% ---------- 1. Validation using fail ----------
login_with_fail :-
    write('Login With Fail Predicate'), nl,
    write('Enter username: '), read(Username),
    write('Enter password: '), read(Password),
    ( user(Username, Password)
    -> write('Login successful!'), nl
    ;  write('Login failed.'), nl, fail
    ).

% ---------- 2. Validation without repeat/fail (one-shot) ----------
login_once :-
    write('Login Without Repeat Predicate'), nl,
    write('Enter username: '), read(Username),
    write('Enter password: '), read(Password),
    ( user(Username, Password)
    -> write('Login successful!'), nl
    ;  write('Login failed.'), nl
    ).

% ---------- 3. Validation using repeat ----------
login_with_repeat :-
    repeat,
    write('Login With Repeat Predicate'), nl,
    write('Enter username: '), read(Username),
    write('Enter password: '), read(Password),
    ( user(Username, Password)
    -> write('Login successful!'), nl, !
    ;  write('Login failed. Try again.'), nl, fail
    ).
