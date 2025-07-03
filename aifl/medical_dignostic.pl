% Declare dynamic facts for user responses
:- dynamic yes/1, no/1.

% ---------- User Interaction ----------
ask(Symptom) :-
    (yes(Symptom) -> true ;
     no(Symptom) -> fail ;
     write('Do you have '), write(Symptom), write('? (yes/no): '),
     read(Answer),
     nl,
     ( (Answer == yes ; Answer == y)
       -> assertz(yes(Symptom))
       ;  assertz(no(Symptom)), fail)
    ).

% ---------- Disease Rules ----------
disease(cold) :-
    ask(sneezing),
    ask(runny_nose),
    ask(sore_throat),
    ask(cough).

disease(flu) :-
    ask(fever),
    ask(headache),
    ask(chills),
    ask(body_ache),
    ask(fatigue).

disease(covid19) :-
    ask(fever),
    ask(cough),
    ask(breathing_difficulty),
    ask(loss_of_smell),
    ask(tiredness).

disease(malaria) :-
    ask(fever),
    ask(chills),
    ask(sweating),
    ask(nausea),
    ask(headache).

% ---------- Main Diagnostic Rule ----------
diagnose :-
    disease(Disease),
    write('You may be suffering from: '), write(Disease), nl,
    undo.

diagnose :-
    write('Sorry, diagnosis could not be determined.'), nl,
    undo.

% ---------- Reset stored answers ----------
undo :- 
    retract(yes(_)), fail.
undo :- 
    retract(no(_)), fail.
undo.
