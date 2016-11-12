simpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, Return),
	((Return == 0) ->  warningNotConnected(1); true),
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleWhiteMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
%	connected(TipoJogo,NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).

simpleBlackMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, x, Return),
	((Return == 0) -> warningNotConnected(1); true),
	askPlay(OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	verifySimpleBlackMove(TipoJogo, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY),
	changeBoard(NewElement2, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
%	connected(TipoJogo, NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, x, Return2),
	((Return2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 8 -> (cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada)); true).





testSimpleWhiteMove(TipoJogo, NumeroJogada, AtualBoard, NewBoard) :-
	verifyElementConnection(AtualBoard, o, STATUS_CONECTION),
	((STATUS_CONECTION == 0) ->  warningNotConnected(1); true),
	askPlay(TipoJogo, OldX, OldY, NewX, NewY, NumeroJogada, AtualBoard),
	askPlay2(TipoJogo, OldX2, OldY2, NumeroJogada, AtualBoard),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	letterToNumber(OldX2, OldXNumber2),
	getPositionOfOtherElementOrdo(OldXNumber, OldY, NewXNumber, NewY, OldXNumber2, OldY2, NewXNumber2, NewYNumber2);
	getElement(AtualBoard, OldY, OldXNumber, OldElement),
	getElement(AtualBoard, NewY, NewXNumber, NewElement),
	getElement(AtualBoard, OldY2, OldXNumber2, OldElement2),
	getElement(AtualBoard, NewYNumber2, NewXNumber2, NewElement2),
	verifySimpleWhiteMove(TipoJogo, 1, NewElement,OldElement, NumeroJogada, AtualBoard, NewElement3, OldY, NewY),
	verifySimpleWhiteMove(TipoJogo, 1, NewElement2,OldElement2, NumeroJogada, AtualBoard, NewElement4, OldY2, NewYNumber2),
	changeBoard(NewElement3, OldXNumber, OldY, AtualBoard, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard),
	changeBoard(NewElement4, OldXNumber2, OldY2, AtualBoard, NewBoard1),
	changeBoard(OldElement2, NewXNumber2, NewYNumber2, NewBoard1, NewBoard),
	connected(TipoJogo,NewBoard, AtualBoard, NewXNumber, NewY, OldElement, NumeroJogada),
	verifyElementConnection(NewBoard, o, STATUS_CONECTION2),
	((STATUS_CONECTION2 == 0) -> (cls, finalgameArea(NewBoard), nl, write('Nao estas conenctado!!!'), nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	(NewY == 1 -> cls, finalgameArea(NewBoard), nl, endOfGame(NumeroJogada); true).


getPositionOfOtherElementOrdo(OldX, OldY, NewX, NewY, OldX2, OldY2, NewXNumber2, NewYNumber2):-
	Aux1 is OldX - NewX,
	Aux11 is abs(Aux1),
	Aux2 is OldY - NewY,
	Aux22 is abs(Aux2),
	(NewX > OldX -> NewXNumber2 is OldX2 + Aux11; NewXNumber2 is OldX2 - Aux11),
	(NewY > OldY -> NewYNumber2 is OldY2 + Aux22; NewYNumber2 is OldY2 - Aux22).


askPlay2(TipoJogo, ColunaToMove, LinhaToMove, NrJogada, Board) :-
	write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(TipoJogo, ColunaToMove, NrJogada, Board),
	write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(TipoJogo, LinhaToMove, NrJogada, Board).
