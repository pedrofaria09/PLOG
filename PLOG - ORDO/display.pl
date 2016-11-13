%=======================%
% Menu, GameArea Display
%=======================%


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
menu_options(3) :- break.
menu_options(_) :- nl,
	write('Introduza numero valido'),
	nl,
	menu_option.

mode_options(1) :- board(L1),jogar(L1).
mode_options(2) :- board(L1),jogar(1, L1).
mode_options(3) :- board(L1),jogar(2, L1).


gameArea(X,L1) :- nl,
	contaListaDeLista(o,L1,NrBrancas),
	contaListaDeLista(x,L1,NrPretas),
	gameData(X, NrBrancas, NrPretas), nl,
	display_primeira("A","J"), nl,
	display_board(1,L1).

finalgameArea(L1) :- nl,
	display_primeira("A","J"), nl,
	display_board(1,L1), nl.


jogar(L1) :- cls, nl,
	write('Jogador vs Jogador'), nl,
	jogada(1,L1).

jogar(1, L1) :- cls, nl,
	write('Jogador vs Computador'), nl,
	jogadorvscomputador(1, L1).

jogar(2, L1) :- cls, nl,
	write('Computador vs Computador'), nl,
	computadorvscomputador(1, L1).

gameData(Jogada, Numero_brancas, Numero_pretas) :-
	par(Jogada),
	write('-> Jogam as Pretas - (X)'), nl,
	format('Jogada numero: ~d', [Jogada]), nl,
	format('Brancas: ~w', [Numero_brancas]), nl,
	format('Pretas: ~w', [Numero_pretas]), nl.

gameData(Jogada, Numero_brancas, Numero_pretas) :-
	impar(Jogada),
	write('-> Jogam as brancas - (O)'), nl,
	format('Jogada numero: ~d', [Jogada]), nl,
	format('Brancas: ~w', [Numero_brancas]), nl,
	format('Pretas: ~w', [Numero_pretas]), nl.

warningNotConnected(1) :- nl,nl,write('AVISO!!! - TENS DE CONECTAR-TE NESTA JOGADA!!!'), nl,nl,nl.

writePositionInformation(OldXNumber, OldY, NewXNumber, NewY):-
	format('Posicao anterior (X-Y): ~d-~d', [OldXNumber, OldY]), nl,
	format('Nova Posicao (X-Y): ~d-~d', [NewXNumber, NewY]), nl,nl,nl.
%=======================%
% Board display
%=======================%

board([[none, none, x, x, none, none, x, x, none, none],
	[x, x, x, x, x, x, x, x, x, x],
	[x, x, none, none, x, x, none, none, x, x],
	[none, none, none, none, none, none, none, none, none, none],
	[none, none, none, none, none, none, none, none, none, none],
	[o, o, none, none, o, o, none, none, o, o],
	[o, o, o, o, o, o, o, o, o, o],
	[none, none, o, o, none, none, o, o, none, none]]).

display_board(X,[L2|L2s]) :- write(X), Y is X+1, write('- '), display_line(L2), nl, display_line__(L2), nl, display_board(Y,L2s).
display_board(_,[]) :- nl.

display_line([E|Es]) :- translate(E,V), write(V), write(' | '), display_line(Es).
display_line([]):- !.

display_line__([_|Es]) :- write(' - -'), display_line__(Es).
display_line__([]):- !.


translate(none,' ').
translate(x,'X').
translate(o,'O').
