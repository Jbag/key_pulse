module		key(
	input				clk,
	input				rst_n,
	input				key_in,
	output	reg	[3:0]	sum
);

//累计按键低电平次数
always	@(posedge	clk	or	negedge	rst_n)
	begin
		if(!rst_n)
			begin
				sum	<=	0;
			end
		else
			begin
				if(!key_in)
					sum	<=	sum	+1'b1;
			end
	end

endmodule