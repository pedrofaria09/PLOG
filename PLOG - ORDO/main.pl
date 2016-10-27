:-consult(auxiliar).
:-consult(display).
:-use_module(library(lists)).



main :-
	cls,
	write(' ---------------------------- '), nl,
	write('|                            |'), nl,
	write('|            O D             |'), nl,
	write('|             R O            |'), nl,
	write('|                            |'), nl,
	write('|----------------------------|'), nl,
	write('|         1 - Jogar          |'), nl,
	write('|                            |'), nl,
	write(' ---------------------------- '), nl,
	write('Escrever o numero da escolha seguida de um ponto'), nl,
	read(Input),
	!,
	menu_options(Input).

menu_options(1) :-	jogar.

gameArea(X) :- nl,
	board(L1),
	contaListaDeLista(o,L1,NrBrancas),
	contaListaDeLista(x,L1,NrPretas),
	dados_jogo(X, NrBrancas, NrPretas), nl,
	display_primeira("A","J"), nl,
	test(i).

askPlay :-	askPlay(1).

askPlay(1) :- write('Digite a coluna (letra) da peca a mover'), nl,
	read(ColunaToMove),
	letra(ColunaToMove,1),
	askPlay(2).

askPlay(2) :- write('Digite a linha (numero) da peca a mover'), nl,
	read(LinhaToMove),
	numero(LinhaToMove,2),
	askPlay(3).

askPlay(3) :- write('Digite a coluna (letra) do destino'), nl,
	read(ColunaDestino),
	letra(ColunaDestino,3),
	askPlay(4).

askPlay(4) :- write('Digite a linha (numero) do destino'), nl,
	read(LinhaDestino),
	numero(LinhaDestino,4).

jogar :- cls,
	jogar(1).

jogar(X) :- par(X), cls,
	gameArea(X),
	write('->Jogam as pretas - (X)'), nl,
	askPlay,
	jogar(X+1).

jogar(X) :- impar(X), cls,
	gameArea(X),
	write('-> Jogam as brancas - (O)'), nl,
	askPlay,
	jogar(X+1).


dados_jogo(Jogada, Numero_brancas, Numero_pretas) :-
	format('Jogada numero: ~d', [Jogada]), nl,
	format('Brancas: ~w', [Numero_brancas]), nl,
	format('Pretas: ~w', [Numero_pretas]), nl.

simpleMove(player, piece, newPosition).
ordoMove(player, pieces, newPositions).
