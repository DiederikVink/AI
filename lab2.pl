%

/*State change rules */
statechange(fill7,(_,B),(7,B)).
statechange(fill5,(A,_),(A,5)).
statechange(empty7,(_,B),(0,B)).
statechange(empty5,(A,_),(A,0)).
statechange(pour7,(A,B),(0,C)):-
    C is A+B,
    C=<5.
statechange(pour7,(A,B),(C,5)):-
    C is A+B-5,
    C>0.
statechange(pour5,(A,B),(C,0)):-
    C is A+B,
    C=<7.
statechange(pour5,(A,B),(7,C)):-
    C is A+B-7,
    C>0.

/* Access predicates */
make_node(Rule,State,_,(Rule,State)).

state_of((_,State),State).

/*Loop checking for depth first */
loop_check(_,[]).
loop_check(State,[H|T]):-
    state_of(H,AState),
    State \= AState,
    loop_check(State,T).

choose([Path|Paths],Path,Paths).

add_to_paths(NP,OP,AllP):-
    append(NP,OP,AllP).

one_step_extensions([Node|Path],NewPaths):-
    state_of(Node,State),
    findall(
        [NewNode,Node|Path],
        (
            statechange(Rule,State,NewState),
            loop_check(NewState,[Node|Path]),
            make_node(Rule,NewState,_,NewNode)
        ),
        NewPaths
    ).

/* Goal State */
goal_state((4,0)).

/* General Graph Search Engine */
search(Paths[Node|Path]):-
    choose(Paths,[Node|Path],_),
    state_of(Node,State),
    goal_state(State).
search(Paths,SolnPath):-
    choose(Paths, Path, OtherPaths),
    one_step_extensions(Path, Newpaths),
    add_to_paths(NewPaths, OtherPaths, AllPaths),
    search(AllPaths,SolnPath).
