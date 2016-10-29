:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(lists)).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,AtualBoard) :- impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(TypeOfMove),
	(TypeOfMove == 1 -> simpleWhiteMove(NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard, NewBoard3); true),
	Y is NumeroJogada+1,
	jogada(Y, NewBoard3).

%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,AtualBoard) :- par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(TypeOfMove),
	(TypeOfMove == 1 -> simpleBlackMove(NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada+1,
	jogada(Y,NewBoard).

endOfGame(NumeroJogada):- impar(NumeroJogada),cls, write('Jogador Branco ganha.'),!.
endOfGame(NumeroJogada):- par(NumeroJogada),cls, write('Jogador Preto ganha.'),!.

askTypeOfMove(TypeOfMove) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove).

askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard):-	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	ordoBlackMove(NrMoves, NumeroJogada, AtualBoard, NewBoard).

askWhiteOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard, NewBoard3):-	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	ordoWhiteMove(NrMoves, NumeroJogada, AtualBoard, NewBoard, NewBoard3).

simpleWhiteMove(NumeroJogada, AtualBoard, NewBoard) :- askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
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

ordoBlackMove(NrMoves, NumeroJogada, AtualBoard, NewBoard) :- ((NrMoves == 0) -> true;
	simpleBlackMove(NumeroJogada, AtualBoard, NewBoard),
	Y is NrMoves-1,
	ordoBlackMove(Y, NumeroJogada, NewBoard, NewBoard)).

ordoWhiteMove(NrMoves, NumeroJogada, AtualBoard, NewBoard, NewBoard3) :- ((NrMoves == 0) -> true;
	simpleWhiteMove(NumeroJogada, AtualBoard, NewBoard),
	Y is NrMoves-1,
	ordoWhiteMove(Y, NumeroJogada, NewBoard, NewBoard3, NewBoard3)).
