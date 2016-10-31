:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(lists)).

%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleBlackMove(NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleWhiteMove(NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

endOfGame(NumeroJogada):- impar(NumeroJogada), cls, write('Jogador Branco ganha.'), !.
endOfGame(NumeroJogada):- par(NumeroJogada), cls, write('Jogador Preto ganha.'), !.

askTypeOfMove(TypeOfMove,NumeroJogada,AtualBoard) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove),
	((TypeOfMove \= 1 , TypeOfMove \= 2) -> write('Valor errado, escolha novamente'), nl, jogada(NumeroJogada,AtualBoard);true).

askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard):-
	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	((NrMoves > 10) -> (write('Numero de pecas a mover errado, escolha novamente!'), nl, askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard));
	ordoBlackMove(NrMoves, NumeroJogada, AtualBoard, NewBoard)).

askWhiteOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard):-
	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	((NrMoves > 10) -> (write('Numero de pecas a mover errado, escolha novamente!'), nl, askWhiteOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard));
	ordoWhiteMove(NrMoves, NumeroJogada, AtualBoard, NewBoard)).

simpleWhiteMove(NumeroJogada, AtualBoard, NewBoard) :-
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 1 -> cls, endOfGame(NumeroJogada); true).

simpleBlackMove(NumeroJogada, AtualBoard, NewBoard) :- askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 8 -> cls, endOfGame(NumeroJogada); true).

ordoBlackMove(0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoBlackMove(NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is NrMoves - 1,
	simpleBlackMove(NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoBlackMove(Y, NumeroJogada, BackBoard, NewBoard); true).

ordoWhiteMove(0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoWhiteMove(NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is NrMoves - 1,
	format('Tem ~d movimento(s) disponiveis', [NrMoves]), nl,
	simpleWhiteMove(NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoWhiteMove(Y, NumeroJogada, BackBoard, NewBoard); true).
