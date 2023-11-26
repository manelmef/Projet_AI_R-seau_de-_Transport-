
/***************************************************les deffirentes lignes***************************************************/


ligne(2, metro, [
		 [nation, 0],
		 [avron, 1],
		 [alexandre_dumas,2],
		 [philippe_auguste,1],
		 [pere_lachaise,2],
		 [menilmontant,2],
		 [couronnes,1],
		 [belleville,2],
		 [colonel_fabien,1],
		 [jaures,1],
		 [stalingrad,2],
		 [la_chapelle,1],
		 [barbes_rochechouart,3],
		 [anvers,2],
		 [pigalle,1],
		 [blanche,2],
		 [place_clichy,3],
		 [rome,2],
		 [villiers,3],
		 [monceau,2],
		 [courcelles,2],
		 [ternes,3],
		 [charles_de_gaulle_etoile,3],
		 [victor_hugo,2],
		 [porte_dauphine,3]
		 ], [[5,0],2,[1,45]], [[5,15],2,[1,55]]
).

ligne(3, metro, [
		 [pont_levallois_becon,0],
		 [anatole_france,2],
		 [louise_michel,3],
		 [porte_de_champerret,2],
		 [pereire,2],
		 [wagram,2],
		 [malesherbes,3],
		 [villiers,2],
		 [europe,3],
		 [saint_lazare,4],
		 [havre_caumartin,2],
		 [opera,3],
		 [quatre_septembre,3],
		 [bourse,2],
		 [sentier,3],
		 [reaumur_sebastopol,3],
		 [arts_metiers,3],
		 [temple,2],
		 [republique,3],
		 [parmentier,2],
		 [rue_saint_maur,3],
		 [pere_lachaise,4],
		 [gambetta,2],
		 [porte_de_bagnolet,3],
		 [gallieni,3]
		 ], [[5,35],4,[0,20]], [[5,30],4,[0,20]]
).

ligne(bis_3,metro , [
		    [porte_lilas,0],
		    [saint_fargeau,2],
		    [pelleport,1],
		    [gambetta, 2]
		    ], [[6,0],7,[23,45]], [[6,10],7,[23,55]]
).

ligne(5, bus, [
		 [bobigny_pablo_picasso, 0],
		 [bobigny_pantin, 2],
		 [eglise_de_pantin, 3],
		 [hoche,4],
		 [porte_pantin,3],
		 [ourcq,4],
		 [laumiere,3],
		 [jaures,3],
		 [stalingrad,2],
		 [gare_du_nord,3],
		 [gare_de_est,1],
		 [jacques_bonsergent,2],
		 [republique,3],
		 [oberkampf,2],
		 [richard_lenoir,2],
		 [breguet_sabin,2],
		 [bastille,2],
		 [quai_de_la_rapee,3],
		 [gare_austerlitz,2],
		 [saint_marcel,3],
		 [campo_formio,2],
		 [place_italie,3]
		], [[5,24],3,[1,20]], [[5,30],3,[1,0]]
).

ligne(bis_7, metro, [
		    [pre_saint_gervais,0],
		    [place_fetes, 3],
		    [danube, 0],
		    [bolivar, 2],
		    [buttes_chaumont, 2],
		    [botzaris, 2],
		    [jaures, 3],
		    [louis_blanc,2]
		    ], [[5,35],8,[0,0]], [[5,50],8,[23,45]]
).

ligne(11, metro, [
                   [mairie_lilas, 0],
                   [porte_lilas, 3],
                   [telegraphe,1],
                   [place_fetes,1],
                   [jourdain, 1],
                   [pyrenees, 1],
                   [belleville, 2],
                   [goncourt, 2],
                   [republique, 3],
                   [arts_metiers, 2],
                   [rambuteau, 1],
                   [hotel_de_ville, 1],
                   [chatelet, 1]
                   ], [[5,15],5,[1,30]], [[5,0],5,[2,0]]
).
/******************************************************************exercice 1********************************************************************/
% Exercice 01

% Prédicat qui ajoute M minutes à l'horaire X pour obtenir R
addh([H, M], MinutesToAdd, [NewH, NewM]) :-
    TotalMinutes is H * 60 + M + MinutesToAdd,
    NewH is TotalMinutes // 60 mod 24,
    NewM is TotalMinutes mod 60.

