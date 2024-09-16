module ROManimation  (
	input[3:0] adress,
   input clk,
   output reg[63:0] dataout
);


always @(*) begin
	case(adress)
		4'b0000: dataout<= 64'h667e426a437f3f66; //animación 1
		4'b0001: dataout<= 64'h667e4256c2fefc66; //animación 2
		4'b0010: dataout<= 64'h667e426a6b7f3f66; //animación 3
		4'b0011: dataout<= 64'h667e4256d6fefc66; //animación 4
		4'b0100: dataout<= 64'h667e4242427e3c66; //animación 5
		default: dataout<= 64'hffffffffffffffff;
	endcase
end


endmodule