cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).
cree(juan, conejoDePascua).
cree(macarena, reyesMagos).
cree(macarena, elMagoCapria).
cree(macarena, campanita).

quiere(gabriel, ganarLoteria([5,9])).
quiere(gabriel, ganarLoteria([5,9])).
quiere(juan, cantante(100000)).
quiere(macarena, cantante(10000)).

/*
b. Conceptos aplicados:
Principio de Universo Cerrado
Predicados, functores
creación de abstracciones
*/

esAmbiciosa(Persona):- cree(Persona, _), 
    dificultadTotalSuenios(Persona, TotalDificultad), 
    TotalDificultad > 20.

dificultadTotalSuenios(Persona, TotalDificultad):-
    findall(Dificultad, dificultadSuenio(Persona, Dificultad), 	
            ListaDificultades), sumlist(ListaDificultades, TotalDificultad).

dificultadSuenio(Persona, Dificultad):- quiere(Persona, Suenio), 
    nivelDificultad(Suenio, Dificultad).

nivelDificultad(ganarLoteria(ListaNumeros), Total):- length(ListaNumeros, Cantidad), 
    Total is Cantidad * 10.
nivelDificultad(cantante(Cantidad), 6):- Cantidad > 500000.
nivelDificultad(cantante(Cantidad), 4):- Cantidad =< 500000.
nivelDificultad(futbolista(Equipo), 3):- equipoChico(Equipo).
nivelDificultad(futbolista(Equipo), 16):- not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%Punto 3
tieneQuimica(Personaje, Persona):- cree(Persona, Personaje), 
    						cumpleCondiciones(Persona, Personaje).

cumpleCondiciones(Persona, campanita):- quiere(Persona, Suenio), 
    			nivelDificultad(Suenio, Dificultad), Dificultad < 5.

cumpleCondiciones(Persona, Personaje):- Personaje \= campanita,
    todosLosSueniosSonPuros(Persona), not(esAmbiciosa(Persona)).
todosLosSueniosSonPuros(Persona):- forall(quiere(Persona, Suenio), esPuro(Suenio)).
esPuro(futbolista(_)).
esPuro(cantante(CantidadDeDiscos)):- CantidadDeDiscos < 500000.

/*
Estamos usando varios conceptos, como polimorfismo, orden superior, not/1,
con forall/2, findall/3 en el ejercicio anterior
*/
                     
%Punto 4
amiga(campanita, reyesMagos).
amiga(campanita, conejoDePascua).
amiga(cavenaghi, conejoDePascua).
sonAmigos(Amigo, OtroAmigo):- amiga(Amigo, OtroAmigo).
sonAmigos(Amigo, OtroAmigo):- amiga(OtroAmigo, Amigo).
sonAmigos(Amigo, OtroAmigo):- amiga(Amigo, AmigoIntermedio), 
    						sonAmigos(AmigoIntermedio, OtroAmigo).

puedeAlegrar(Personaje, Persona):- quiere(Persona, _).
puedeAlegrar(Personaje, Persona):- tieneQuimica(Personaje, Persona), 
    							cumpleCondicionesPersonajeoBackup(Personaje).


cumpleCondicionesPersonajeoBackup(Personaje):- not(estaEnfermo(Personaje)).
cumpleCondicionesPersonajeoBackup(Personaje):- sonAmigos(Personaje, OtroPersonaje), 
    										not(estaEnfermo(OtroPersonaje)).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

/*
es un ejercicio completo
tiene todo, recursividad, orden superior
modelado de información
polimorfismo
*/