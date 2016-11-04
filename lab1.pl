%
head([H|_],H).

last([L],L):-!.
last([_,T],L):-
    last(T,L).

middle([_|T],M):-
    no_last(T,M).
no_last([L],[]):-!.
no_last([H|T],[H|M]):-
    no_last(T,M).


is_member([Goal|_], Goal):-!.
is_member([_|List],Goal):-
    is_member(List,Goal).

%append_list([],[],[]).
append_list([],Second,Second).
append_list([H|First],Second,[H|List]):-
    append_list(First,Second,List).


reverse([],[]).
reverse([H|List], Reverse):-
    reverse(List, NReverse),
    append_list(NReverse, [H], Reverse).

reverse_alt([],[]).
reverse_alt([H|List],Reverse):-
    append_list(NReverse, [H], Reverse),
    reverse_alt(List,NReverse).

reverse_three([],List,List).
reverse_three([H|First], List, Output):-
    reverse_three(First, [H|List], Output).

delete_element([Goal|Tail], Goal, Tail):-!.
delete_element([Head|Tail], Goal, [Head|Output]):-
    delete_element(Tail, Goal, Output).

delete_all([], Goal, []).
delete_all([Goal|Tail], Goal, Output):-
    delete_all(Tail, Goal, Output).
delete_all([Head|Tail], Goal, [Head|Output]):-
    delete_all(Tail, Goal, Output).

replace([], Goal, Replace, []).
replace([Goal|Tail], Goal, Replace, [Replace|Output]):-
    replace(Tail, Goal, Replace, Output).
replace([Head|Tail], Goal, Replace, [Head|Output]):-
    replace(Tail, Goal, Replace, Output).

sub_list(List,[]):-!.
sub_list([],[]).
sub_list(List, Sublist):-
    format("1) List: ~w \n1) Sublist: ~w \n", [List, Sublist]),
    sub_test(List, Sublist, List, Sublist).
sub_test(LTemp,[],List,Sublist):-!.
sub_test([],[],List,Sublist).
sub_test([Head|LTemp], [Head|STemp], List, Sublist):-
    format("2) LTemp: ~w \n2) STemp: ~w \n", [LTemp, STemp]),
    sub_test(LTemp, STemp, List, Sublist).
sub_test([Head|LTemp], [OHead|STemp], [H|List], Sublist):-
    sub_list(List, Sublist).

sieve([],Value,[]).
sieve([Head|List],Value,[Head|OutList]):-
    Head>=Value,
    sieve(List,Value,OutList).
sieve([Head|List],Value,OutList):-
    sieve(List,Value,OutList).
    
partition([],Size,Size,[],[]):-!.
partition(List,Size,CurPos,List1,List2):-
    CurPos=0,
    size(List,Size1),
    %format("Size: ~w\n", Size1),
    CurPos1 is CurPos+1,
    partition(List,Size1,CurPos1,List1,List2).
partition([Head|List],Size,CurPos,[Head|List1],List2):-
    CurPos<Size/2,
    CurPos1 is CurPos+1,
    %format("Head: ~w\nList: ~w\n", [Head,List]),
    partition(List,Size,CurPos1,List1,List2).
partition([Head|List],Size,CurPos,List1,[Head|List2]):-
    CurPos>=Size/2,
    %format("Head: ~w\nList: ~w\n", [Head,List]),
    CurPos1 is CurPos+1,
    partition(List,Size,CurPos1,List1,List2).
size([],1).
size([Head|List],Size):-
    size(List,Size1),
    Size is Size1+1.

partition_alt(List,Size,Size,[],List):-!.
partition_alt([Head|List],Size,CurPos,[Head|List1],List2):-
    CurPos<Size,
    CurPos1 is CurPos+1,
    format("Head: ~w\nList: ~w\n", [Head,List]),
    partition_alt(List,Size,CurPos1,List1,List2).

partition_half(List, A, B) :-
    length(A, N),
    length(B, N),
    append(A, B, List).

partition_qs([],Target,[],[]).
partition_qs([Head|List],Target,[Head|List1],List2):-
    Head=<Target,
    %format("Head: ~w\nList: ~w\n", [Head,List]),
    partition_qs(List,Target,List1,List2).
partition_qs([Head|List],Target,List1,[Head|List2]):-
    Head>Target,
    %format("Head: ~w\nList: ~w\n", [Head,List]),
    partition_qs(List,Target,List1,List2).

quicksort([B|[]],[B]).
quicksort([],[]).
quicksort([Head|List],OutList):-
    partition_qs(List,Head,List1,List2),
    append_list(List2,[Head],List2App),
    quicksort(List1,Out1),
    quicksort(List2App,Out2),
    append_list(Out1,Out2,OutList).

quickersort([],Acc,Acc).
quickersort([Head|List],Acc,OutList):-
    partition_qs(List,Head,List1,List2),
    quickersort(List2,Acc,Out1),
    quickersort(List1,[Head|Out1],OutList).

subset([],Super):-!.
subset([H|Sub],[H|Super]):-
    subset(Sub,Super).
subset([O|Sub],[H|Super]):-
    subset([O|Sub],Super).
    
intersection([],List2,[]):-!.
intersection([H|List1],List2,[H|OutList]):-
    is_member(List2,H),
    delete_all(List1,H,List1New),
    intersection(List1New,List2,OutList).
intersection([H|List1],List2,OutList):-
    delete_all(List1,H,List1New),
    intersection(List1New,List2,OutList).
    
union([],List2,List2):-!.
union([O|List1],List2,[H|OutList]):-
    delete_all(List1,H,List1New),
    delete_all(List2,H,List2New),
    union(List1New,List2New,OutList).

    

run(List):-
    %partition_alt([0,1,2,3,4,5,6],5,0,List1,List2).
    %partition_qs([5,1,6,5,3,4,2,87],4,List1,List2).
    %partition_half([1,5,3,4,9,10],List1,List2).
    %quickersort([1,2,2,2,8,3,2],[],List).
    intersection([1,2,3,4],[3,2],List).
