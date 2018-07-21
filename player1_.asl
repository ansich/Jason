// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */

player(0).

/* Initial goals */

+canExchange(N) : player(N) <- !start.

+!start : sizeof(N) <- 
	.print(" \n\n\n\n\n\n\n\nLe toca a player1\n\n\n\n\n\n\n\n ");
	!buscarCatedroH(0,9).
	
	
/* Plans */

+canExchange(N) : player(N) <- +myTurn.

+tryAgain <- +myTurn; .abolish(tryAgain).

+pos(Ag,X,Y)[source(S)] <- -pos(Ag,X,Y)[source(S)].

+ip(X,Y,C) <- .print("Hay un investigador principal en la posici贸n: ", X, ",", Y, " de color:", C).
+ct(X,Y,C) <- .print("Hay un catedratico en la posici贸n: ", X, ",", Y, " de color:", C).
+gs(X,Y,C) <- .print("Hay un gestor en la posici贸n: ", X, ",", Y, " de color:", C).
+co(X,Y,C) <- .print("Hay un comprador en la posici贸n: ", X, ",", Y, " de color:", C).

+exchange(X1,Y1,X2,Y2) [source(Agent)] : myTurn <-
//: tryAgain <-
	//.abolish(tryAgain);
	.print("He recibido del agente: ",Agent," la sugerencia de intercambiar: (", X1, ", ", Y1, ") por (",X2,", ",Y2,")");
	-myTurn;
	.send(judge,tell,exchange(X1,Y1,X2,Y2)).

+exchange(X1,Y1,X2,Y2) [source(Agent)] : not myTurn <-
	.print("Lo siento no es mi TUUUUURRRRRRRRNNNNNNNNNNNNNOOOOOOOOOOOOOOOOOOO").
	

	
//-------------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------------------//


//Buscamos combinaciones de catedro(5 fichas) en horizontal
+!buscarCatedroH(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if((X < N-4) & steak(C1,X+1,Y) & C == C1 & steak(C2,X+3,Y) & C == C2 & steak(C3,X+4,Y) & C == C3  ){
		if( (Y < N) & steak(C4,X+2,Y+1) & C == C4 ){
		.send(judge,tell,exchange(X+2,Y+1,X+2,Y));
		+catedroH(X,Y);
		}
		else {
			if((Y > 0) & steak(C5,X+2,Y-1) & C5 == C){
				.send(judge,tell,exchange(X+2,Y-1,X+2,Y));
			}else{
				.print("Combinacion C醫edro H no encontrado 2");
			}
		}
	}else{
		.print("Combinacion C醫edro H no encontrado 1");
	}.
