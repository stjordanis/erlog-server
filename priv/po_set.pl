/* -*-Prolog -*- */



edge(a,b).
edge(a,c).
edge(c,d).
edge(b,e).
edge(d,f).
edge(b,f).
%--------------------------------------------------------------------------------
erl_export(path/3,     return, last).
erl_export(add_edge/2, return, none).
erl_export(sib/2,      return, none).
import("deps/erlog/src/erlog_int.hrl").
add_edge(A,B) :-
	asserta(edge(A,B)).


%--------------------------------------------------------------------------------
connected(A,B) :-
	edge(A,B).

child(A) :-
	\+edge(A,_).

sib(A,B) :-
	path(C,A,_),
	path(C,B,_),
	\+path(A,B,_),
	\+path(B,A,_).

ancestor(A,B) :-
	path(A,B,_).

descendent(A,B) :-
	path(B,A,_).

path(A,B,Path) :-
       travel(A,B,[A],Q), 
       reverse(Q,Path).

travel(A,B,P,[B|P]) :- 
       connected(A,B).
travel(A,B,Visited,Path) :-
       connected(A,C),           
       C \== B,
       \+member(C,Visited),
       travel(C,B,[C|Visited],Path). 


