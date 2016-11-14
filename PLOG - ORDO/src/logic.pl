:-consult(auxiliar).

% Conjunto de algumas regras do jogador das pecas brancas
verifySimpleWhiteMove(TipoJogo, STATUS_CONECTION, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	(STATUS_CONECTION \= 0, verifyWhiteNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard); true),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonBlack(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceX(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

% Conjunto de algumas regras do jogador das pecas pretas
verifySimpleBlackMove(TipoJogo, STATUS_CONECTION, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	(STATUS_CONECTION \= 0, verifyBlackNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard); true),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonWhite(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceO(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

% Verifica se no modo ordo o jogado tenta tirar uma peca do adversario
cantEatOponentBlackOrdo(TipoJogo, NumeroJogada, AtualBoard, Element):-
	(Element == 'x' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes apanhar a peca do adversario no modo ordo! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

% Verifica se no modo ordo o jogado tenta tirar uma peca do adversario
cantEatOponentWhiteOrdo(TipoJogo, NumeroJogada, AtualBoard, Element):-
	(Element == 'o' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes apanhar a peca do adversario no modo ordo! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

% Verifica se a peca a escolher para mover é a do jogador adversário
verifyElementNonBlack(TipoJogo, Element, NumeroJogada, AtualBoard):-
	(Element == 'x' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

%  Verifica se a peca a escolher para mover é a do jogador adversário
verifyElementNonWhite(TipoJogo, Element, NumeroJogada, AtualBoard):-
	(Element == 'o' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

%  Verifica se a peca a escolher para mover é uma peca da board vazia
verifyElementNonNone(TipoJogo, Element,NumeroJogada,AtualBoard):-
	(Element == 'none' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher uma peca vazia! Joga novamente'),  nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

%  Verifica se a peca a escolher como destino e uma das suas proprias pecas - Jogador X
verifyPieceX(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2):-
	((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); NewElement2 = 'none').

%  Verifica se a peca a escolher como destino e uma das suas proprias pecas - Jogador O
verifyPieceO(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2):-
	((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); NewElement2 = 'none').

%  Verifica se o jogador X pode andar para tras
verifyBlackNonBackMove(TipoJogo, NewY,OldY , NumeroJogada, AtualBoard) :-
	((NewY < OldY) -> nl, nl, write('AVISO!!!'), nl, write('Nao podes andar para tras! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard)); true).

%  Verifica se o jogador O pode andar para tras
verifyWhiteNonBackMove(TipoJogo, NewY,OldY , NumeroJogada, AtualBoard) :-
	((NewY > OldY) -> nl, nl, write('AVISO!!!'), nl, write('Nao podes andar para tras! Joga novamente'), nl, nl,
	(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
	TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
	TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard)); true).

% Verifica a conecao do jogador no final da jogada dependendo se estava conectado ou nao ao inicio da jogada
verifyConnectionByPlayerOrOther(TipoJogo, NumeroJogada, AtualBoard, NewBoard, STATUS_PLAYER1, STATUS_PLAYER2, STATUS_CONECTION2):-
	((STATUS_CONECTION2 == 0, STATUS_PLAYER2 == 1) -> (cls, gameArea(NumeroJogada, NewBoard), nl, write('Nao estas conenctado!!!'), nl, nl, AUX is NumeroJogada + 1, endOfGame(AUX)); true),
	((STATUS_CONECTION2 == 0, STATUS_PLAYER1 == 0) ->
		(nl,nl, write('Aviso!!!'), nl, write('Tens de repetir a jogada!!! Nao estavas conectado!!!'), nl,
		(TipoJogo == 1 -> jogada(NumeroJogada,AtualBoard);
		TipoJogo == 2 -> jogadorvscomputador(NumeroJogada,AtualBoard);
		TipoJogo == 3 -> computadorvscomputador(NumeroJogada,AtualBoard))); true).

:-dynamic dyBoard/1.

% Funcao auxiliar da verifyElementConnection() - limpa o elemento e verifica os seus vizinhos, limpando estes até não haver mais elementos vizinhos
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

% Verifica a conectividade das pecas de um jogador, retorna 1 se conectado e 0 se caso contrario
verifyElementConnection(BoardToTest, Element, Return):-
  asserta(dyBoard(BoardToTest)),
  getPositionElement(Element,BoardToTest,Xval,Yval),
  verifyConnection(Xval, Yval, Element),
  dyBoard(List),retract(dyBoard(_)),
  contaListaDeLista(Element, List, NrElements),
  ((NrElements > 0, Return is 0);
  (NrElements == 0, Return is 1)).


% Verifica se esta conectado a uma outra peca apos uma jogada
connected(TipoJogo, Board, Backup, X, Y, Element, NrJogada):-
  Value is X+1,
  getElement(Board, Y, Value, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  Value is X-1,
  getElement(Board, Y, Value, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  Value is Y-1,
  getElement(Board, Value, X, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  Value is Y+1,
  getElement(Board, Value, X, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  ValueX is X-1, ValueY is Y-1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  ValueX is X-1, ValueY is Y+1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  ValueX is X+1, ValueY is Y-1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  ValueX is X+1, ValueY is Y+1,
  getElement(Board, ValueY, ValueX, Neighbor),
  Element == Neighbor -> write('Peca movida esta ligada a outra'), nl, true;
  nl, nl, write('AVISO!!!'), nl, write('Jogada invalida, precisas de estar conectado!!!'), nl,nl,
  (TipoJogo == 1 -> jogada(NrJogada,Backup); TipoJogo == 2 -> jogadorvscomputador(NrJogada,Backup); TipoJogo == 3 -> computadorvscomputador(NrJogada,Backup)).
