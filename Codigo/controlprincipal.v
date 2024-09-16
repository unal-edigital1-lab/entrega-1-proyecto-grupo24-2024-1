module controlprincipal(
	input clk,
	
	//botones
	input botoncurar,
	input botonalimentar,
	input botonlimpiar,
	input botondormir,
	input botontest,
	input botonreset,
	
	//estado del tamaguchi
	input [3:0] estado,
	
	//banderas de sensores
	input cercania,
	input claridad,
	
	//temporizador de paso de tiempo
	
	input passsecond,
	
	output reg [2:0]salud,
	output reg [2:0]alimentacion,
	output reg [2:0]energia,
	output reg [2:0]entretenimiento,
	output reg [2:0]higiene,
	
	output reg dormido
);


//contadores para disminuir automaticamente las necesidades
reg [9:0] countsalud;
reg [9:0] counthigiene;
reg [9:0] countalimentacion;
reg [9:0] countenergia;
reg [9:0] countentretenimiento;

reg [9:0] countdormir;
reg [5:0] contadorjuego;
//contadores para conteo de 5 segundos reset y test
reg [27:0]countreset;
reg [27:0]counttest; //contar hasta 250.000.000

//banderas para simular el pulso de subida de cada circuito
reg banderapasotiempo;
reg banderacurar;
reg banderaalimentar;
reg banderalimpiar;
reg banderadormir;
reg banderacercania;
reg banderatest;


//modo de operacion
reg mode;

parameter normal=1'b0;
parameter test=1'b1;


initial begin
	salud<=6;
	alimentacion <=6;
	energia <= 6;
	entretenimiento <=6;
	higiene <=6;
	dormido <= 0;
	countsalud <= 0;
	counthigiene <= 0;
	countalimentacion <= 0;
	countenergia <= 0;
	countentretenimiento <= 0;
	countdormir <= 0;
	mode <= 0;
	
	countreset <= 0;
	counttest <= 0;
	contadorjuego <= 0;
	
	banderapasotiempo <= 0;
	banderacurar <= 0;
	banderaalimentar <= 0;
	banderalimpiar <= 0;
	banderadormir <= 0;
	banderacercania <= 0;
	banderatest <= 0;
