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

menu_options(1) :-	jogar.
menu_options(2) :-	menu_mode.
menu_options(3) :- break,!.
menu_options(Other) :- nl,
	write('Introduza numero valido'),
	nl,
	menu_option.

mode_options(1) :- jogar.
mode_options(2) :- jogar(1).
mode_options(3) :- jogar(2).


gameArea(X) :- nl,
	board(L1),
	contaListaDeLista(o,L1,NrBrancas),
	contaListaDeLista(x,L1,NrPretas),
	dados_jogo(X, NrBrancas, NrPretas), nl,
	display_primeira("A","J"), nl,
	test(i).

askPlay :-	askPlay(1).

askPlay(1) :- write('Digite a coluna (letra) da peca a mover'), nl,
	getChar(ColunaToMove),
	letra(ColunaToMove,1),
	askPlay(2).

askPlay(2) :- write('Digite a linha (numero) da peca a mover'), nl,
	getDigit(LinhaToMove),
	numero(LinhaToMove,2),
	askPlay(3).

askPlay(3) :- write('Digite a coluna (letra) do destino'), nl,
	getChar(ColunaDestino),
	letra(ColunaDestino,3),
	askPlay(4).

askPlay(4) :- write('Digite a linha (numero) do destino'), nl,
	getDigit(LinhaDestino),
	numero(LinhaDestino,4).

jogar :- cls, nl,
	write('Jogador vs Jogador'), nl,
	jogada(1).

jogar(1) :- cls, nl,
	write('Jogador vs Computador'), nl,
	jogada(1).
	
jogar(2) :- cls, nl,
	write('Computador vs Computador'), nl,
	jogada(1).
	
jogada(1) :- gameArea(1),
	write('-> Jogam as brancas - (O)'), nl,
	askPlay,
	jogada(X+1).

jogada(X) :- par(X), cls
,
	gameArea(X),
	write('->Jogam as pretas - (X)'), nl,
	askPlay,
	jogada(X+1).

jogada(X) :- impar(X), cls,
	gameArea(X),
	write('-> Jogam as brancas - (O)'), nl,
	askPlay,
	jogada(X+1).


dados_jogo(Jogada, Numero_brancas, Numero_pretas) :-
	format('Jogada numero: ~d', [Jogada]), nl,
	format('Brancas: ~w', [Numero_brancas]), nl,
	format('Pretas: ~w', [Numero_pretas]), nl.

simpleMove(player, piece, newPosition).
ordoMove(player, pieces, newPositions).
