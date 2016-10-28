:-consult(auxiliar).
:-consult(display).
:-use_module(library(lists)).


menu :-
	cls,
	write('   --------------------------------------- '), nl,
	write('  |                                       |'), nl,
	write('  |                                       |'), nl,
	write('  |                  O D                  |'), nl,
	write('  |                   R O                 |'), nl,
	write('  |                                       |'), nl,
	write('  |                                       |'), nl,
	write('  |---------------------------------------|'), nl,
	write('  |                                       |'), nl,
	write('  |             1 - Jogar                 |'), nl,
	write('  |             2 - Modo                  |'), nl,
	write('  |             3 - Sair                  |'), nl,
	write('  |                                       |'), nl,
	write('   --------------------------------------- '), nl,
	nl, nl,
	menu_option.

menu_mode :-
	cls,
	write('   --------------------------------------- '), nl,
	write('  |                                       |'), nl,
	write('  |                                       |'), nl,
	write('  |                  O D                  |'), nl,
	write('  |                   R O                 |'), nl,
	write('  |                                       |'), nl,
	write('  |                                       |'), nl,
	write('  |---------------------------------------|'), nl,
	write('  |                                       |'), nl,
	write('  |       1 - Jogador vs Jogador          |'), nl,
	write('  |       2 - Jogador vs Computador       |'), nl,
	write('  |       3 - Computador vs Computador    |'), nl,
	write('  |                                       |'), nl,
	write('   --------------------------------------- '), nl,
	nl, nl,
	mode.

menu_option :- write('Escrever o numero da escolha'), nl,
	getDigit(Input),
	!,
	menu_options(Input).

mode :- write('Escrever o numero da escolha'), nl,
	getDigit(Input),
	!,
	mode_options(Input).

menu_options(1) :- board(L1),jogar(L1).
menu_options(2) :- menu_mode.
menu_options(3) :- break,!.
menu_options(_) :- nl,
	write('Introduza numero valido'),
	nl,
	menu_option.

mode_options(1) :- jogar.
mode_options(2) :- jogar(1).
mode_options(3) :- jogar(2).


gameArea(X,L1) :- nl,
	contaListaDeLista(o,L1,NrBrancas),
	contaListaDeLista(x,L1,NrPretas),
	dados_jogo(X, NrBrancas, NrPretas), nl,
	display_primeira("A","J"), nl,
	display_board(1,L1).

askPlay(ColunaToMove, LinhaToMove, ColunaDestino, LinhaDestino, X, L1) :-
	write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(ColunaToMove, X, L1),
	write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(LinhaToMove, X, L1),
 	write('Digite a coluna (letra) do destino'), nl,
	getChar(ColunaDestino),
	letra(ColunaDestino, X, L1),
 	write('Digite a linha (numero) do destino'), nl,
	getDigit(LinhaDestino),
	numero(LinhaDestino, X, L1).

jogar(L1) :- cls, nl,
	write('Jogador vs Jogador'), nl,
	jogada(1,L1).

jogar(1) :- cls, nl,
	write('Jogador vs Computador'), nl,
	jogada(1).

jogar(2) :- cls, nl,
	write('Computador vs Computador'), nl,
	jogada(1).

jogada(X,L1) :- par(X),
	gameArea(X, L1),
	write('-> Jogam as Pretas - (X)'), nl,
	askPlay(OldX, OldY, NewX, NewY, X, L1),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	verifyElementNone(OldElement,X,L1),
	verifyElementO(OldElement,X,L1),
	getElement(L1, NewY, NewXNumber, NewElement),
	changeBoard(NewElement, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2,NewXNumber,NewY, OldElement),
	Y is X+1,
	jogada(Y,NewBoard2).

jogada(X,L1) :- impar(X),
	gameArea(X, L1),
	write('-> Jogam as brancas - (O)'), nl,
	askPlay(OldX, OldY, NewX, NewY, X, L1),
	letterToNumber(OldX, OldXNumber),
	letterToNumber(NewX, NewXNumber),
	getElement(L1, OldY, OldXNumber, OldElement),
	verifyElementNone(OldElement,X,L1),
	verifyElementX(OldElement,X,L1),
	getElement(L1, NewY, NewXNumber, NewElement),
	changeBoard(NewElement, OldXNumber, OldY, L1, NewBoard1),
	changeBoard(OldElement, NewXNumber, NewY, NewBoard1, NewBoard2),
	connected(NewBoard2,NewXNumber,NewY, OldElement),
	Y is X+1,
	jogada(Y, NewBoard2).


dados_jogo(Jogada, Numero_brancas, Numero_pretas) :-
	format('Jogada numero: ~d', [Jogada]), nl,
	format('Brancas: ~w', [Numero_brancas]), nl,
	format('Pretas: ~w', [Numero_pretas]), nl.

simpleMove(player, piece, newPosition).
ordoMove(player, pieces, newPositions).
