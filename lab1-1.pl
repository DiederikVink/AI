%

father(homer,bart).
father(homer,lisa).
father(homer,maggie).
father(baller,homer).
mother(marge,bart).
mother(marge,lisa).
mother(marge,maggie).
mother(balleress,marge).
married(homer,marge).
male(homer).
male(bart).
female(marge).
female(lisa).
female(maggie).

parent(Parent):-
    father(Parent,Child).
parent(Parent):-
    mother(Parent,Child).

grandfather(GParent):-
    parent(Parent),
    father(GParent,Parent).
grandmother(GParent):-
    parent(Parent),
    mother(GParent,Parent).
grandparent(GParent):-
    grandmother(GParent).
grandparent(GParent):-
    grandfather(GParent).

brother(Person,Brother):-
    father(Father,Person),
    father(Father,Brother).
    male(Brother).
brother(Person,Brother):-
    mother(Mother,Person),
    mother(Mother,Brother),
    male(Brother).

sister(Person,Sister):-
    father(Father,Person),
    father(Father,Sister),
    female(Sister).
sister(Person,Sister):-
    mother(Mother,Person),
    mother(Mother,Sister),
    female(Sister).



run(Person):-
    brother(Lisa,Person).
