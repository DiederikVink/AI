

/* State change rules */
statechange( farmer, (B,W,G,C), (O,W,G,C) ) :-
	opposite(B,O), opposite(W,G), opposite(G,C).
statechange( wolf, (B,B,G,C), (O,O,G,C) ) :-
	opposite(B,O), opposite(G,C).
statechange( goat, (B,W,B,C), (O,W,O,C) ) :-
	opposite(B,O).
statechange( cabbage, (B,W,G,B), (O,W,G,O) ) :-
	opposite(B,O), opposite(W,G).

opposite( l, r ).
opposite( r, l ).

/* Access predicates */
make_node( Rule, State, _, (Rule,State) ).

state_of( (_,State), State ).

/* Loop checking for depth first */
loop_check( _, [] ).
loop_check( State, [H|T] ) :-
	state_of( H, AState ),
	State \= AState,
	loop_check( State, T ).

choose( Path, [Path|Paths], Paths ).

add_to_paths( NP, OP, AllP ) :-
	append( NP, OP, AllP ).

one_step_extensions( [Node|Path], NewPaths ) :-
	state_of( Node, State ),
	findall( [NewNode,Node|Path],
		 ( statechange( Rule, State, NewState ),
		   loop_check( NewState, [Node|Path] ),
		   make_node( Rule, NewState, _, NewNode ) ),
		 NewPaths ).


/* Goal State */
goal_state( (r,r,r,r) ).


/* General Graph Search Engine */
search( Paths, SolnPath ) :-
	choose( Path, Paths, OtherPaths ),
	one_step_extensions( Path, NewPaths ),
	add_to_paths( NewPaths, OtherPaths, AllPaths ),
	search( AllPaths, SolnPath ).

search( Paths, [Node|Path] ) :-
	choose( [Node|Path], Paths, _ ),
	state_of( Node, State ),
	goal_state( State ).
	
/* Initial state and query */
/* search( [[(is,(l,l,l,l))]], SolnPath ). */