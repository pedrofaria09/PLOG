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

test(i) :- display_board(1,
	[[none, none, x, x, none, none, x, x, none, none],
	[x, x, x, x, x, x, x, x, x, x],
	[x, x, none, none, x, x, none, none, x, x],
	[none, none, none, none, none, none, none, none, none, none],
	[none, none, none, none, none, none, none, none, none, none],
	[o, o, none, none, o, o, none, none, o, o],
	[o, o, o, o, o, o, o, o, o, o],
	[none, none, o, o, none, none, o, o, none, none]]).

test(m) :- display_board(1,
	[[none, none, none, none, none, none, none, none, none, none],
	[none, x, x, none, x, x, none, x, x, x],
	[x, x, x, x, x, x, x, x, x, x],
	[x, none, none, x, none, none, x, none, none, none],
	[none, none, none, none, o, none, none, none, none, none],
	[o, o, none, o, none, o, none, o, o, o],
	[o, o, o, o, o, o, o, o, o, o],
	[none, none, o, none, none, none, none, o, none, none]]).

test(f) :- display_board(1,
	[[none, o, none, none, none, none, none, none, none, none],
	[none, o, o, none, none, none, none, none, none, none],
	[o, o, none, none, x, none, none, none, none, none],
	[none, none, x, x, none, none, none, none, none, none],
	[none, none, x, none, none, none, none, none, none, none],
	[none, none, x, none, none, none, none, none, none, none],
	[none, none, none, none, none, none, none, none, none, none],
	[none, none, none, none, none, none, none, none, none, none]]).

display_board(X,[L2|L2s]) :- write(X), Y is X+1, write('- '), display_line(L2), nl, display_line__(L2), nl, display_board(Y,L2s).
display_board(_,[]) :- nl.

display_line([E|Es]) :- translate(E,V), write(V), write(' | '), display_line(Es).
display_line([]):- !.

display_line__([_|Es]) :- write(' - -'), display_line__(Es).
display_line__([]):- !.


translate(none,' ').
translate(x,'X').
translate(o,'O').
