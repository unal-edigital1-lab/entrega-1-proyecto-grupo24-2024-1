module Tamaguchi (
	input             clk,
	
	input botoncurar,
	input botonalimentar,
	input botonlimpiar,
	input botondormir,
	
	input botontest,
	input botonreset,
	
	input botonacelerador,
	
	input botoncercania,
	
	input echo,
	input claridad,
	
	
	output  pinout,
	output [7:0] anodos,
	output [6:0] display,
	output ledclaridad,
	output ledcercania,
	output trig
);

//wires del transmisor de imagen
wire senddata;
wire done;

//wire estado tamaguchi
wire [3:0] estado;
wire dormido;


//wire direccion memoria
wire [3:0] adress;

//wire datos de memoria
wire [63:0] data;

//wires de necesidades
wire [2:0] salud;
wire [2:0] alimentacion;
wire [2:0] energia;
wire [2:0] entretenimiento;
wire [2:0] higiene;

//wires botones con antirrebote
wire debbotoncurar;
wire debbotonalimentar;
wire debbotondormir;
wire debbotonlimpiar;
wire debbotonreset;
wire debbotontest;
wire debbotonacelerador;
wire debbotoncercania;

wire cercania;

wire cercaniasensor;


//wires control de velocidad
wire pasosegundo;
wire [2:0] velocidad;

//wire puntuacion
wire[13:0]puntuacion;


assign ledclaridad = ~claridad;
assign ledcercania = ~cercania;

assign cercania = cercaniasensor | debbotoncercania;


//antirrebotes
debounce antirrebotesalud(botoncurar, clk, debbotoncurar);
debounce antirrebotealimento(botonalimentar, clk, debbotonalimentar);
debounce antirrebotedormir(botondormir, clk, debbotondormir);
debounce antirrebotelimpiar(botonlimpiar, clk, debbotonlimpiar);
debounce antirrebotereset(botonreset, clk, debbotonreset);
debounce antirrebotetest(botontest, clk, debbotontest);
debounce antirreboteacelerador(botonacelerador, clk, debbotonacelerador);
debounce antirrebotecercania(botoncercania, clk, debbotoncercania);

//instanciar modulos
Transmisor trans (clk, senddata, pinout, done);
ImageControl controlimagen (clk, estado, done,data, salud, alimentacion, energia, entretenimiento, higiene, senddata, adress);
StateLogic logica(clk, salud, alimentacion, energia, entretenimiento, higiene, dormido, estado);
ROManimation memoria(adress, clk, data);
controlprincipal control(clk, debbotoncurar, debbotonalimentar, debbotonlimpiar, debbotondormir, debbotontest, debbotonreset, estado,  cercania, claridad, pasosegundo, salud, alimentacion, energia, entretenimiento, higiene, dormido);
timecontrol controltiempo(clk, debbotonacelerador, pasosegundo, velocidad);
visualizacion segmentos(clk, velocidad, puntuacion, display, anodos);
controlpuntuacion timecontrolp(clk,salud, alimentacion, energia, entretenimiento, higiene, debbotonreset,debbotontest, puntuacion);

ultrasonido driver(clk, echo, trig, cercaniasensor);
endmodule