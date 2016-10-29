:-consult(auxiliar).

verifySimpleWhiteMove(NewElement,OldElement, NumeroJogada, L1,NewElement2, OldY, NewY) :- verifyWhiteNonBackMove(NewY, OldY, NumeroJogada, L1),
	verifyElementNonNone(OldElement,NumeroJogada,L1),
	verifyElementNonBlack(OldElement,NumeroJogada,L1),
	verifyPieceX(NewElement, NumeroJogada, L1, NewElement2).
	
verifySimpleBlackMove(NewElement,OldElement, NumeroJogada, L1,NewElement2, OldY, NewY) :- 	verifyBlackNonBackMove(NewY, OldY, NumeroJogada, L1),
	verifyElementNonNone(OldElement,NumeroJogada,L1),
	verifyElementNonWhite(OldElement,NumeroJogada,L1),
	verifyPieceO(NewElement, NumeroJogada, L1, NewElement2).

verifyElementNonBlack(Element,NumeroJogada,L1):- (Element == 'x' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,L1)); true).
	
verifyElementNonWhite(Element,NumeroJogada,L1):- (Element == 'o' -> (nl, nl, write('AVISO!!!'), nl,
	write('Nao podes escolher a peca de um oponente! Joga novamente'), nl, jogada(NumeroJogada,L1)); true).
	
verifyElementNonNone(Element,NumeroJogada,L1):- (Element == 'none' -> (nl, nl, write('AVISO!!!'), nl,
	write('Não podes escolher uma peca vazia! Joga novamente'), nl, jogada(NumeroJogada,L1)); true).

verifyPieceX(NewElement, NumeroJogada, L1, NewElement2):- ((NewElement == 'x' -> NewElement2 = 'none');
  (NewElement == 'o' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,L1)); NewElement2 = 'none').
  
verifyPieceO(NewElement, NumeroJogada, L1, NewElement2):- ((NewElement == 'o' -> NewElement2 = 'none');
  (NewElement == 'x' -> nl, nl, write('AVISO!!!'), nl, write('Nao podes escolher a tua peca como destino! Joga novamente'), jogada(NumeroJogada,L1)); NewElement2 = 'none').

verifyBlackNonBackMove(NewY,OldY , NumeroJogada, L1) :- ((NewY < OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,L1); true).

verifyWhiteNonBackMove(NewY,OldY , NumeroJogada, L1) :- ((NewY > OldY) -> nl, nl, write('Nao podes andar para tras! '), jogada(NumeroJogada,L1); true).