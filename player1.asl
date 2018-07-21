// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */

player(0).

/* Initial goals */

//!start.

/* Plans */

+canExchange(N) : player(N) <- +myTurn.

+tryAgain <- +myTurn; .abolish(tryAgain).

+pos(Ag,X,Y)[source(S)] <- -pos(Ag,X,Y)[source(S)].

+ip(X,Y,C) <- .print("Hay un investigador principal en la posición: ", X, ",", Y, " de color:", C).
+ct(X,Y,C) <- .print("Hay un catedratico en la posición: ", X, ",", Y, " de color:", C).
+gs(X,Y,C) <- .print("Hay un gestor en la posición: ", X, ",", Y, " de color:", C).
+co(X,Y,C) <- .print("Hay un comprador en la posición: ", X, ",", Y, " de color:", C).

+exchange(X1,Y1,X2,Y2) [source(Agent)] : myTurn <- //: tryAgain <-
	//.abolish(tryAgain);
	.print("He recibido del agente: ",Agent," la sugerencia de intercambiar: (", X1, ", ", Y1, ") por (",X2,", ",Y2,")");
	-myTurn;
	.send(judge,tell,exchange(X1,Y1,X2,Y2)).

+exchange(X1,Y1,X2,Y2) [source(Agent)] : not myTurn <-
	.print("Lo siento no es mi TUUUUURRRRRRRRNNNNNNNNNNNNNOOOOOOOOOOOOOOOOOOO").
