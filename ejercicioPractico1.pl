
contador(roque).
/*una clausula*/
contador(roque).
joven(roque).
abogado(cecilia).
ambicioso(cecilia).
ambicioso(Persona):- contador(Persona), joven(Persona).
honesto(roque).
ingeniero(ana).

trabajoEn(ana,omni).
trabajoEn(roque,acme).
trabajoEn(lucia,omni).

habla(cecilia,frances).
habla(lucia,frances).
habla(lucia,ingles).
habla(ana,frances).
habla(roque,frances).
habla(ana,ingles).

/*Los contadores jovenes son ambiciosos.
*/

tieneExperiencia(Persona):- trabajoEn(Persona, _).
profesional(Persona):-contador(Persona).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).

puedeAndar(Persona, comercioExterior):-ambicioso(Persona).
puedeAndar(Persona, contaduria):- contador(Persona), honesto(Persona).
puedeAndar(Persona, ventas):- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(lucia, ventas).
puedeAndar(Persona, proyectos):- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(Persona, proyectos):- abogado(Persona), joven(Persona).
puedeAndar(Persona, logistica):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):- joven(Persona).
cumpleCondiciones(Persona):- trabajoEn(Persona, omni).
/*
punto 2 se agrega ejemplos/hechos que cumpla esas condiciones


punto 3 se agrega ejemplos/hechos que cumpla esas condiciones
*/


/*
relaciones familiares
*/
madre(mona, homero).
madre(jaqueline, marge).
madre(marge,maggie).
madre(marge,bart).
madre(marge,lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero,maggie).
padre(homero,bart).
padre(homero,lisa).

hermano(Persona, OtraPersona):- mismaMadre(Persona,OtraPersona),mismoPadre(Persona,OtraPersona).

mismaMadre(Persona,OtraPersona):-madre(Madre,Persona),madre(Madre,OtraPersona), Persona\=OtraPersona.

mismoPadre(Persona,OtraPersona):-padre(Padre,Persona),padre(Padre,OtraPersona), Persona\=OtraPersona.

/*punto 2*/
medioHermano(Persona,OtraPersona):-mismaMadre(Persona,OtraPersona), not(hermano(Persona,OtraPersona)).
medioHermano(Persona,OtraPersona):-mismoPadre(Persona,OtraPersona), not(hermano(Persona,OtraPersona)).

/*punto 3*/
hijoUnico(Persona):- hijo(Persona,_),not(hermano(Persona,_)).

hijo(Persona,Progenitor):- madre(Progenitor,Persona).
hijo(Persona,Progenitor):- padre(Progenitor,Persona).

/*punto 4*/
tio(Tio,Sobrino):- padre(Padre,Sobrino), hermano(Padre,Tio).
tio(Tio,Sobrino):- madre(Madre,Sobrino), hermano(Madre,Tio).

/**/