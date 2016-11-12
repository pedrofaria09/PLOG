
% Return element by index (Row,col)
getElement(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).

connected(TipoJogo, Board, Backup, X, Y, Element, NrJogada):-
  Value is X+1,
  getElement(Board, Y, Value, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  Value is X-1,
  getElement(Board, Y, Value, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  Value is Y-1,
  getElement(Board, Value, X, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  Value is Y+1,
  getElement(Board, Value, X, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  ValueX is X-1, ValueY is Y-1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  ValueX is X-1, ValueY is Y+1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  ValueX is X+1, ValueY is Y-1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  ValueX is X+1, ValueY is Y+1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca esta conectada'), nl, true;
  nl, nl, write('AVISO!!!'), nl, write('Jogada invalida, precisas de estar conectado!!!'), nl,nl,
  (TipoJogo == 1 -> jogada(NrJogada,Backup); TipoJogo == 2 -> jogadorvscomputador(NrJogada,Backup); TipoJogo == 3 -> computadorvscomputador(NrJogada,Backup)).

:-dynamic dyBoard/1.

verifyConnection(X, Y, Element):- dyBoard(BackBoard),
  changeBoard(none,X,Y,BackBoard,NewBoard), retract(dyBoard(_)), asserta(dyBoard(NewBoard)),
  (dyBoard(List), ValueX is X + 1, ValueY is Y + 0, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X + 1, ValueY is Y + 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X + 0, ValueY is Y + 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X - 1, ValueY is Y + 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X - 1, ValueY is Y - 0, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X - 1, ValueY is Y - 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X - 0, ValueY is Y - 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  dyBoard(List), ValueX is X + 1, ValueY is Y - 1, getElement(List, ValueY, ValueX, Neighbor), Neighbor == Element, verifyConnection(ValueX, ValueY, Element),fail;
  !).

verifyElementConnection(BoardToTest, Element, Return):-
  asserta(dyBoard(BoardToTest)),
  getPositionElement(Element,BoardToTest,Xval,Yval),
  verifyConnection(Xval, Yval, Element),
  dyBoard(List),retract(dyBoard(_)),
  contaListaDeLista(Element, List, NrElements),
  ((NrElements > 0, Return is 0);
  (NrElements == 0, Return is 1)).

getPositionElement(Element,Board,ValueX,ValueY):-
  random(1,11,X), random(1,9,Y), getElement(Board, Y, X, ElementToCheck),
  ((Element \= ElementToCheck), getPositionElement(Element,Board,ValueX,ValueY);
  ValueX is X, ValueY is Y).

% Change content of the board
changeTo(_,[],[],_,_).
changeTo(ElemToChange,[[_|Xs]|Ys],[[ElemToChange|Xs1]|Ys1],1,1) :-
                    !,changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],0,0).

changeTo(ElemToChange,[[X]|Xs],[[X]|Xs1],0,0) :-
                    changeTo(ElemToChange,Xs,Xs1,0,0),!.

changeTo(ElemToChange,[[X|Xs]|Ys],[[X|Xs1]|Ys1],0,0) :-
                    changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],0,0).

changeTo(ElemToChange,[[X|Xs]|Ys],[[X|Xs1]|Ys1],N,1) :-
                    N1 is N-1,
                    changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],N1,1).

changeTo(ElemToChange,[Xs|Ys],[Xs|Ys1],N,M) :-
                    M1 is M-1,
                    changeTo(ElemToChange,Ys,Ys1,N,M1),!.

changeBoard(ElemToChange,X,Y,Board,NewBoard) :-
                    changeTo(ElemToChange,Board,NewBoard,X,Y).



board2([none, none, x, x, none, none, x, x, none, none]).

% Count an element - ONLY LIST!!! NOT LIST OF LIST!!!
conta1Lista(Valor, [H|T], NrVezes) :-
  (H == Valor -> (Y is NrVezes + 1, conta1Lista(Valor, T, Y)); conta1Lista(Valor, T, NrVezes)).
conta1Lista(_,[],NrVezes) :- write(NrVezes).

% Count an element - LIST OF LIST!!!!
contaListaDeLista(_,[],0).
contaListaDeLista(Valor, [H|T], NrVezes) :-
  contaLista(Valor, H, T, NrVezes).
contaLista(Valor, [H|T], L2, NrVezes):-
  (Valor == H -> (contaLista(Valor, T, L2, Y), NrVezes is Y + 1); contaLista(Valor, T, L2, NrVezes)).
contaLista(Valor,[], L2, NrVezes) :- contaListaDeLista(Valor, L2, NrVezes).

% Convert letter to an index
letterToNumber(Letra,Numero):-
  (Letra == 'a' -> Numero is 1;
  Letra == 'b' -> Numero is 2;
  Letra == 'c' -> Numero is 3;
  Letra == 'd' -> Numero is 4;
  Letra == 'e' -> Numero is 5;
  Letra == 'f' -> Numero is 6;
  Letra == 'g' -> Numero is 7;
  Letra == 'h' -> Numero is 8;
  Letra == 'i' -> Numero is 9;
  Letra == 'j' -> Numero is 10).


% Display First Line in a 'dynamic' way
display_primeira(Inicio, Fim):-
  write('   '), Y is Inicio + 0, Inicio =< Fim, char_code(Imprime, Y), write(Imprime), X is Y +1, display_primeira(X, Fim).
display_primeira(_, _).


% Verifica se Input esta entre A-J
letra(TipoJogo, X, NrJogada, Board) :- X == 'a'; X == 'b'; X == 'c'; X == 'd'; X == 'e';
X == 'f';  X == 'g';  X == 'h'; X == 'i';  X == 'j';
(nl, write('Letra invalida! Tente novamente!!!'), nl,
(TipoJogo == 1 -> jogada(NrJogada,Board); TipoJogo == 2 -> jogadorvscomputador(NrJogada,Board))).

% Verifica se Input esta entre 1-8
numero(TipoJogo, X, NrJogada, Board) :- (integer(X), X > 0,  X < 9, true);
(nl, write('Numero invalido! Tente novamente!!!'), nl,
(TipoJogo == 1 -> jogada(NrJogada,Board); TipoJogo == 2 -> jogadorvscomputador(NrJogada,Board))).

% Verifica se um numero é par ou impar
par(N):- N mod 2 =:= 0.
impar(N):- N mod 2 =:= 1.

getNewLine :-
        get_code(T) , (T == 10 -> ! ; getNewLine).

getDigit(D) :-
        get_code(Dt) , D is Dt - 48 , (Dt == 10 -> ! ; getNewLine).

getChar(C) :-
        get_char(C) , char_code(C, Co) , (Co == 10 -> ! ; getNewLine).

% Limpa o terminal
cls :- write('\e[2J').
