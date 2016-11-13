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
