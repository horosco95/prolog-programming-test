transporte(juan, camina).
transporte(marcela, subte(a)).
transporte(pepe, colectivo(160,d)).
transporte(elena, colectivo(76)).
transporte(maria, auto(500, fiat,2015)).
transporte(ana, auto(fiesta, ford, 2014)).
transporte(roberto, auto(qubo, fiat, 2015)).
manejaLento(manuel).
manejaLento(ana).

%Consulta: transporte(Persona, auto(_, fiat, _)).

tardaMucho(Persona):- transporte(Persona, camina).
tardaMucho(Persona):- transporte(Persona, auto(_,_,_)), manejaLento(Persona).

vaijaEnColectivo(Persona):- transporte(Persona, Colectivo), esColectivo(Colectivo).

esColectivo(colectivo(_,_)).
esColectivo(colectivo(_)).

%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)%
lugar(marDelPlata, hotel(elViajante,4,1500)).
lugar(marDelPlata, hotel(casaNostra,3,1000)).
lugar(lasToninas, hotel(holidays,2,500)).
lugar(lasToninas, carpa(60)).
lugar(tandil,quinta(amanecer,pileta,650)).
lugar(bariloche,carpa(80)).
lugar(laFalda, casa(pileta,600)).
lugar(laFalda, carpa(70)).
lugar(rosario, casa(garaje,400)).

lugar(rosario, casa(garaje,400)).

%puedeGastar(nombre,cantDias,montoTotal)%
puedeGastar(ana,4,10000).
puedeGastar(hernan,5,8000).
puedeGastar(mario,5,4000).

%Punto 1
puedeIr(Persona,Lugar,Alojamiento):- puedeGastar(Persona,CantDias,Disponible),
    	lugar(Lugar,Alojamiento), montoDiario(Alojamiento,MontoDia),
    	Disponible >= CantDias * MontoDia, cumpleCondiciones(Alojamiento).

montoDiario(hotel(_,_,Monto),Monto).
montoDiario(quinta(_,_,Monto),Monto).
montoDiario(casa(_,Monto),Monto).
montoDiario(carpa(Monto),Monto).

cumpleCondiciones(hotel(_,CantEstrellas,_)):- CantEstrellas > 3.
cumpleCondiciones(casa(garaje,_)).
cumpleCondiciones(quinta(_,pileta,_)).
cumpleCondiciones(carpa(_)).

%Es importante el orden de los antecedentes debido a la inversivilidad
%en este caso "Disponible >= CantDias * MontoDia" no puede ir antes que MontoDiario
%ya que no puede conocer el valor MontoDia. (Lo extrae de la funcion MontoDiario)


%Punto 2
puedeIrACualquierLugar(Persona):- persona(Persona), forall(lugar(Lugar,_), puedeIr(Persona, Lugar,_)).
%Se arma abstraccion: persona (es el generador)
           
persona(Persona):- puedeGastar(Persona,_,_).