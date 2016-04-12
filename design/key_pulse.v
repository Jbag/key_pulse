/*********************************************
****基于尖峰脉冲的边缘检测
*********************************************/
module		key_pulse(
	input				clk,
	input				rst_n,
	input				key_in,							//外部按键输入
	output	reg [3:0]	sum								//按键次数计数器
);

	reg		[10:0]		cnt;							//消抖延时计数器
	reg					state;							//状态寄存器
	reg					flag_pos;						//尖峰脉冲寄存器

//------------按键消抖以后产生尖峰脉冲-----------------	
always	@(posedge	clk	or	negedge	rst_n)
	begin
		if(!rst_n)
			begin
				cnt			<=	0;						//消抖延时计数器清零		
				state		<=	0;						//状态寄存器清零	
				flag_pos	<=	0;						//尖峰脉冲寄存器清零		
			end
		else
			begin
				case(state)
					0:	begin
							if(cnt	<	10)						//消抖延时计数器开始计数，计数器计数未满
								begin
									if(!key_in)					//key_in==0，说明有按键按下
										begin
											cnt	<=	cnt +1'b1;	//有按键按下，计消抖延时数器就开始计数
										end
									else						//按键没有按下，说明按键放开，而计数器未满，说明按键有“抖动”
										begin
											cnt	<=	0;			//消抖延时计数器清零
										end
								end
							else								//消抖延时计数器计数满，说明确定有按键按下
								begin
									flag_pos	<=	1;			//尖峰脉冲寄存器置位
									cnt			<=	0;			//状态寄存器清零
									state		<=	1;			//返回为1状态
								end
						end
					1:	begin
							flag_pos	<=	0;					//尖峰脉冲寄存器电平拉低
							if(key_in)							//key_in==1，按键放开（说明一次按键动作完整结束）
								state	<=	0;					//返回为0状态，等待下次按键到来
						end
					default:	state	<=	0;					//默认进入0状态
				endcase
			end
	end

//----------------累计尖峰脉冲出现次数--------------------------
always	@(posedge	clk	or	negedge	rst_n)
	begin
		if(!rst_n)
			begin
				sum	<=	0;										//按键计数器清零
			end
		else
			begin
				if(flag_pos)									//尖峰脉冲寄存器==1，说明按键按下
					sum	<=	sum	+1'b1;							//按键不断计数累加
			end	
	end

endmodule