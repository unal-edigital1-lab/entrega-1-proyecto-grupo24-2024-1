module StateLogic (
	input             clk,
	input [2:0] salud,
	input [2:0] alimentacion,
	input [2:0] energia,
	input [2:0] entretenimiento,
	input [2:0] higiene,
	input dormido,
	output reg [3:0] estado
	
);

parameter BIEN = 4'b0000;
parameter EXCELENTE = 4'b0001;
parameter CANSADO = 4'b0010;
parameter DORMIDO = 4'b0011;
parameter HAMBRIENTO = 4'b0100;
parameter ENFERMO = 4'b0101;
parameter ABURRIDO = 4'b0110;
parameter SUCIO = 4'b0111;
parameter DESOLADO = 4'b1000;
parameter DEPRESION = 4'b1001;
parameter MUERTE = 4'b1010;

reg [2:0] desolated;
reg [2:0] dead;
reg [2:0] depretion;
reg [5:0] excelent;

wire a,b,c,d,e,f,g,h,i,j,k,l,m,n,o;

assign a = (energia < 5)?1'b1:1'b0;
assign b = (alimentacion < 5)?1'b1:1'b0;
assign c = (salud < 5)?1'b1:1'b0;
assign d = (higiene < 5)?1'b1:1'b0;
assign e = (entretenimiento < 5)?1'b1:1'b0;

assign f = (energia < 3)?1'b1:1'b0;
assign g = (alimentacion < 3)?1'b1:1'b0;
assign h = (salud < 3)?1'b1:1'b0;
assign i = (higiene < 3)?1'b1:1'b0;
assign j = (entretenimiento < 3)?1'b1:1'b0;

assign k = (energia < 2)?1'b1:1'b0;
assign l = (alimentacion < 2)?1'b1:1'b0;
assign m = (salud < 2)?1'b1:1'b0;
assign n = (higiene < 2)?1'b1:1'b0;
assign o = (entretenimiento < 2)?1'b1:1'b0;

initial begin
	estado <= 0;
	desolated <= 0;
	dead <= 0;
	depretion <= 0;
	excelent <= 0;
end


always @(posedge clk)begin

		

		desolated <= f + g + h + i + j;
		dead <= k + l + m + n + o;
		depretion <= a + b + c + d + e;
		excelent <= salud + alimentacion + energia + entretenimiento + higiene;
		
		if(dormido == 1)begin
			estado <= DORMIDO;
		end
		else begin
			if(dead >= 4)begin 
					estado <= MUERTE;
			end
			else begin
				if(desolated >= 3)begin
					estado <= DESOLADO;
				end
				else begin
				if(depretion >= 2)begin
					estado <= DEPRESION;
				end
				
					else begin
						if(b == 1)begin
							estado <= HAMBRIENTO;
						end
						else begin
							if(c == 1)begin
								estado <= ENFERMO;
							end
							else begin
								if(d == 1)begin
									estado <= SUCIO;
								end
								else begin
									if(e == 1)begin
										estado <= ABURRIDO;
									end
									else begin
										if(a == 1)begin
											estado <= CANSADO;
										end
										else begin
											if(excelent == 35)begin
												estado <= EXCELENTE;
											end
											else begin
												estado <= BIEN;
											end
										end
									end
								end
							end
						end
					end
				end			
			end
		end
end

					 
endmodule