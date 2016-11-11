-dynamic oi/1.

verifyConnection(Board, 0, 0, 0, 0, _, BoardEdited):- BoardEdited = Board.
verifyConnection(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard), (\+retract(oi(_)); retract(oi(_))), asserta(oi(NewBoard)),oi(List),
  (ValueX is X + 1, ValueY is Y + 0, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim1'), nl, write(X), nl, write(Y), nl, verifyConnection11(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnection11(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X + 1, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection11(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim2'), nl, write(X), nl, write(Y), nl, verifyConnection01(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnection01(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X + 0, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection01(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim3'), nl, write(X), nl, write(Y), nl, verifyConnectionX11(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnectionX11(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X - 1, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnectionX11(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim4'), nl, write(X), nl, write(Y), nl, verifyConnectionX10(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnectionX10(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X - 1, ValueY is Y + 0, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnectionX10(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim5'), nl, write(X), nl, write(Y), nl, verifyConnectionX1Y1(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnectionX1Y1(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X - 1, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnectionX1Y1(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim6'), nl, write(X), nl, write(Y), nl, verifyConnection0Y1(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnection0Y1(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X + 0, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection0Y1(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim7'), nl, write(X), nl, write(Y), nl, verifyConnection1Y1(NewBoard, BackX, BackY, BackX, BackY, Element, BoardEdited)).

verifyConnection1Y1(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard),
  (ValueX is X + 1, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection1Y1(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim8'), nl, write(X), nl, write(Y), nl, verifyConnection(NewBoard, 0, 0, 0, 0, _, BoardEdited)).


->,x1,y1,testarse da, ir pra la msm funcao,fail;
t,x1,y1,testar se da
-<<-;
;true.
assert(oi(board))
oi(board)

(\+retract(dyBoard(_)); retract(dyBoard(_))), asserta(dyBoard(NewBoard)),dyBoard(List),

verifyConnection(Board, 0, 0, 0, 0, _, BoardEdited):- BoardEdited = Board.
verifyConnection(Board, BackX, BackY, X, Y, Element, BoardEdited):-
  changeBoard(none,X,Y,Board,NewBoard), (\+retract(oi(_)); retract(oi(_))), asserta(oi(NewBoard)),oi(List), display_board(1,List),
  (ValueX is X + 1, ValueY is Y + 0, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X + 1, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X + 0, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X - 1, ValueY is Y + 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X - 1, ValueY is Y + 0, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X - 1, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X - 0, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  (ValueX is X + 1, ValueY is Y - 1, getElement(NewBoard, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(NewBoard, BackX, BackY, ValueX, ValueY, Element, BoardEdited);
  write('Cheguei ao fim1'), nl, write(X), nl, write(Y), nl, verifyConnection(NewBoard, 0, 0, 0, 0, _, BoardEdited))))))))).

teste(1):-
  board3(BoardToTest),
  display_board(1,BoardToTest),
  verifyConnection(BoardToTest, 1, 1, 1, 1, x, NewBoards),
  display_board(1,NewBoards).
