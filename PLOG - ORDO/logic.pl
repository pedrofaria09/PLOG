:-consult(auxiliar).

verifySimpleWhiteMove(TipoJogo, STATUS_CONECTION, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	(STATUS_CONECTION \= 0, verifyWhiteNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard); true),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonBlack(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceX(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

verifySimpleBlackMove(TipoJogo, STATUS_CONECTION, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	(STATUS_CONECTION \= 0, verifyBlackNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard); true),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonWhite(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceO(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

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
