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
	(TypeOfMove == 1 -> simpleBlackMove(1,NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askBlackOrdoNrMoves(1, NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O '
jogada(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	askTypeOfMove(1, TypeOfMove,NumeroJogada,AtualBoard),
	(TypeOfMove == 1 -> simpleWhiteMove(1, NumeroJogada, AtualBoard, NewBoard); true),
	(TypeOfMove == 2 -> askWhiteOrdoNrMoves(1, NumeroJogada, AtualBoard, NewBoard); true),
	Y is NumeroJogada + 1,
	jogada(Y, NewBoard).

% Fim de jogo
endOfGame(NumeroJogada):- ((impar(NumeroJogada), write('Jogador Branco ganha.'));(par(NumeroJogada), write('Jogador Preto ganha.'))), nl, nl, nl, break.

% Pergunta ao utilizador se pretende usar a jogada simples ou ordo
askTypeOfMove(TipoJogo, TypeOfMove, NumeroJogada, AtualBoard) :- write('Escolha tipo de jogada: '), nl,
	write('1 - Simples'), nl,
	write('2 - Ordo'), nl,
	getDigit(TypeOfMove),
	((TypeOfMove == 1 ; TypeOfMove == 2) -> true;
	write('Valor errado, escolha novamente'), nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard); TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard))).

% Informativo apenas, informa o jogador das pecas pretas que pode escolher duas peças para mover ao mesmo tempo no modo ordo
askBlackOrdoNrMoves(TipoJogo, NumeroJogada, AtualBoard, NewBoard):-
	write('Pode escolher duas pecas conjuntas para mover '), nl,
	NrMoves is 2,
	ordoBlackMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard).

% Informativo apenas, informa o jogador das pecas brancas que pode escolher duas peças para mover ao mesmo tempo no modo ordo
askWhiteOrdoNrMoves(TipoJogo, NumeroJogada, AtualBoard, NewBoard):-
	write('Pode escolher duas pecas conjuntas para mover '), nl,
	NrMoves is 2,
	ordoWhiteMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard).

% Pergunta ao jogador as posicoes das pecas a serem movidas
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

% Predicado principal do movimento simples das pecas brancas
simpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, STATUS_CONECTION),
	((STATUS_CONECTION == 0) ->  warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, STATUS_CONECTION, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo,NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).

