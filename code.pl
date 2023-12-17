% The main predicate to solve the Eight Queens Puzzle
solve_queens(Board) :-
    length(Board, 8),           % The board has 8 rows
    place_queens(Board, 1).

% Helper predicate to place queens on the board
place_queens([], _).
place_queens([Column|Rest], Row) :-
    between(1, 8, Column),       % Queen can be placed in columns 1 through 8
    is_safe(Rest, Row, Column),
    place_queens(Rest, Row+1).

% Check if placing a queen in the given position is safe
is_safe([], _, _).
is_safe([PrevCol|PrevRest], PrevRow, NewCol) :-
    % Ensure queens in different rows are not in the same column or diagonal
    dif(PrevCol, NewCol),
    dif(PrevCol - NewCol, PrevRow - (PrevRest + 1)),
    is_safe(PrevRest, PrevRow-1, NewCol).

% Predicate to display the solution
display_solution(Board) :-
    display_board(Board, 1).

% Display the entire chessboard
display_board([], _).
display_board([Column|Rest], Row) :-
    display_row(Column, Row, 1),
    nl,
    NextRow is Row + 1,
    display_board(Rest, NextRow).

% Display a single row with a queen
display_row(QueenColumn, CurrentRow, CurrentColumn) :-
    (CurrentColumn =:= QueenColumn -> write(' Q '); write(' . ')),
    NextColumn is CurrentColumn + 1,
    (NextColumn =< 8 -> display_row(QueenColumn, CurrentRow, NextColumn) ; true).

% Example usage:
% ?- solve_queens(Board), display_solution(Board).