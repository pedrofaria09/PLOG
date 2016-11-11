:-consult(auxiliar).

verifySimpleWhiteMove(TipoJogo, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	verifyWhiteNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonBlack(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceX(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

verifySimpleBlackMove(TipoJogo, NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	verifyBlackNonBackMove(TipoJogo, NewY, OldY, NumeroJogada, AtualBoard),
	verifyElementNonNone(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyElementNonWhite(TipoJogo, OldElement, NumeroJogada, AtualBoard),
	verifyPieceO(TipoJogo, NewElement, NumeroJogada, AtualBoard, NewElement2).

%  Jogador

verifyElementNonBlack(1, Element,NumeroJogada,AtualBoard):- (Element == 'x' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

% Computador

verifyElementNonBlack(2, Element,NumeroJogada,AtualBoard):- (Element == 'x' -> (jogadorvscomputador(NumeroJogada,AtualBoard), break); true).

verifyElementNonBlack(3, Element,NumeroJogada,AtualBoard):- (Element == 'x' -> (computadorvscomputador(NumeroJogada,AtualBoard), break); true).
	
%  Jogador
verifyElementNonWhite(1, Element,NumeroJogada,AtualBoard):- (Element == 'o' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

%  Computador
verifyElementNonWhite(2, Element,NumeroJogada,AtualBoard):- (Element == 'o' -> (jogadorvscomputador(NumeroJogada,AtualBoard), break); true).

verifyElementNonWhite(3, Element,NumeroJogada,AtualBoard):- (Element == 'o' -> (computadorvscomputador(NumeroJogada,AtualBoard), break); true).
	
%  Jogador	
verifyElementNonNone(1, Element,NumeroJogada,AtualBoard):- (Element == 'none' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher uma peca vazia! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

%  Computador
verifyElementNonNone(2, Element,NumeroJogada,AtualBoard):- (Element == 'none' -> (jogadorvscomputador(NumeroJogada,AtualBoard), break); true).
	
verifyElementNonNone(3, Element,NumeroJogada,AtualBoard):- (Element == 'none' -> (computadorvscomputador(NumeroJogada,AtualBoard), break); true).

%  Jogador	
verifyPieceX(1, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,AtualBoard)); NewElement2 = 'none').

%  Computador
verifyPieceX(2, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> jogadorvscomputador(NumeroJogada,AtualBoard), break); NewElement2 = 'none').

verifyPieceX(3, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> computadorvscomputador(NumeroJogada,AtualBoard), break); NewElement2 = 'none').
 
%  Jogador
verifyPieceO(1, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,AtualBoard)); NewElement2 = 'none').

%  Computador
verifyPieceO(2, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> jogadorvscomputador(NumeroJogada,AtualBoard), break); NewElement2 = 'none').

verifyPieceO(3, NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> computadorvscomputador(NumeroJogada,AtualBoard), break); NewElement2 = 'none').

%  Jogador 
verifyBlackNonBackMove(1, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY < OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,AtualBoard); true).

%  Computador
verifyBlackNonBackMove(2, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY < OldY) -> jogadorvscomputador(NumeroJogada,AtualBoard), break; true).

verifyBlackNonBackMove(3, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY < OldY) -> computadorvscomputador(NumeroJogada,AtualBoard), break; true).

%  Jogador
verifyWhiteNonBackMove(1, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY > OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,AtualBoard); true).

%  Computador
verifyWhiteNonBackMove(2, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY > OldY) -> jogadorvscomputador(NumeroJogada,AtualBoard), break; true).

verifyWhiteNonBackMove(3, NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY > OldY) -> computadorvscomputador(NumeroJogada,AtualBoard), break; true).
