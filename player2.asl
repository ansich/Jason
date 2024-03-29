// Agent player in project conecta4.mas2j

/* Initial beliefs and rules */

/*contiguas(X1,Y1,X2,Y2) :- ( math.abs(X1 - X2) == 1 & math.abs(Y1 - Y2) ) == 0 | ( math.abs(X1 - X2) == 0 & math.abs(Y1 - Y2) == 1 ).
mismoColor(X1,Y1,C1,X2,Y2,C2) :- C1 == C2.*/

//Indicamos que somos el player1
player(1).

/* Initial goals */

//!start.

/* Plans */
//+canExchange <-  !recorrerTablero.

//+turn(T)[source(judge)]  <- +turnoAsignado(T).


+canExchange(0): player(N) <- !start.
/*+!hola : true <- 
	//.send(judge,askOne,turn(X2));
	//.print(X2);
	?myTurn(T);
	//?turnoActual(T1);
	.print("Es mi turno n�: ", T,".);
	!recorrerTablero.*/

	


+!start : sizeof(N) /*& myTurn(T) & turn(X2) & T == X2 */<-

		.print("Hola---------------------------------------------------------------------------------", X2);
	//.my_name(P);
	for(.range(Aux,0,19)){
	?myTurn(T);
	//.print(" \n\n\n\n\n\n\n\nLe toca a ", P, "con el turno ", T,"\n\n\n\n\n\n\n\n ");
	!recorrerTablero;
	-myTurn(T);
	.send(tell,player2,addTurn(T));
	.wait(myTurn(T+1));
	}.
	



+!addTurn(T) <- +myTurn(T+1).
	



/*-----------------------------------CATEDRO-------------------------------------*/

