:-consult(auxiliar).
:-consult(display).
:-consult(logic).
:-use_module(library(random)).
:-use_module(library(lists)).
:-use_module(library(unix)).

%############################# JOGADOR vs JOGADOR ###############################
%Jogada Par - Joga as Pretas - ' X '
jogada(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(1, TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleBlackMove(1,NumeroJogada, AtualBoard, NewBoard); true),
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

endOfGame(NumeroJogada):- impar(NumeroJogada), write('Jogador Branco ganha.'), nl, nl, nl, break.
endOfGame(NumeroJogada):- par(NumeroJogada), write('Jogador Preto ganha.'), nl, nl, nl, break.

askTypeOfMove(TipoJogo, TypeOfMove, NumeroJogada, AtualBoard) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove),
	((TypeOfMove == 1 ; TypeOfMove == 2) -> true;
	write('Valor errado, escolha novamente'), nl, (TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard); TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard))).

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

askPlay(TipoJogo, ColunaToMove, LinhaToMove, ColunaDestino, LinhaDestino, NrJogada, Board) :-
	write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(TipoJogo, ColunaToMove, NrJogada, Board),
	write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(TipoJogo, LinhaToMove, NrJogada, Board),
 	write('Digite a coluna (letra) do destino'), nl,
	getChar(ColunaDestino),
	letra(TipoJogo, ColunaDestino, NrJogada, Board),
 	write('Digite a linha (numero) do destino'), nl,
	getDigit(LinhaDestino),
	numero(TipoJogo, LinhaDestino, NrJogada, Board).

simpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, Return),
	((Return == 0) ->  warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo,NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).

simpleBlackMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, Return),
	((Return == 0) -> warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).

ordoBlackMove(_,0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoBlackMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is NrMoves - 1,
	simpleBlackMove(TipoJogo, NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoBlackMove(TipoJogo, Y, NumeroJogada, BackBoard, NewBoard); true).

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
	simpleRandoomBlackMove(2, NumeroJogada, AtualBoard, NewBoard),
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

simpleRandoomBlackMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, Return),
	((Return == 0) -> warningNotConnected(1); true),
	random(1, 11, OldXNumber),
	NewXNumber is OldXNumber,
	random(1, 9, OldY),
	NewY is OldY+1,
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).

simpleRandoomWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, Return),
	((Return == 0) ->  warningNotConnected(1); true),
	random(1, 11, OldXNumber),
	NewXNumber is OldXNumber,
	random(1, 9, OldY),
	NewY is OldY-1,
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).


%############################# COMPUTADOR vs COMPUTADOR ###############################

%Jogada Par - Joga as Pretas - ' X ' - COMPUTADOR
computadorvscomputador(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	simpleRandoomBlackMove(3, NumeroJogada, AtualBoard, NewBoard),
	gameArea(NumeroJogada, AtualBoard),
	Y is NumeroJogada + 1,
	computadorvscomputador(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O ' - JOGADOR
computadorvscomputador(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	simpleRandoomWhiteMove(3, NumeroJogada, AtualBoard, NewBoard),
	gameArea(NumeroJogada, AtualBoard),
	Y is NumeroJogada + 1,
	computadorvscomputador(Y, NewBoard).