end
//
//bloque para conteo de reset y test, y otros
always @(posedge clk)begin
	//
	//bloque de funcionamiento del paso de segundo
	if(passsecond == 1)begin
		if(banderapasotiempo == 0)begin
			banderapasotiempo <= 1;
			if(mode == 0)begin
				
		if(higiene < 5)begin
			if(countsalud < 599)begin
				countsalud <= countsalud + 1'b1;
			end
			else begin
				countsalud <= 0;
				if(salud > 0)salud <= salud - 1'b1;
			end
		end
		else begin
			if(countsalud < 299)begin
				countsalud <= countsalud + 1'b1;
			end
			else begin
				countsalud <= 0;
				if(salud > 0)salud <= salud - 1'b1;
			end
		end
		
		
		if(counthigiene < 419)begin
			counthigiene <=counthigiene + 1'b1;
		end
		else begin
			counthigiene <= 0;
			if(higiene > 0)higiene <= higiene - 1'b1;
		end
			
		if(countalimentacion < 299)begin	
			countalimentacion <=countalimentacion + 1'b1;
		end
		else begin
			countalimentacion <=0;
			if(alimentacion > 0)alimentacion <= alimentacion - 1'b1;
		end
		
		if(countenergia < 419)begin
			countenergia <=countenergia + 1'b1;
		end
		else begin
			countenergia <= 0;
			if(energia > 0)energia <= energia - 1'b1;
		end
		
		if(countentretenimiento < 179)begin
			countentretenimiento <=countentretenimiento + 1'b1;
		end
		else begin
			countentretenimiento <= 0;
			if(entretenimiento > 0)entretenimiento <= entretenimiento - 1'b1;
		end
		
		if(dormido == 1)begin
			if(countdormir >= 59)begin
				countdormir <= 0;
				if(energia < 7)energia <= energia + 1'b1;
			end
			else begin
				countdormir <= countdormir + 1'b1;
			end
			countenergia <= 0;
		end
		else begin
			countdormir <= 0;
		end
		
	end
		end
	end
	else begin
		banderapasotiempo <= 0;
	end
	//
	//bloque originalidad normal y funcionamiento test
	if(mode == 0)begin
	//
	//bloque funcionamiento reset
		if(claridad == 1)begin dormido <= 0; countdormir <= 0;end
		if(cercania == 1)begin dormido <= 0;countdormir <= 0;end
		if(salud < 5)begin dormido <= 0;countdormir <= 0;end
		if(alimentacion < 5)begin dormido <= 0;countdormir <= 0;end
		if(energia == 7)begin dormido <= 0;countdormir <= 0;end
		if(botontest == 1)begin
			if(counttest >= 250000000)begin
				mode <= 1;
				counttest <= 0;
			end
			else begin
				counttest <= counttest + 1'b1;
			end
		end
		else begin
			counttest <= 0;
		end
	end

	if(botonreset == 1)begin
			if(countreset >= 250000000)begin
			
				mode <= 0;
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
				countsalud <= 0;
				counthigiene <= 0;
				countalimentacion <= 0;
				countenergia <= 0;
				countentretenimiento <= 0;
				countdormir <= 0;
				contadorjuego <= 0;
				countreset <= 0;
				
			end
			else begin
				countreset <= countreset + 1'b1;
			end
	end
	else begin
		countreset <= 0;
	end

	
	
	//
	//bloque curar
	if(botoncurar == 1)begin
		if(banderacurar == 0)begin
			banderacurar <= 1;
			if(mode == 0)begin
			if(dormido == 0)begin
				if(cercania == 1)begin
					if(salud < 6)begin
						salud <= salud + 2'b10;
					end
					else begin
						if(salud < 7)begin
							salud <= salud + 1'b1;
						end
					end
				end
				else begin
					if(salud < 7)salud <= salud + 1'b1;
				end
				countsalud <= 0;
			end
			end
		end
	end
	else begin
		banderacurar <= 0;
	end
	//
	//bloque alimentar
	if(botonalimentar == 1)begin
		if(banderaalimentar == 0)begin
			banderaalimentar <= 1;
			if(mode == 0)begin
			if(dormido == 0)begin
				if(salud >= 5)begin
					if(claridad == 1)begin
						if(alimentacion < 6)begin
							alimentacion <= alimentacion + 2'b10;
						end
						else begin
							if(alimentacion < 7)begin
								alimentacion <= alimentacion + 1'b1;
							end
						end
					end
					else begin
						if(alimentacion < 7)alimentacion <= alimentacion + 1'b1;
					end
					countalimentacion<= 0;
			
				end
			end
			end
		end
	end
	else begin
		banderaalimentar <= 0;
	end
	//
	//bloquelimpiar
	if(botonlimpiar == 1)begin
		if(banderalimpiar == 0)begin
			banderalimpiar <= 1;
			if(mode == 0)begin
			if(dormido == 0)begin
				if(higiene < 7)begin 
					higiene <= higiene + 1'b1;
				end
				counthigiene <= 0;
			end
			end
		end
	end
	else begin
		banderalimpiar <= 0;
	end
	//
	//bloque dormir
	if(botondormir == 1)begin
		if(banderadormir == 0)begin
			banderadormir <= 1;
			if(mode == 0)begin
		if(claridad == 0)begin
			if(cercania == 0)begin
				if (salud > 4)begin
					if(alimentacion > 4)begin
						dormido <= 1;
					end
				end
			end
		end
	end
		end
	end
	else begin
		banderadormir <= 0;
	end
	//
	//bloque cercania
	if(cercania == 1)begin
		if(banderacercania == 0)begin
			banderacercania <= 1;
			if(salud >4)begin
		if(alimentacion >4)begin
			if(energia >4)begin
				if(contadorjuego > 1)begin
					contadorjuego <= 0;
					if(entretenimiento < 7)entretenimiento <= entretenimiento + 1'b1;
					countentretenimiento <= 0;
				end
				else begin
					contadorjuego <= contadorjuego + 1'b1;
				end
			end
		end
	end
		end
	end
	else begin
		banderacercania <= 0;
	end
	//
	//bloque test
	if(botontest == 1)begin
		if(banderatest == 0)begin
			banderatest <= 1;
			if(mode == 1)begin
				case(estado)
					4'b0000:begin
							salud<=7;
				alimentacion <=7;
				energia <= 7;
				entretenimiento <=7;
				higiene <=7;
				dormido <= 0;
			end
			4'b0001:begin
				salud<=6;
				alimentacion <=6;
				energia <= 4;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
			4'b0010:begin
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 1;
			end
			4'b0011:begin
				salud<=6;
				alimentacion <=4;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
			4'b0100:begin
				salud<=4;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
			4'b0101:begin
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=4;
				higiene <=6;
				dormido <= 0;
			end
			4'b0110:begin
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=4;
				dormido <= 0;
			end
			4'b0111:begin
				salud<=2;
				alimentacion <=2;
				energia <= 2;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
			4'b1000:begin
				salud<=1;
				alimentacion <=1;
				energia <= 1;
				entretenimiento <=1;
				higiene <=6;
				dormido <= 0;
			end
			4'b1010:begin
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
			default:begin
				salud<=6;
				alimentacion <=6;
				energia <= 6;
				entretenimiento <=6;
				higiene <=6;
				dormido <= 0;
			end
		endcase
	end
		end
	end
	else begin
		banderatest <= 0;
	end
end



endmodule