% Prédicat qui affiche l'horaire dans un format lisible
affiche([H, M]) :-
    format('~|~`0t~d~2+:~|~`0t~d~2+', [H, M]).

% Exercice 02

% Prédicat qui vérifie si la ligne passe de l'Arret1 à l'Arret2
lig(Arret1, Arret2, Ligne) :-
    ligne(Ligne, _, ListeArrets, _, _),
    (member([Arret1, _], ListeArrets), member([Arret2, _], ListeArrets));
    (member([Arret2, _], ListeArrets), member([Arret1, _], ListeArrets)).
% Conversion d'une heure sous forme de liste [Heures, Minutes] en minutes
convertir_en_minutes([Heures, Minutes], MinutesTotal) :-
    MinutesTotal is Heures * 60 + Minutes.
ligtot(Arret1, Arret2, Ligne, Horaire) :-
    ligne(Ligne, _, ListeArrets, [[DepartH, DepartM]|_], _),
    member([Arret1, _], ListeArrets),
    member([Arret2, _], ListeArrets),
    addh([DepartH, DepartM], 1, [NextDepartH, NextDepartM]),
    Horaire = [HoraireH, _],
    NextDepartH >= HoraireH.
% Predicate to find the line that departs the earliest after a given time
% Prédicat qui trouve la ligne arrivant le plus tard avant Horaire
ligtard(Arret1, Arret2, Ligne, Horaire) :-
    ligne(Ligne, _, ListeArrets, _, [[ArrivalH, ArrivalM]|_]),
    member([Arret1, _], ListeArrets),
    member([Arret2, _], ListeArrets),
    addh([ArrivalH, ArrivalM], -1, [LastArrivalH, LastArrivalM]),
    Horaire = [HoraireH, _],
    LastArrivalH =< HoraireH.



% Exercice 03

