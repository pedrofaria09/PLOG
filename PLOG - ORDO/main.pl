:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(lists)).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,L1) :- impar(NumeroJogada),
	gameArea(NumeroJogada, L1),
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, L1, OldXNumber, NewXNumber),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	getElement(L1, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(NewElement,OldElement, NumeroJogada, L1,NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2, L1, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 1 -> cls, endOfGame(NumeroJogada); true),
	Y is NumeroJogada+1,
	jogada(Y, NewBoard2).

%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,L1) :- par(NumeroJogada),
	gameArea(NumeroJogada, L1),
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, L1, OldXNumber, NewXNumber),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	getElement(L1, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(NewElement,OldElement, NumeroJogada, L1, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2, L1, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 8 -> cls, endOfGame(NumeroJogada); true),
	Y is NumeroJogada+1,
	jogada(Y,NewBoard2).

endOfGame(NumeroJogada):- impar(NumeroJogada),cls, write('Jogador Branco ganha.'),!.
endOfGame(NumeroJogada):- par(NumeroJogada),cls, write('Jogador Preto ganha.'),!.

