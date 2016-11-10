:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(random)).
:-use_module(library(lists)).

%############################# JOGADOR vs JOGADOR ###############################
%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(1, TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleBlackMove(NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(1, TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleWhiteMove(1, NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(1,NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

endOfGame(NumeroJogada):- impar(NumeroJogada), cls, write('Jogador Branco ganha.'), !.
endOfGame(NumeroJogada):- par(NumeroJogada), cls, write('Jogador Preto ganha.'), !.

askTypeOfMove(1, TypeOfMove, NumeroJogada, AtualBoard) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove),
	((TypeOfMove \= 1 , TypeOfMove \= 2) -> write('Valor errado, escolha novamente'), nl, jogada(NumeroJogada,AtualBoard);true).
	
askTypeOfMove(2, TypeOfMove, NumeroJogada, AtualBoard) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove),
	((TypeOfMove \= 1 , TypeOfMove \= 2) -> write('Valor errado, escolha novamente'), nl, jogadorvscomputador(NumeroJogada,AtualBoard);true).

askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard):-
	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	((NrMoves > 10) -> (write('Numero de pecas a mover errado, escolha novamente!'), nl, askBlackOrdoNrMoves(NumeroJogada, AtualBoard, NewBoard));
	ordoBlackMove(NrMoves, NumeroJogada, AtualBoard, NewBoard)).

askWhiteOrdoNrMoves(TipoJogo, NumeroJogada, AtualBoard, NewBoard):-
	write('Numero de pecas a mover: '), nl,
	getDigit(NrMoves),
	((NrMoves > 10) -> (write('Numero de pecas a mover errado, escolha novamente!'), nl, askWhiteOrdoNrMoves(TipoJogo, NumeroJogada, AtualBoard, NewBoard));
	ordoWhiteMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard)).

simpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	(NewY == 1 -> cls, endOfGame(NumeroJogada); true).

simpleBlackMove(NumeroJogada, AtualBoard, NewBoard) :- askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(1, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
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

ordoWhiteMove(_, 0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoWhiteMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is NrMoves - 1,
	format('Tem ~d movimento(s) disponiveis', [NrMoves]), nl,
	simpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoWhiteMove(TipoJogo, Y, NumeroJogada, BackBoard, NewBoard); true).
	
%############################# JOGADOR vs COMPUTADOR ###############################

%Jogada Par - Joga as Pretas - ' X ' - COMPUTADOR
jogadorvscomputador(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	simpleRandoomBlackMove(NumeroJogada, AtualBoard, NewBoard),
	Y is NumeroJogada + 1,
	jogadorvscomputador(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O ' - JOGADOR
jogadorvscomputador(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(2, TypeOfMove, NumeroJogada, AtualBoard),
	(TypeOfMove == 1 -> simpleWhiteMove(2, NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(2, NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogadorvscomputador(Y, NewBoard).
		
	
simpleRandoomBlackMove(NumeroJogada, AtualBoard, NewBoard) :- 
	letterToNumber('a', OldXNumber),
	letterToNumber('a', NewXNumber),
	getElement(AtualBoard, 3, OldXNumber, OldElement),
	getElement(AtualBoard, 4, NewXNumber, NewElement),
	verifySimpleBlackMove(2, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, 3, 4),
	changeBoard(NewElement2, OldXNumber, 3, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, 4, NewBoard1, NewBoard),
	connected(NewBoard, AtualBoard, NewXNumber, 4, OldElement, NumeroJogada),
	(4 == 8 -> cls, endOfGame(NumeroJogada); true).
