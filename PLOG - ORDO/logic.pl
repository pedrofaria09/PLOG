:-consult(auxiliar).

verifySimpleWhiteMove(NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	verifyWhiteNonBackMove(NewY, OldY, NumeroJogada, AtualBoard),
	verifyElementNonNone(OldElement, NumeroJogada, AtualBoard),
	verifyElementNonBlack(OldElement, NumeroJogada, AtualBoard),
	verifyPieceX(NewElement, NumeroJogada, AtualBoard, NewElement2).

verifySimpleBlackMove(NewElement, OldElement, NumeroJogada, AtualBoard, NewElement2, OldY, NewY) :-
	verifyBlackNonBackMove(NewY, OldY, NumeroJogada, AtualBoard),
	verifyElementNonNone(OldElement, NumeroJogada, AtualBoard),
	verifyElementNonWhite(OldElement, NumeroJogada, AtualBoard),
	verifyPieceO(NewElement, NumeroJogada, AtualBoard, NewElement2).

verifyElementNonBlack(Element,NumeroJogada,AtualBoard):- (Element == 'x' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

verifyElementNonWhite(Element,NumeroJogada,AtualBoard):- (Element == 'o' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

verifyElementNonNone(Element,NumeroJogada,AtualBoard):- (Element == 'none' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher uma peca vazia! Joga novamente'), nl, jogada(NumeroJogada,AtualBoard)); true).

verifyPieceX(NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,AtualBoard)); NewElement2 = 'none').

verifyPieceO(NewElement, NumeroJogada, AtualBoard, NewElement2):- ((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,AtualBoard)); NewElement2 = 'none').

verifyBlackNonBackMove(NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY < OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,AtualBoard); true).

verifyWhiteNonBackMove(NewY,OldY , NumeroJogada, AtualBoard) :- ((NewY > OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,AtualBoard); true).
