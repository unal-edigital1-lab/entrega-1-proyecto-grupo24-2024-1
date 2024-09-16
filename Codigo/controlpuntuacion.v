module controlpuntuacion(
	input clk,
	input [2:0] salud,
	input [2:0] alimentacion,
	input [2:0] energia,
	input [2:0] entretenimiento,
	input [2:0] higiene,
	input botonreset,
	input botontest,
	output reg [13:0]puntuacion
);

reg[27:0]countreset;
reg[27:0]counttest;
reg[25:0]contador;
//codigo para el bonus
wire [5:0] total;
wire bonus;
assign total = salud + alimentacion + energia + entretenimiento + higiene;
assign bonus = (total == 35)?1'b1:1'b0;

//banderas para la disminucion de puntos
wire lostsalud;
wire lostalimentacion;
wire lostenergia;
wire lostentretenimiento;
wire losthigiene;

assign lostsalud = (salud <= 2)?1'b1:1'b0;
assign lostalimentacion = (alimentacion <= 2)?1'b1:1'b0;
assign lostenergia = (energia <= 2)?1'b1:1'b0;
assign lostentretenimiento = (entretenimiento <= 2)?1'b1:1'b0;
assign losthigiene = (higiene <= 2)?1'b1:1'b0;

wire [2:0]puntosperdidos;
assign puntosperdidos = lostsalud+ lostalimentacion + lostenergia+ lostentretenimiento + losthigiene;

wire deadsalud;
wire deadalimentacion;
wire deadenergia;
wire deadentretenimiento;
wire deadhigiene;

assign deadsalud = (salud == 0)?1'b1:1'b0;
assign deadalimentacion = (alimentacion == 0)?1'b1:1'b0;
assign deadenergia = (energia == 0)?1'b1:1'b0;
assign deadentretenimiento = (entretenimiento == 0)?1'b1:1'b0;
assign deadhigiene = (higiene == 0)?1'b1:1'b0;

wire [2:0]totalmalaracha;
assign totalmalaracha = deadsalud+ deadalimentacion + deadenergia+ deadentretenimiento + deadhigiene;

wire [2:0]negativebonus;
assign negativebonus = (totalmalaracha>=2)?3'b101:3'b000;

wire [3:0]totalpuntosperdidos;
assign totalpuntosperdidos = negativebonus + puntosperdidos;

//banderas para el pulso de una vez
reg banderabonus;
reg banderasalud;
reg banderaalimentacion;
reg banderaenergia;
reg banderaentretenimiento;
reg banderahigiene;

initial begin
countreset <= 250000000;
counttest <= 250000000;

banderabonus <= 0;

banderasalud <= 1;
banderaalimentacion <= 1;
banderaenergia <= 1;
banderaentretenimiento <= 1;
banderahigiene <= 1;

contador <= 0;

puntuacion <= 0;
end



always @(posedge clk)begin
	//
	//funcionamiento del boton reset
	if(botonreset == 1)begin
		if(countreset == 0)puntuacion<=0;
		else countreset<=countreset-1'b1;
	end
	else countreset <=250000000;
	//
	//funcionamiento del boton test
	if(botontest == 1)begin
		if(counttest == 0)puntuacion<=0;
		else counttest<=counttest-1'b1;
	end
	else counttest <=250000000;
	//
	//funcionamiento bonus
	if(bonus == 1)begin
		if(banderabonus == 0)begin
			banderabonus <= 1;
			if(puntuacion <= 9994)puntuacion <= puntuacion + 5;
			else puntuacion<= 9999;
		end
	end
	else banderabonus <= 0;
	//
	//funcionamiento banderas up;
	if(salud >= 6)begin
		if(banderasalud == 0)begin
			banderasalud <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderasalud <= 0;
	//
	if(alimentacion >= 6)begin
		if(banderaalimentacion == 0)begin
			banderaalimentacion <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderaalimentacion <= 0;
	//
	if(energia >= 6)begin
		if(banderaenergia == 0)begin
			banderaenergia <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderaenergia <= 0;
	//
	if(entretenimiento >= 6)begin
		if(banderaentretenimiento == 0)begin
			banderaentretenimiento <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderaentretenimiento <= 0;
	//
	if(higiene >= 6)begin
		if(banderahigiene == 0)begin
			banderahigiene <= 1;
			if(puntuacion < 9999)puntuacion <= puntuacion + 1'b1;
		end
	end
	else banderahigiene <= 0;
	//
	if(contador >= 50000000)begin
		contador <= 0;
		if(puntuacion >= totalpuntosperdidos)puntuacion <= puntuacion - totalpuntosperdidos;
		else puntuacion <= 0;
	end
	else contador <= contador + 1'b1;
end

endmodule