% Predicado principal do movimento simples das pecas pretas
simpleBlackMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, STATUS_CONECTION),
	((STATUS_CONECTION == 0) -> warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(TipoJogo, STATUS_CONECTION, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).

% Predicado que chama o movimento ordo para o jogador das pecas pretas e mostra algumas informacoes do jogo
ordoBlackMove(_,0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoBlackMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is 0,
	format('Tem ~d movimento(s) disponiveis', [NrMoves]), nl,
	ordoBlackMovement(TipoJogo, NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoBlackMove(TipoJogo, Y, NumeroJogada, BackBoard, NewBoard); true).

% Predicado principal do movimento ordo do jogador das pecas pretas
ordoBlackMovement(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, STATUS_CONECTION),
	((STATUS_CONECTION == 0) -> warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	askPlay2(TipoJogo, OldX2, OldY2, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	letterToNumber(OldX2, OldXNumber2),
	getPositionOfOtherElementOrdo(TipoJogo, NumeroJogada, AtualBoard, OldXNumber, OldY, NewXNumber, NewY, OldXNumber2, OldY2, NewXNumber2, NewY2),
	write(NewXNumber2), write(NewY2),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	cantEatOponentWhiteOrdo(TipoJogo, NumeroJogada, AtualBoard, NewElement),
	getElement(AtualBoard, OldY2, OldXNumber2, OldElement2),
	getElement(AtualBoard, NewY2, NewXNumber2, NewElement2),
	cantEatOponentWhiteOrdo(TipoJogo, NumeroJogada, AtualBoard, NewElement2),
	verifySimpleBlackMove(TipoJogo, 1, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement3, OldY, NewY),
	verifySimpleBlackMove(TipoJogo, 1, NewElement2, OldElement2, NumeroJogada, AtualBoard, NewElement4, OldY2, NewY2),
	changeBoard(NewElement3, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	changeBoard(NewElement4, OldXNumber2, OldY2, NewBoard2, NewBoard3),
	changeBoard(OldElement2, NewXNumber2, NewY2, NewBoard3, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).

% Predicado que chama o movimento ordo para o jogador das pecas brancas e mostra algumas informacoes do jogo
ordoWhiteMove(_, 0,_,AtualBoard,NewBoard):- NewBoard = AtualBoard.
ordoWhiteMove(TipoJogo, NrMoves, NumeroJogada, AtualBoard, NewBoard) :-
	(NrMoves > 0 ->
	Y is 0,
	format('Tem ~d movimento(s) disponiveis', [NrMoves]), nl,
	ordoWhiteMovement(TipoJogo, NumeroJogada, AtualBoard, BackBoard),
	gameArea(NumeroJogada, BackBoard),
	ordoWhiteMove(TipoJogo, Y, NumeroJogada, BackBoard, NewBoard); true).

% Predicado principal do movimento ordo do jogador das pecas brancas
ordoWhiteMovement(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, STATUS_CONECTION),
	((STATUS_CONECTION == 0) ->  warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	askPlay2(TipoJogo, OldX2, OldY2, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	letterToNumber(OldX2, OldXNumber2),
	getPositionOfOtherElementOrdo(TipoJogo, NumeroJogada, AtualBoard, OldXNumber, OldY, NewXNumber, NewY, OldXNumber2, OldY2, NewXNumber2, NewY2),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	cantEatOponentBlackOrdo(TipoJogo, NumeroJogada, AtualBoard, NewElement),
	getElement(AtualBoard, OldY2, OldXNumber2, OldElement2),
	getElement(AtualBoard, NewY2, NewXNumber2, NewElement2),
	cantEatOponentBlackOrdo(TipoJogo, NumeroJogada, AtualBoard, NewElement2),
	verifySimpleWhiteMove(TipoJogo, 1, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement3, OldY, NewY),
	verifySimpleWhiteMove(TipoJogo, 1, NewElement2, OldElement2, NumeroJogada, AtualBoard, NewElement4, OldY2, NewY2),
	changeBoard(NewElement3, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	changeBoard(NewElement4, OldXNumber2, OldY2, NewBoard2, NewBoard3),
	changeBoard(OldElement2, NewXNumber2, NewY2, NewBoard3, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).

% Predicado que pergunta a posicao inicial da segunda peca do movimento ordo
askPlay2(TipoJogo, ColunaToMove, LinhaToMove, NrJogada, Board) :-
	nl,nl,write('Posicao inicial da segunda peca!!!'), nl,
	write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(TipoJogo, ColunaToMove, NrJogada, Board),
	write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(TipoJogo, LinhaToMove, NrJogada, Board).


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

% Predicado principal do movimento simples no modo Computador para as pecas pretas
simpleRandoomBlackMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, STATUS_CONECTION),
	((STATUS_CONECTION == 0) -> warningNotConnected(1); true),
	getRandomValuesBlack(AtualBoard, OldXNumber, OldY, NewXNumber, NewY),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(TipoJogo, STATUS_CONECTION, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	writePositionInformation(OldXNumber, OldY, NewXNumber, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).

% Predicado principal do movimento simples no modo Computador para as pecas brancas
simpleRandoomWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, STATUS_CONECTION),
	((STATUS_CONECTION == 0) ->  warningNotConnected(1); true),
	getRandomValuesWhite(AtualBoard, OldXNumber, OldY, NewXNumber, NewY),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, STATUS_CONECTION, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	writePositionInformation(OldXNumber, OldY, NewXNumber, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).

%############################# COMPUTADOR vs COMPUTADOR ###############################
%Jogada Par - Joga as Pretas - ' X ' - COMPUTADOR
computadorvscomputador(NumeroJogada,AtualBoard) :-
	par(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	simpleRandoomBlackMove(3, NumeroJogada, AtualBoard, NewBoard),
	Y is NumeroJogada + 1,
	computadorvscomputador(Y, NewBoard).

%Jogada Impar - Joga as Brancas - ' O ' - COMPUTADOR
computadorvscomputador(NumeroJogada,AtualBoard) :-
	impar(NumeroJogada),
	gameArea(NumeroJogada, AtualBoard),
	simpleRandoomWhiteMove(3, NumeroJogada, AtualBoard, NewBoard),
	Y is NumeroJogada + 1,
	computadorvscomputador(Y, NewBoard).
