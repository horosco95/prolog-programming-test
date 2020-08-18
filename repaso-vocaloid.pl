%cantante(Nombre,canciones([(Cancion,Duracion)]))
cantante(megurineLuka,canciones([(nightFever,4),(foreverYoung,5)])).
cantante(hatsumeMiku,canciones([(tellYourWorld,4)])).
cantante(gumi,canciones([(foreverYoung,4),(tellYourWorld,5)])).
cantante(seeU,canciones([(novemberRain,6),(nightFever,5)])).

esNovedoso(Cantante):- cantante(Cantante, canciones(ListaCanciones)),
    length(ListaCanciones, CantidadCanciones),
    CantidadCanciones >= 2,
    duracionTotalCanciones(ListaCanciones,DuracionTotal),
    DuracionTotal < 15.

duracionTotalCanciones(ListaCanciones,DuracionTotal):-
    findall(Duracion,member((_,Duracion), ListaCanciones),ListaDuracion),
    sumlist(ListaDuracion, DuracionTotal).
    
esAcelerado(Cantante):- cantante(Cantante,canciones(ListaCanciones)),
    not((member((_,Duracion),ListaCanciones),Duracion > 4)).

%concierto(Nombre,Pais,CantidadFama)
concierto(mikuExpo,estadosUnidos,2000).
concierto(magicalMirai, japon,3000).
concierto(vocalektVisions, estadosUnidos,1000).
concierto(mikuFest, argentina, 100).
%conciertoRequisitos(Nombre,gigante(CancionesMinima,DuracionTotalMinima)).
%conciertoRequisitos(Nombre, mediano(DuracionTotalMinima)).
%conciertoRequisitos(Nombre, pequenio(UnaCancionDuracionMinima))
conciertoRequisitos(mikuExpo, gigante(2,6)).
conciertoRequisitos(magicalMirai, gigante(3,10)).
conciertoRequisitos(vocalektVisions, mediano(9)).
conciertoRequisitos(mikuFest, pequenio(4)).

puedeParticipar(hatsumeMiku,_).
puedeParticipar(Cantante,Concierto):- conciertoRequisitos(Concierto,Requisitos),
    cumpleRequisitos(Cantante,Requisitos).

cumpleRequisitos(Cantante,pequenio(DuracionMinima)):- cantante(Cantante,canciones(ListaCanciones)),
    member((_,DuracionCancion),ListaCanciones), DuracionCancion >= DuracionMinima.
cumpleRequisitos(Cantante,mediano(DuracionTotalMinima)):- cantante(Cantante,canciones(ListaCanciones)),
    duracionTotalCanciones(ListaCanciones,DuracionTotal), DuracionTotal >= DuracionTotalMinima.
cumpleRequisitos(Cantante,gigante(CancionesMinima,DuracionTotalMinima)):- cantante(Cantante,canciones(ListaCanciones)),
    length(ListaCanciones,CantidadCanciones), 
    CantidadCanciones >CancionesMinima,
    duracionTotalCanciones(ListaCanciones,DuracionTotal), DuracionTotal >= DuracionTotalMinima.

masFamoso(Cantante):- nivelFama(Cantante,Maximo), forall(nivelFama(OtroCantante,Fama), Fama =< Maximo).

nivelFama(Cantante, Fama):- findall(Concierto, puedeParticipar(Cantante,Concierto), Conciertos),
    cantante(Cantante,canciones(ListaCanciones)),
    length(ListaCanciones,CantidadCanciones),
    cantidadFamaTotal(Conciertos,FamaTotal),
    Fama is CantidadCanciones * FamaTotal.
cantidadFamaTotal(Conciertos,FamaTotal):- findall(Fama,member(concierto(Concierto,_,Fama),Conciertos),ListaFama),
    sumlist(ListaFama, FamaTotal).

conoceA(megurineLuka,hatsumeMiku).
conoceA(gumi,seeU).
conoceA(seeU,kaito).

unicoParticipante(Cantante,Concierto):- tieneConocido(Cantante,Conocido), not(puedeParticipar(Conocido,Concierto)).

tieneConocido(Cantante,Otro):- conoceA(Cantante,Otro).
tieneConocido(Cantante,Otro):- conoceA(Cantante,Comun),conoceA(Comun,Otro).

/*
punto 5.
Supongamos que aparece un nuevo tipo de concierto y necesitamos tenerlo en cuenta en nuestra solución, explique los cambios que habría que realizar para que siga todo funcionando. ¿Qué conceptos facilitaron dicha implementación?
En este caso, hay que agregar a la base de conocimiento los nuevos requisitos y agregar una regla nueva para el nuevo tipo de concierto actualizando el predicado cumpleRequisitos/2.
Conceptos que facilitaron la implementacion fueron: los functores, abstraccion, principio de universo cerrado, polimorfismo.
*/