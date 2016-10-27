
% Return element by index (Row,col)
index(Matrix, Row, Col, Value):-
  nth1(Row, Matrix, MatrixRow),
  nth1(Col, MatrixRow, Value).


% Change content of the board
changeTo(_,[],[],_,_).
changeTo(ElemToChange,[[_|Xs]|Ys],[[ElemToChange|Xs1]|Ys1],1,1) :-
                    !,changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],0,0).

changeTo(ElemToChange,[[X]|Xs],[[X]|Xs1],0,0) :-
                    changeTo(ElemToChange,Xs,Xs1,0,0),!.

changeTo(ElemToChange,[[X|Xs]|Ys],[[X|Xs1]|Ys1],0,0) :-
                    changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],0,0).

changeTo(ElemToChange,[[X|Xs]|Ys],[[X|Xs1]|Ys1],N,1) :-
                    N1 is N-1,
                    changeTo(ElemToChange,[Xs|Ys],[Xs1|Ys1],N1,1).

changeTo(ElemToChange,[Xs|Ys],[Xs|Ys1],N,M) :-
                    M1 is M-1,
                    changeTo(ElemToChange,Ys,Ys1,N,M1),!.

changeBoard(ElemToChange,X,Y,Board,NewBoard) :-
                    changeTo(ElemToChange,Board,NewBoard,X,Y).



board2([none, none, x, x, none, none, x, x, none, none]).

% Count an element - ONLY LIST!!! NOT LIST OF LIST!!!
conta1Lista(Valor, [H|T], NrVezes) :-
  (H == Valor -> (Y is NrVezes + 1, conta1Lista(Valor, T, Y)); conta1Lista(Valor, T, NrVezes)).
conta1Lista(_,[],NrVezes) :- write(NrVezes).

% Count an element - LIST OF LIST!!!!
contaListaDeLista(_,[],0).
contaListaDeLista(Valor, [H|T], NrVezes) :-
  contaLista(Valor, H, T, NrVezes).
contaLista(Valor, [H|T], L2, NrVezes):-
  (Valor == H -> (contaLista(Valor, T, L2, Y), NrVezes is Y + 1); contaLista(Valor, T, L2, NrVezes)).
contaLista(Valor,[], L2, NrVezes) :- contaListaDeLista(Valor, L2, NrVezes).

test2 :-
  board(L1),
  contaListaDeLista(x,L1,NrVezes), write(NrVezes), nl,
  test(i).

% Display First Line in a 'dynamic' way
display_primeira(Inicio, Fim):-
  write('   '), Y is Inicio + 0, Inicio =< Fim, char_code(Imprime, Y), write(Imprime), X is Y +1, display_primeira(X, Fim).
display_primeira(_, _).


% Verifica se Input � entre A-J
letra(X,_) :- X = 'a'; X = 'b'; X = 'c'; X = 'd'; X = 'e';
X = 'f';  X = 'g';  X = 'h'; X = 'i';  X = 'j'.

letra(_,Y) :- nl,
write('Valor invalido!'), nl, nl, askPlay(Y).

% Verifica se Input � entre 1-8
numero(X,_) :- integer(X), X >= 1,  X =< 8.

numero(_,Y) :- nl,
write('Valor invalido!'), nl, nl, askPlay(Y).



% Verifica se um n�mero � par ou �mpar
par(N):- N mod 2 =:= 0.
impar(N):- N mod 2 =:= 1.

getNewLine :- 
        get_code(T) , (T == 10 -> ! ; getNewLine).

getDigit(D) :- 
        get_code(Dt) , D is Dt - 48 , (Dt == 10 -> ! ; getNewLine).
		
getChar(C) :- 
        get_char(C) , char_code(C, Co) , (Co == 10 -> ! ; getNewLine).
		
% Limpa o terminal
cls :- write('\e[2J').
