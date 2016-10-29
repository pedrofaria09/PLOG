:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(lists)).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,L1) :- impar(NumeroJogada),
	gameArea(NumeroJogada, L1),
	askTypeOfMove(TypeOfMove),
	(TypeOfMove == 1 -> simpleWhiteMove(NumeroJogada, L1, NewBoard2); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(NumeroJogada, L1, NewBoard2, NewBoard3); true),
	Y is NumeroJogada+1,
	jogada(Y, NewBoard3).

%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,L1) :- par(NumeroJogada),
	gameArea(NumeroJogada, L1),
	askTypeOfMove(TypeOfMove),
	(TypeOfMove == 1 -> simpleBlackMove(NumeroJogada, L1, NewBoard2); true),
	(TypeOfMove == 2 -> askBlackOrdoNrMoves(NumeroJogada, L1, NewBoard2); true),
	Y is NumeroJogada+1,
	jogada(Y,NewBoard2).

endOfGame(NumeroJogada):- impar(NumeroJogada),cls, write('Jogador Branco ganha.'),!.
endOfGame(NumeroJogada):- par(NumeroJogada),cls, write('Jogador Preto ganha.'),!.

askTypeOfMove(TypeOfMove) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove).
	
askBlackOrdoNrMoves(NumeroJogada, L1, NewBoard2):-	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	ordoBlackMove(NrMoves, NumeroJogada, L1, NewBoard2).
	
askWhiteOrdoNrMoves(NumeroJogada, L1, NewBoard2, NewBoard3):-	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	ordoWhiteMove(NrMoves, NumeroJogada, L1, NewBoard2, NewBoard3).
	
simpleWhiteMove(NumeroJogada, L1, NewBoard2) :- askPlay(OldX, OldY, NewX, NewY, NumeroJogada, L1),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	getElement(L1, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(NewElement,OldElement, NumeroJogada, L1, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2, L1, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 1 -> cls, endOfGame(NumeroJogada); true).
	
simpleBlackMove(NumeroJogada, L1, NewBoard2) :- askPlay(OldX, OldY, NewX, NewY, NumeroJogada, L1),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	getElement(L1, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(NewElement,OldElement, NumeroJogada, L1, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2, L1, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 8 -> cls, endOfGame(NumeroJogada); true).
	
ordoBlackMove(NrMoves, NumeroJogada, L1, NewBoard2) :- ((NrMoves == 0) -> true;
	simpleBlackMove(NumeroJogada, L1, NewBoard2),
	Y is NrMoves-1,
	ordoBlackMove(Y, NumeroJogada, NewBoard2, NewBoard2)).

ordoWhiteMove(NrMoves, NumeroJogada, L1, NewBoard2, NewBoard3) :- ((NrMoves == 0) -> true;
	simpleWhiteMove(NumeroJogada, L1, NewBoard2),
	Y is NrMoves-1,
	ordoWhiteMove(Y, NumeroJogada, NewBoard2, NewBoard3, NewBoard3)).