% Prédicat pour trouver un itinéraire partant le plus tôt après Horaire
itinTot(Arret1, Arret2,[Heures, Minutes] , [Arret1, DepartTime, Arret2, ArrivalTime]) :-
    ligne(_, _, ListeArrets, _, _),
    member([Arret1, DepartTime], ListeArrets),
    member([Arret2, ArrivalTime], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes ,
    DepartTime >= HoraireEnMinutes.

% Prédicat pour trouver un itinéraire arrivant le plus tard avant Horaire
itinTard(Arret1, Arret2, [Heures, Minutes], [Arret1, DepartTime, Arret2, ArrivalTime]) :-
    ligne(_, _, ListeArrets, _, _),
    member([Arret1, DepartTime], ListeArrets),
    member([Arret2, ArrivalTime], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes ,
    ArrivalTime =< HoraireEnMinutes.



% Exercice 01

% Prédicat qui ajoute M minutes à l'horaire X pour obtenir R
add_minutes([H, M], MinutesToAdd, [NewH, NewM]) :-
    TotalMinutes is H * 60 + M + MinutesToAdd,
    NewH is TotalMinutes // 60 mod 24,
    NewM is TotalMinutes mod 60.

% Prédicat qui affiche l'horaire dans un format lisible
affiche_horaire([H, M]) :-
    format('~|~`0t~d~2+:~|~`0t~d~2+', [H, M]).

% Exercice 02

% Prédicat qui vérifie si la ligne passe de l'Arret1 à l'Arret2 avec des options
ligne_passe(Arret1, Arret2, Ligne, Reseau, Longueur) :-
    ligne(Ligne, Reseau, ListeArrets, Longueur, _),
    (member([Arret1, _], ListeArrets), member([Arret2, _], ListeArrets));
    (member([Arret2, _], ListeArrets), member([Arret1, _], ListeArrets)).

% Prédicat qui trouve la ligne partant le plus tôt après Horaire avec des options
ligne_partant_plus_tard(Arret1, Arret2, Ligne,[Heures, Minutes] , Reseau, Longueur) :-
    ligne(Ligne, Reseau, ListeArrets, Longueur, _),
    member([Arret1, DepartTime1], ListeArrets),
    member([Arret2, DepartTime2], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes,
    DepartTime1 >= HoraireEnMinutes ,
    DepartTime1 >= HoraireEnMinutes   .

% Prédicat qui trouve la ligne arrivant le plus tard avant Horaire avec des options
ligne_arrivant_plus_tard(Arret1, Arret2, Ligne,[Heures, Minutes] , Reseau, Longueur) :-
    ligne(Ligne, Reseau, ListeArrets, Longueur, _),
    member([Arret1, ArrivalTime1], ListeArrets),
    member([Arret2, ArrivalTime2], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes,
    ArrivalTime1 =< HoraireEnMinutes ,
    ArrivalTime2 =< HoraireEnMinutes .

% Exercice 03

% Prédicat pour trouver un itinéraire partant le plus tôt après Horaire avec des options
itineraire_partant_plus_tard(Arret1, Arret2, [Heures, Minutes] , Parcours, Reseau, Longueur, Correspondances) :-
    ligne(_, Reseau, ListeArrets, Longueur, Correspondances),
    member([Arret1, DepartTime], ListeArrets),
    member([Arret2, ArrivalTime], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes ,
    DepartTime >= HoraireEnMinutes .

itineraire_arrivant_plus_tard(Arret1, Arret2,[Heures, Minutes] ,  Parcours, Reseau, Longueur, Correspondances) :-
    ligne(_, Reseau, ListeArrets, Longueur, Correspondances),
    member([Arret1, DepartTime], ListeArrets),
    member([Arret2, ArrivalTime], ListeArrets),
    HoraireEnMinutes =  Heures * 60 + Minutes ,
    ArrivalTime =< HoraireEnMinutes .

%exercice 5 :
interface_utilisateur :-
    write('Veuillez choisir le mode de transport (metro/bus) : '),
    read_line_to_codes(user_input, TransportCodes),
    string_codes(Transport, TransportCodes),
    (
        string_upper(Transport, 'METRO') -> afficher_stations_metro;
        string_upper(Transport, 'BUS') -> afficher_stations_bus;
        write('Transport non reconnu.')
    ).



choisir_transport(metro) :-
    afficher_stations_metro.

choisir_transport(bus) :-
    afficher_stations_bus.

choisir_transport(_) :-
    writeln('Transport non reconnu.').


afficher_stations_metro :-
    ligne(_, metro, Stations, _, _),
    write('Stations disponibles : '), nl,
    afficher_liste_stations(Stations),
    nl, write('Veuillez entrer la station de départ : '),
    read_string(user_input, "\n", "\r", _,StationDepart),
    nl, write('Veuillez entrer la station d\'arrivée : '),
    read_string(user_input, "\n", "\r", _,StationArrivee),
    nl, write('Veuillez entrer l heure [hh:mm] d\'arrivée : '),
    read_string(user_input, "\n", "\r", _,Heure ),



    nl, write('Les parcours possibles entre '), write(StationDepart),
    write(' et '), write(StationArrivee), write(' sont :'), nl,
    itinTot(StationDepart, StationArrivee,Heure, Parcours),
    afficher_parcours(Parcours).

afficher_liste_stations([]).
afficher_liste_stations([[Station, _] | Stations]) :-
    write(Station), write(', '),
    afficher_liste_stations(Stations).

afficher_parcours([]) :- write('Aucun parcours trouvé.').
afficher_parcours([Parcours | AutresParcours]) :-
    write(Parcours), nl,
    afficher_parcours(AutresParcours).

afficher_stations_bus :-
    ligne(_, bus, Stations, _, _),
    write('Stations disponibles : '), nl,
    afficher_stations(Stations),
    nl, write('Veuillez entrer la station de départ : '),
    read_line_to_codes(user_input,StationDepart),
    nl, write('Veuillez entrer la station d\'arrivée : '),
    read_line_to_codes(user_input,StationArrivee),

    nl, write('Les parcours possibles entre '), write(StationDepart),
    write(' et '), write(StationArrivee), write(' sont :'), nl,
    itinTot(StationDepart, StationArrivee,_, Parcours),
    afficher_parcours(Parcours).

afficher_stations([]).
afficher_stations([[Nom, _]|Reste]) :-
    writeln(Nom),
    afficher_stations(Reste).
