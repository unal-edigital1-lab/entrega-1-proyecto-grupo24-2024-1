module needcomparator (

	 input [6:0] contadorpixel,
	 input [2:0] salud,
	 input [2:0] alimentacion,
	 input [2:0] energia,
	 input [2:0] entretenimiento,
	 input [2:0] higiene,
    output reg [23:0] colorout               
);

always @(*) begin
    case (contadorpixel)
        7'b1000000:begin
				if(salud >= 0)begin colorout<=24'h00ff00;end//rojo
				else begin colorout<=24'h000000;
				end
			end
		  7'b1000001:begin
			if(salud >= 1)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000010:begin
			if(salud >= 2)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000011:begin
			if(salud >= 3)begin colorout<=24'h00ff00;end
			else  begin colorout<=24'h000000;end
		  end
		  7'b1000100:begin
			if(salud >= 4) begin colorout<=24'h00ff00; end
			else colorout<=24'h000000;
		  end
		  7'b1000101:begin
			if(salud >= 5)begin colorout<=24'h00ff00; end
			else begin colorout<=24'h000000; end
		  end
		  7'b1000110:begin
			if(salud >= 6)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  7'b1000111:begin
			if(salud >= 7)begin colorout<=24'h00ff00;end
			else begin colorout<=24'h000000;end
		  end
		  
		  
		  
		  7'b1001000:begin
				if(alimentacion >= 0)colorout<=24'hffff00;//amarillo
				else colorout<=24'h000000;
		  end
		  7'b1001001:begin
				if(alimentacion >= 1)colorout<=24'hffff00;
				else colorout<=24'h000000;
		  end
		  7'b1001010:begin
			if(alimentacion >= 2)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001011:begin
			if(alimentacion >= 3)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001100:begin
			if(alimentacion >= 4)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001101:begin
			if(alimentacion >= 5)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001110:begin
			if(alimentacion >= 6)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  7'b1001111:begin
			if(alimentacion >= 7)colorout<=24'hffff00;
			else colorout<=24'h000000;
		  end
		  
		  
		  
		  
		  7'b1011000:begin
			if(energia >= 0)colorout<=24'hff0000;//verde
			else colorout<=24'h000000;
		  end
		  7'b1011001:begin
			if(energia >= 1)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011010:begin
			if(energia >= 2)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011011:begin
			if(energia >= 3)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011100:begin
			if(energia >= 4)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011101:begin
			if(energia >= 5)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011110:begin
			if(energia >= 6)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  7'b1011111:begin
			if(energia >= 7)colorout<=24'hff0000;
			else colorout<=24'h000000;
		  end
		  
		  
		  7'b1100000:begin
			if(entretenimiento >= 0)colorout<=24'h25ff00;//naranja
			else colorout<=24'h000000;
		  end
		  7'b1100001:begin
			if(entretenimiento >= 1)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100010:begin
			if(entretenimiento >= 2)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100011:begin
			if(entretenimiento >= 3)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100100:begin
			if(entretenimiento >= 4)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100101:begin
			if(entretenimiento >= 5)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100110:begin
			if(entretenimiento >= 6)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  7'b1100111:begin
			if(entretenimiento >= 7)colorout<=24'h25ff00;
			else colorout<=24'h000000;
		  end
		  
		  
		  
		  
		  7'b1110000:begin
			if(higiene >= 0)colorout<=24'hb70cf2;//blanco
			else colorout<=24'h000000;
		  end
		  7'b1110001:begin
			if(higiene >= 1)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110010:begin
			if(higiene >= 2)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110011:begin
			if(higiene >= 3)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110100:begin
			if(higiene >= 4)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110101:begin
			if(higiene >= 5)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110110:begin
			if(higiene >= 6)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  7'b1110111:begin
			if(higiene >= 7)colorout<=24'hb70cf2;
			else colorout<=24'h000000;
		  end
		  
        default: colorout = 0;  
		 
		 
    endcase
end

endmodule