//Buscamos combinaciones de catedro(5 fichas) en horizontal
+!buscarCatedroH(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if((X < N-4) & steak(C1,X+1,Y) & C == C1 & steak(C2,X+3,Y) & C == C2 & steak(C3,X+4,Y) & C == C3  ){
		if( (Y < N) & steak(C4,X+2,Y+1) & C == C4 ){
		//.send(judge,tell,exchange(X+2,Y+1,X+2,Y));
		+catedroH(X,Y);
		.print("Quiero cambiar (", X+2, ",", Y+1, ") por (", X+2, ",", Y, ") )");
		}
		else {
			if((Y > 0) & steak(C5,X+2,Y-1) & C5 == C){
				//.send(judge,tell,exchange(X+2,Y-1,X+2,Y));
				.print("Quiero cambiar (", X+2, ",", Y-1, ") por (", X+2, ",", Y, ") )");
			}
			else{
				.print("Combinacion C�tedro H no encontrado");
			}
		}
	}else{
		.print("Combinacion C�tedro H no encontrado");
	}.
	
//Buscamos combinaciones de catedro(5 fichas) en vertical
+!buscarCatedroV(X,Y) :  sizeof(N) & steak(C,X,Y)     
	<-
	if(Y < (N-4) & steak(C1,X,Y+1) & C == C1 & steak(C2,X,Y+3) & C == C2 & steak(C3,X,Y+4) & C == C3){
		if( (X < N) & steak(C4,X+1,Y+2) & C == C4 ){
		.send(judge,tell,exchange(X+1,Y+2,X,Y+2));
		.print("Quiero cambiar (", X+1, ",", Y+2, ") por (", X, ",", Y+2, ") )");
		}
		else {
			if((X > 0) & steak(C5,X-1,Y+2) & C5 == C){
				.send(judge,tell,exchange(X-1,Y+2,X,Y+2));
				.print("Quiero cambiar (", X-1, ",", Y+2, ") por (", X, ",", Y+2, ") )");
			}
			else{
				.print("Combinacion C�tedro V no encontrado");
			}
		}
	}else{
		.print("Combinacion C�tedro V no encontrado");
	}.
	
/*----------------------FIN CATEDRO--------------------------------------------------------------------*/
/********************************************************************************************************/	
/*-------------------COMPRADOR-------------------------------------------------------------------------*/	
//Buscamos combinaciones de comprador(5 fichas T) en vertical
+!buscarCompradorV(X,Y) :  sizeof(N) & steak(C,X,Y)    //forma de T
	<-
	if(X < (N-1) & Y < (N-1) & steak(C1,X+2,Y) & C == C1 & steak(C2,X+1,Y+1) & C == C2	& steak(C3,X+1,Y+2) & C == C3){
	
		if( (Y>0) & steak(C4,X+1,Y-1) & C == C4 ){
			.send(judge,tell,exchange(X+1,Y-1,X+1,Y));
			.print("Quiero cambiar (", X+1, ",", Y-1, ") por (", X+1, ",", Y, ") )");
		}		
	
	}else{
		.print("Combinacion comprador T no encontrado");
	}.
	
        
//Buscamos combinaciones de comprador(5 fichas) en vertical. Forma de (T invertida)
+!buscarCompradorVinvertido(X,Y) :  sizeof(N) & steak(C,X,Y)  
    <-
	if(X < (N-1) & Y < (N-1) & steak(C1,X+2,Y) & C == C1 & steak(C2,X+1,Y-1) & C == C2	& steak(C3,X+1,Y-2) & C == C3  ){
	
		if( (Y < N) & steak(C4,X+1,Y+1) & C == C4 ){     //AQUI ESTABA Y-1 (y creo q no estaba bien)
		.send(judge,tell,exchange(X+1,Y+1,X+1,Y));
		.print("Quiero cambiar (", X+1, ",", Y-1, ") por (", X+1, ",", Y, ") )");
		}
	}else{
		.print("Combinacion comprador T invertida no encontrado");
	}.
  
//Buscamos combinaciones de comprador(5 fichas) en horizontal. Forma de T girada hacia izqda. |--
 +!buscarCompradorH(X,Y) :  sizeof(N) & steak(C,X,Y)  
    <-
	if((X > 0) & X < (N-1) & Y < (N-1) & steak(C1,X+1,Y+1) & C == C1 & steak(C2,X+2,Y+1) & C == C2 & steak(C3,X,Y+2) & C == C3){
	
		if( (Y > 0) & steak(C4,X-1,Y+1) & C == C4 ){
			.send(judge,tell,exchange(X-1,Y+1,X,Y+1));
			.print("Quiero cambiar (", X-1, ",", Y+1, ") por (", X, ",", Y+1, ") )");
		}
	}else{
		.print("Combinacion comprador T |-- no encontrado");
	}.       

	
//Buscamos combinaciones de comprador(5 fichas) en horizontal. Forma de T girada hacia dcha. --|
 +!buscarCompradorHinvertido(X,Y) :  sizeof(N) & steak(C,X,Y)    
    <-
	if((X > 0) & X < (N-1) & Y < (N-1)& steak(C1,X-1,Y+1) & C == C1 & steak(C2,X-2,Y+1) & C == C2 & steak(C3,X,Y+2) & C == C3){
		
		if( (Y > 1) & steak(C4,X+1,Y+1) & C == C4 ){
			.send(judge,tell,exchange(X+1,Y+1,X,Y+1));     //(aqui estaba x-1)
			.print("Quiero cambiar (", X+1, ",", Y+1, ") por (", X, ",", Y+1, ") )");
		}
	}else{
		.print("Combinacion comprador T --| no encontrado");
	}.
	
/*------------------------FIN COMPRADROR--------------------------------------------*/	
/*************************************************************************************/
/*------------------------GESTOR -----------------------------------------------------*/

// Buscamos combinaciones de gestor simple (solo 4 fichas formando un cuadrado)  X x
																			//   x o  x
																			//     x     ---------> funciona ok

+!buscarGestorDerAbajo(X,Y) :  sizeof(N) & steak(C,X,Y) 
	<-
	if( Y < N & X < N & steak(C1,X+1,Y) & C == C1 & steak(C2,X,Y+1) & C == C2){
	
		if( (Y < N-1) & steak(C3,X+1,Y+2) & C == C3){
			.send(judge,tell,exchange(X+1,Y+2,X+1,Y+1));
			.print("Quiero cambiar (", X+1, ",", Y+2, ") por (", X+1, ",", Y+1, ") )");
		}else{
			if((X < N-1) & steak(C4,X+2,Y+1) & C == C4){
				.send(judge,tell,exchange(X+2,Y+1,X+1,Y+1));
				.print("Quiero cambiar (", X+2, ",", Y+1, ") por (", X+1, ",", Y+1, ") )");
			}else{
				.print("Combinacion Gestor Derecha Abajo no encontrado");
			}
		}
	}else{
		.print("Combinacion Gestor Derecha Abajo no encontrado");
	}.
	
// Buscamos combinaciones de gestor simple (solo 4 fichas formando un cuadrado)  X x
																			// x o x
																			//   x	      -->> FUNCIONA OK
+!buscarGestorIzqAbajo(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if(Y < N & X < N & steak(C1,X+1,Y) & C == C1 & steak(C2,X+1,Y+1) & C == C2){
		
		if( (Y < N-1 )& steak(C3,X,Y+2) & C == C3){
			.send(judge,tell,exchange(X,Y+2,X,Y+1));
			.print("Quiero cambiar (", X, ",", Y+2, ") por (", X, ",", Y+1, ") )");
		}esle{
			if( (X > 0 )& steak(C4,X-1,Y+1) & C == C4){
				.send(judge,tell,exchange(X-1,Y+1,X,Y+1));
				.print("Quiero cambiar (", X-1, ",", Y+1, ") por (", X, ",", Y+1, ") )");
			}else{
				.print("Combinacion Gestor Izquierda Abajo no encontrado");
			}
		}
	}else{
		.print("Combinacion Gestor Izquierda Abajo no encontrado");
	}.	
																			//	 x		
// Buscamos combinaciones de gestor simple (solo 4 fichas formando un cuadrado)x o x   ---> Funciona OK
																			//   X x
																			//   	
+!buscarGestorIzqArriba(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if(Y > 1 & X < N & steak(C1,X+1,Y) & C == C1 & steak(C2,X+1,Y-1) & C == C2){
		
		if( steak(C3,X,Y-2) & C == C3){
			.send(judge,tell,exchange(X,Y-2,X,Y-1));
			.print("Quiero cambiar (", X, ",", Y-2, ") por (", X, ",", Y-1, ") )");
		}else{
			if((X > 0) & steak(C4,X-1,Y-1) & C == C4){
				.send(judge,tell,exchange(X-1,Y-1,X,Y-1));
				.print("Quiero cambiar (", X-1, ",", Y-1, ") por (", X, ",", Y-1, ") )");
			}else{
				.print("Combinacion Gestor Izquierda Arriba no encontrado");
			}
		}
	}else{
		.print("Combinacion Gestor Izquierda Arriba no encontrado");
	}.	
																			// 	   x
// Buscamos combinaciones de gestor simple (solo 4 fichas formando un cuadrado)  X o x
																			//   x x   --> Funciona ok
																			//   	
+!buscarGestorDerArriba(X,Y) :  sizeof(N) & steak(C,X,Y)
	<-
	if(Y > 0 & X < N & steak(C1,X,Y+1) & C == C1 & steak(C2,X+1,Y+1) & C == C2){
		
		if( steak(C3,X+1,Y-1) & C == C3){
			.send(judge,tell,exchange(X+1,Y-1,X+1,Y));
			.print("Quiero cambiar (", X+1, ",", Y-1, ") por (", X+1, ",", Y, ") )");
		}else{
			if((X < N-1) & steak(C4,X+2,Y) & C == C4){
				.send(judge,tell,exchange(X+2,Y,X+1,Y));
				.print("Quiero cambiar (", X+2, ",", Y, ") por (", X+1, ",", Y, ") )");			
			}else{
				.print("Combinacion Gestor Derecha Arriba no encontrado");
			}
		}
	}else{
		.print("Combinacion Gestor Derecha Arriba no encontrado");
	}.	

/*-----------------------------------FIN GESTORES--------------------------------*/
/*********************************************************************************/
/*--------------------------------- IP ------------------------------------------*/

// Buscamos combinaciones de IP 4 fichas horizontal  (xoxx)

+!buscarIPizqHorizontal(X,Y) :  sizeof(N) & steak(C,X,Y) 
	<-
	if(X < N-2 & steak(C1,X+2,Y) & C == C1 & steak(C2,X+3,Y) & C == C2){
		
		if( (Y < N) & steak(C3,X+1,Y+1) & C == C3){
			.send(judge,tell,exchange(X+1,Y+1,X+1,Y));
			.print("Quiero cambiar (", X+1, ",", Y+1, ") por (", X+1, ",", Y, ") )");	
		}else{
			if((Y > 0) & steak(C4,X+1,Y-1) & C == C4){
				.send(judge,tell,exchange(X+1,Y-1,X+1,Y));
				.print("Quiero cambiar (", X+1, ",", Y-1, ") por (", X+1, ",", Y, ") )");	
			}else{
				.print("Combinacion IP horizontal no encontrado");
			}
		}
	}else{
		.print("Combinacion IP horizontal no encontrado");
	}.
	
// Buscamos combinaciones de IP 4 fichas horizontal  (xxox)

+!buscarIPderHorizontal(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if(X < N-2 & steak(C1,X+1,Y) & C == C1 & steak(C2,X+3,Y) & C == C2){
		if( (Y < N) & steak(C3,X+2,Y+1) & C == C3){
			.send(judge,tell,exchange(X+2,Y+1,X+2,Y));
			.print("Quiero cambiar (", X+2, ",", Y+1, ") por (", X+2, ",", Y, ") )");	
		}else{
			if((Y > 0) & steak(C4,X+2,Y-1) & C == C4){
				.send(judge,tell,exchange(X+2,Y-1,X+2,Y));
				.print("Quiero cambiar (", X+2, ",", Y-1, ") por (", X+2, ",", Y, ") )");	
			}else{
				.print("Combinacion IP horizontal no encontrado");
			}
		}
	}else{
		.print("Combinacion IP horizontal no encontrado");
	}.	
	

// Buscamos combinaciones de IP 4 fichas vertical 
/*
	x
	o
	x
	x
*/

+!buscarIPArribaVertical(X,Y) :  sizeof(N) & steak(C,X,Y) 
	<-
	if(Y < N-2 & steak(C1,X,Y+2) & C == C1 & steak(C2,X,Y+3) & C == C2){
	
		if( (X < N) & steak(C3,X+1,Y+1) & C == C3){
			.send(judge,tell,exchange(X+1,Y+1,X,Y+1));
			.print("Quiero cambiar (", X+1, ",", Y+1, ") por (", X, ",", Y+1, ") )");	
		}else{
			if((Y > 0) & steak(C4,X-1,Y+1) & C == C4){
				.send(judge,tell,exchange(X-1,Y+1,X,Y+1));
				.print("Quiero cambiar (", X-1, ",", Y+1, ") por (", X, ",", Y+1, ") )");	
			}else{
				.print("Combinacion IP vertical no encontrado");
			}
		}
	}else{
		.print("Combinacion IP vertical no encontrado");
	}.		
	
// Buscamos combinaciones de IP 4 fichas vertical 
/*
	x
	x
	o
	x
*/

+!buscarIPabajoVertical(X,Y) :  sizeof(N) & steak(C,X,Y) 	
	<-
	if(Y < N-2 & steak(C1,X,Y+1) & C == C1 & steak(C2,X,Y+3) & C == C2){
		if( (X < N) & steak(C3,X+1,Y+2) & C == C3){
			.send(judge,tell,exchange(X+1,Y+2,X,Y+2));
			.print("Quiero cambiar (", X+1, ",", Y+2, ") por (", X, ",", Y+2, ") )");	
		}else{
			if((Y > 0) & steak(C4,X-1,Y+2) & C == C4){
				.send(judge,tell,exchange(X-1,Y+2,X,Y+2));
				.print("Quiero cambiar (", X-1, ",", Y+2, ") por (", X, ",", Y+2, ") )");	
			}else{
				.print("Combinacion IP vertical no encontrado");
			}
		}
	}else{
		.print("Combinacion IP vertical no encontrado");
	}.	
	
/*--------------------------------FIN IP ---------------------------------------------*/
/**************************************************************************************/
/*----------------------------COMBINACIONES DE 3 ------------------------------------*/

// Buscamos combinaciones 3 fichas horizontal  (x oxx)

+!buscar3izqH(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if( (X < N-2) & steak(C1,X+2,Y) & C == C1 & steak(C2,X+3,Y) & C == C2){
		.send(judge,tell,exchange(X,Y,X+1,Y));
		.print("Quiero cambiar (", X, ",", Y, ") por (", X+1, ",", Y, ") )")
	}else{
		.print("No hay combinacion de 3 horizontal");
	}.
	
// Buscamos combinaciones 3 fichas horizontal  (xxo x)	
+!buscar3derH(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if(X < N-2 & steak(C1,X+1,Y) & C == C1 & steak(C2,X+3,Y) & C == C2){
		.send(judge,tell,exchange(X+3,Y,X+2,Y));
		.print("Quiero cambiar (", X+3, ",", Y, ") por (", X+2, ",", Y, ") )");
	}else{
		.print("No hay combinacion de 3 horizontal");
	}.	
	
// Buscamos combinaciones 3 fichas vertical  (xoxx)	
+!buscar3arribaV(X,Y) :  sizeof(N) & steak(C,X,Y)  
	<-
	if( Y < N-2  & steak(C1,X,Y+2) & C == C1 & steak(C2,X,Y+3) & C == C2){
		.send(judge,tell,exchange(X,Y,X,Y+1));
		.print("Quiero cambiar (", X, ",", Y, ") por (", X, ",", Y+1, ") )");
	}else{
		.print("No hay combinacion de 3 vertical");
	}.	

// Buscamos combinaciones 3 fichas vertical  (xxox)	
+!buscar3abajoV(X,Y) :  sizeof(N) & steak(C,X,Y)   
	<-
	if( Y < N-2 & steak(C1,X,Y+1) & C == C1 & steak(C2,X,Y+3) & C == C2){
		//.send(judge,tell,exchange(X,Y+3,X,Y+2))
		+abajo3V(X,Y);
		.print("Quiero probar cambiar (", X, ",", Y+3, ") por (", X, ",", Y+2, ") )");
	}else{
		//false;
		.print("No hay combinacion de 3 vertical en: ", X, ",", Y);
	}.	
	
/*----------------------------FIN COMBINACIONES DE 3----------------------------*/	
/*********************************************************************************/

/*********---------- RECORRER TABLERO--------------------***********/

+!recorrerTablero : sizeof(N) <-

	for(.range(X,1,N)){
		for(.range(Y,1,N)){
			//!buscarCatedroH(X,Y);	
			!buscar3abajoV(X,Y);
			
		}
	}
		?turn(X2)[source(judge)];
		.print("Hola2---------------------------------------------------------------------------------", X2);
		
		for(.range(X,1,N)){
			for(.range(Y,1,N)){
		
			if(catedroH(X,Y)){
				.send(judge,tell,exchange(X+2,Y+1,X+2,Y));
				.print("Quiero cambiar (", X+2, ",", Y+1, ") por (", X+2, ",", Y, ") )");
				-catedroH(X,Y);
				
			}else{
			
				if(abajo3V(X,Y)){
					.send(judge,tell,exchange(X,Y+3,X,Y+2));
					.print("Quiero cambiar (", X, ",", Y+3, ") por (", X, ",", Y+2, ") )");
					-abajo3V(X,Y);
					
				}
			}
			
			/*else{
				if(buscarCatedroV(X,Y)){
					!buscarCatedroV(X,Y);
				}else{
					if(buscarCompradorV(X,Y)){
						!buscarCompradorV(X,Y);
					}else{
						if(buscarCompradorVinvertido(X,Y)){
							!buscarCompradorVinvertido(X,Y);
						}else{			
							if(buscarCompradorH(X,Y)){
								!buscarCompradorH(X,Y);
							}else{
								if(buscarCompradorHinvertido(X,Y)){
									!buscarCompradorHinvertido(X,Y);
								}else{
									if(buscarGestorDerAbajo(X,Y)){
										!buscarGestorDerAbajo(X,Y);
									}else{
										if(buscarGestorIzqAbajo(X,Y)){
											!buscarGestorIzqAbajo(X,Y);
										}else{
											if(buscarGestorIzqArriba(X,Y)){
												!buscarGestorIzqArriba(X,Y);
											}else{
												if(buscarGestorDerArriba(X,Y)){
													!buscarGestorDerArriba(X,Y);
												}else{
													!buscar3izqH(X,Y)}
			//!buscar3derH(X,Y);
			}
			}
			}
			}
			}
			}
			}
			}
			}*/
		}
		
	}
.
