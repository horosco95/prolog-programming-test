genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).
gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soloLeGustaPeliculaDeGenero(Persona, Genero):- persona(Persona), generoPelicula(Genero)m
    forall(gusta(Persona, Pelicula), genero(Pelicula,Genero)).

persona(Persona):- gusta(Persona,_).
generoPelicula(Genero):- genero(_,Genero).

peliculasQueLeGustaPorGenero(Persona, Genero,Pelicula):- persona(Persona), generoPelicula(Genero),
    findall(Pelicula, gustaPersonaPeliculaDeGenero(Persona,Genero, Pelicula), )
%a completar...