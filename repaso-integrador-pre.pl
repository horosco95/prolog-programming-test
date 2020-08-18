cotizacion(dolar, 8, 43).
cotizacion(lira, 8, 41).
cotizacion(dolar,9, 43.5).
cotizacion(lira, 9, 39).
cotizacion(dolar,10, 43.8).
cotizacion(lira, 10, 38).
cotizacion(patacon, 9, 200).
cotizacion(patacon, 10, 200).

cuantoVarioCotizacion(Moneda, Hora, Cuanto):- HoraAnterior is Hora -1, 
    cotizacion(Moneda, HoraAnterior, CotizacionAnterior), 
    cotizacion(Moneda, Hora, CotizacionActual), 
    Cuanto is CotizacionActual - CotizacionAnterior.
%listaCotizacion(Moneda, Cotizacion):-cotizacion(Moneda,_,Cotizacion), forall(cotizacion(Moneda, HoraMaxima, Cotizacion), (cotizacion(Moneda, Hora, _), HoraMaxima >= Hora)).
aCuantoCerro(Moneda, Monto):- cotizacion(Moneda, Hora, Monto),
    forall(cotizacion(Moneda, OtroHorario, _), OtroHorario =< Hora).
% este forma expresa que devuelva un monto tal que su hora sea la maxima.

%punto 2
transaccion(juanCarlos, 8, 1000, dolar).
transaccion(juanCarlos, 9, 1000, lira).
transaccion(ypf, 10, 100005349503495035930, dolar).

hicieronTransaccionConMasDeUnaMoneda(Persona):- transaccion(Persona, _, _, Moneda), 
    transaccion(Persona, _, _, OtraMoneda), Moneda \= OtraMoneda.

monedaQueNadieHizoTranzacciones(Moneda):- moneda(Moneda), not(transaccion(_, _, _, Moneda)).
moneda(Moneda):- cotizacion(Moneda,_,_).

transaccionGrande(Quien):- transaccion(Quien, _, Monto, _), 
    Monto > 1000000.

totalPesosCambiados(Persona, Total):- transaccion(Persona, _, _, _), 
    findall(Monto, transaccion(Persona,_,Monto,_), ListaMonto), 
    sumlist(ListaMonto,Total).

%punto 3
