`timescale		1ns/1ns

module	key_pulse_tb;

reg				clk;
reg				rst_n;
reg				key_in;

wire	[3:0]	sum;				//有效按键次数计数器

initial
	begin
		clk		=	0;
		rst_n	=	0;
		key_in	=	1;
		#1000	rst_n	=	1;
		
//--------------模拟按键动作----------------------		
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		#1000	key_in	=	0;
		#1000	key_in	=	1;
		
	end
	
always	#10 	clk	=	~clk;

key_pulse	key_pulse_inst(
	.clk				(clk),
	.rst_n				(rst_n),
	.key_in				(key_in),
	.sum				(sum)
);

endmodule