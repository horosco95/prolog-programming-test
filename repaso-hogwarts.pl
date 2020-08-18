%%parte 1
mago(harry,sangre(mestiza),[corajudo,amistoso,orgulloso,inteligente]).
mago(draco, sangre(pura),[inteligente,orgulloso]).
mago(hermione, sangre(impura),[inteligente,orgulloso,responsable]).
magoOdia(draco, hufflepuff).
magoOdia(harry, slytherin).

casaApropiada(gryffindor,tiene([coraje])).
casaApropiada(slytherin,tiene([orgullo,inteligente])).
casaApropiada(ravenclaw,tiene([inteligente,responsable])).
casaApropiada(hufflepuff,tiene([amistoso])).

permiteEntrar(Casa,Mago):- mago(Mago,_,_), casaApropiada(Casa,_), Casa \= slytherin.
permiteEntrar(slytherin,Mago):- mago(Mago,sangre(Tipo),_), Tipo \= impura.

caracterApropiado(Mago,Casa):- mago(Mago,_,Caracteristicas),
    casaApropiada(Casa,tiene(Requisitos)),
    sonCompatibles(Caracteristicas,Requisitos).
sonCompatibles(Caracteristicas,Requisitos):- forall(member(Caracteristica, Caracteristicas), member(Caracteristica, Requisitos)).

posibleCasa(Mago,Casa):- caracterApropiado(Mago,Casa),
    permiteEntrar(Casa,Mago),
    not(magoOdia(Mago,Casa)).

cadenaDeAmistades(ListaMagos):- forall(member(Mago, ListaMagos),(esAmistoso(Mago),permiteEntrar(Mago,Casa))).

esAmistoso(Mago):- mago(Mago,_,Caracteristicas), member(amistoso, Caracteristicas).

%% parte 2
malaAccion(fueraDeCama, -50).
malaAccion(Lugar,Puntaje):- lugarProhibido(Lugar,Puntaje).
lugarProhibido(bosque, -50).
lugarProhibido(seccionRestringidaBiblioteca, -10).
lugarProhibido(tercerPiso, -75).

accionesCometidas(harry,[fueraDeCama,bosque,tercerPiso]).
accionesCometidas(hermione,[tercerPiso,seccionRestringidaBiblioteca]).
accionesCometidas(draco,[mazmorra]).
puntosGanados(ron,premios([(ganarPartidaAjedres,50)])).
puntosGanados(hermione,premios([(salvarAmigos,50)])).
puntosGanados(harry,premios([(ganarAVoldemort,60)])).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

buenAlumno(Mago):- accionesCometidas(Mago,ListaAcciones), forall(member(Accion,ListaAcciones), not(malaAccion(Accion,_))).

accionRecurrente(Accion):- accionesCometidas