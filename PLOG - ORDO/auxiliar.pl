
% Retorna elemento de uma posicao X,Y
getElement(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).

% Devolve X e Y do vizinho escolhido no modo ordo, verifica se escolheu corretamente um vizinho
getPositionOfOtherElementOrdo(TipoJogo, NumeroJogada, AtualBoard, OldX, OldY, NewX, NewY, OldX2, OldY2, NewXNumber2, NewYNumber2):-
	AuxABSX is OldX - OldX2,
	AuxABSXX is abs(AuxABSX),
	AuxABSY is OldY - OldY2,
	AuxABSYY is abs(AuxABSY),
	(AuxABSXX > 1, nl,nl,write('AVISO!!!'), nl, write('Tens de escolher um vizinho. Tenta novamente!!!'), nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard));true),
	(AuxABSYY > 1, nl,nl,write('AVISO!!!'), nl, write('Tens de escolher um vizinho. Tenta novamente!!!'), nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard));true),
	Aux1 is OldX - NewX,
	Aux11 is abs(Aux1),
	Aux2 is OldY - NewY,
	Aux22 is abs(Aux2),
	(NewX > OldX -> NewXNumber2 is OldX2 + Aux11; NewXNumber2 is OldX2 - Aux11),
	(NewY > OldY -> NewYNumber2 is OldY2 + Aux22; NewYNumber2 is OldY2 - Aux22).

% Escolhe uma peca branca random e lanca uma nova posicao nas suas 5 direcoes
getRandomValuesWhite(Board, OldX, OldY, NewX, NewY):-
	getPositionElement(o,Board,OldX,OldY),
	random(0, 2, CanMoveY), % Se 0, nao move em Y, se 1, move em Y uma casa para cima
	(CanMoveY == 0, NewY is OldY; NewY is OldY-1),
	random(0, 3, XDirection), % Se 0, mantem a direcao em X, se 1: esquerda, se 2: direita
	((XDirection == 0), NewX is OldX; (XDirection == 1), NewX is OldX -1; (XDirection == 2), NewX is OldX + 1),
	((NewX == 11 ; NewX == 0) -> getRandomValuesWhite(Board, _, _, _, _); !,true).

% Escolhe uma peca preta random e lanca uma nova posicao nas suas 5 direcoes
getRandomValuesBlack(Board, OldX, OldY, NewX, NewY):-
	getPositionElement(x,Board,OldX,OldY),
	random(0, 2, CanMoveY), % Se 0, nao move em Y, se 1, move em Y uma casa para baixo
	(CanMoveY == 0, NewY is OldY; NewY is OldY+1),
	random(0, 3, XDirection), % Se 0, mantem a direcao em X, se 1: esquerda, se 2: direita
	((XDirection == 0), NewX is OldX; (XDirection == 1), NewX is OldX -1; (XDirection == 2), NewX is OldX + 1),
	((NewX == 11 ; NewX == 0) -> getRandomValuesBlack(Board, _, _, _, _); !,true).

% Retorna a posicao de um elemento da board.
getPositionElement(Element,Board,ValueX,ValueY):-
  random(1,11,X), random(1,9,Y), getElement(Board, Y, X, ElementToCheck),
  ((Element == ElementToCheck), (ValueX is X, ValueY is Y);
  getPositionElement(Element,Board,ValueX,ValueY)).

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
