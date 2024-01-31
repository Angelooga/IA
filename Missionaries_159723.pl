%state(M: Missionaries, C: Cannibals, Boat Side)
state(3, 3, left).
state(0, 0, left).

% Moving M missionaires and C cannibals from the left to the right
change(move(M, C, right), state(ML, CL, left), state(ML2, CL2, right)):-
    % Estblishing how many missionaries remain and conditions to move
    % missionaries
    ML2 is ML - M, ML2 >= 0, ML2 =< 3,
    CL2 is CL - C, CL2 >= 0, ML2 =< 3.

%Moving M missionaires and C cannibals from the right to the left
change(move(M, C, left), state(ML, CL, right), state(ML2, CL2, left)):-
    % Estblishing how many cannibals remain and conditions to move
    % missionaries
    ML2 is ML + M, ML2 >= 0, ML2 =< 3,
    CL2 is CL + C, CL2 >= 0, ML2 =< 3.

% valid boat moves, move(M, C, Boat_Direction)
move(2,0,_).
move(0,2,_).
move(1,1,_).
move(1,0,_).
move(0,1,_).

% Not valid states 
not_valid(state(2, 3, _)).
not_valid(state(1, 3, _)).
not_valid(state(1, 2, _)).
not_valid(state(2, 1, _)).
not_valid(state(1, 0, _)).
not_valid(state(2, 0, _)).

% Establishing the final condition where 
path(Ini, Ini, _, []).

path(Ini, Fin, Visited, [move(M, C, Dir)|Path]):-
    % Checking the options that we wrote from line 15 to line 19
    move(M, C, Dir),
    % Here we define an auxiliary state to which we can arrive from Ini
    change(move(M, C, Dir), Ini, Aux),
    % Checking if the auxiliary path is valid or not, here \+ is a negation
    \+ not_valid(Aux), 
    % Checking Aux hasn't been visited
    \+ member(Aux, Visited),
    % Recursion where Aux is our new initial position
    path(Aux, Fin, [Aux|Visited], Path).
    
