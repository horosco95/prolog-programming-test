%% Punto 1
perteneceA(eriador,comarca).
perteneceA(eriador,rivendel).
perteneceA(montaniasNubladas,moria).
perteneceA(montaniasNubladas,lothlorien).
perteneceA(rohan,edoras).
perteneceA(rohan,isengard).
perteneceA(rohan,abismoDeHelm).
perteneceA(gondor,minasTirith).
perteneceA(mordor,minasMorgul).
perteneceA(mordor,monteDelDestino).

%% Punto 2
camino([comarca,rivendel,moria,lothlorien,edoras,minasTirith,minasMorgul,monteDelDestino]).

%% Punto 3
zonasLimitrofes(rivendel,moria).
zonasLimitrofes(moria,rivendel).
zonasLimitrofes(moria,isengard).
zonasLimitrofes(isengard,moria).
zonasLimitrofes(lothlorien,edoras).
zonasLimitrofes(edoras,lothlorien).
zonasLimitrofes(edoras,minasTirith).
zonasLimitrofes(minasTirith,edoras).
zonasLimitrofes(minasTirith,minasMorgul).
zonasLimitrofes(minasMorgul,minasTirith).
zonasLimitrofes(UnaZona,OtraZona):- perteneceA(Region,UnaZona),perteneceA(Region,OtraZona),UnaZona\=OtraZona.

%% Punto 4
% parte A - 

regionesLimitrofes(UnaRegion,OtraRegion):- perteneceA(UnaRegion,Zona1),perteneceA(OtraRegion,Zona2),UnaRegion\=OtraRegion,
    	zonasLimitrofes(Zona1,ZonaComun),zonasLimitrofes(ZonaComun,Zona2),Zona1\=Zona2.
regionesLimitrofe2(UnaRegion,OtraRegion):- perteneceA(UnaRegion,UnaZona), perteneceA(OtraRegion,OtraZona), zonasLimitrofes(UnaZona,OtraZona).


% parte B - 
regiones(Region):-perteneceA(Region,_).
regionesLejanas(UnaRegion,OtraRegion):- regiones(OtraEnComun),not(regionesLimitrofes(UnaRegion,OtraRegion)),
    not((regionesLimitrofes(UnaRegion,OtraEnComun),regionesLimitrofes(OtraEnComun,OtraRegion))),UnaRegion \= OtraRegion.


%% Punto 5
% parte A - 
ultimoElemento([Elem],Elem).
ultimoElemento([_|Cola],Ultimo):- ultimoElemento(Cola,Ultimo).
puedeSeguirCon(Camino,Zona):- ultimoElemento(Camino,Ultimo),zonasLimitrofes(Zona,Ultimo).

% parte B -

sonConsecutivos(Camino1,[Cabeza2|Cola2]):- puedeSeguirCon(Camino1,Cabeza2).

% Punto 6


% parte B - 
caminoSeguro([A,B,C|Cola]):- not(primeras3ZonasMismaRegion([A,B,C])), caminoSeguro([B,C|Cola]).
caminoSeguro([A,B,C]):- not(primeras3ZonasMismaRegion([A,B,C])).

primeras3ZonasMismaRegion([A,B,C|_]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(Misma,A),perteneceA(Misma,B),perteneceA(Misma,C).
%primeras3ZonasMismaRegion2([A,B,C]):- zonasLimitrofes(A,B),zonasLimitrofes(B,C),perteneceA(Misma,A),perteneceA(Misma,B),perteneceA(Misma,C).

% [rivendel,lothlorien,edoras,isengard,abismoDeHelm,minasTirith,minasMorgul]