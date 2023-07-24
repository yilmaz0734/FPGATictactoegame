module game_logic(

	input clk,
	input button0,
	input button1,
	input actbutton,
	output reg [199:0]board_out,
	output reg [2:0]tri_score,
	output reg [3:0]tri_move_num,
	output reg [3:0]cir_move_num,
	output reg [2:0]cir_score,
	output reg whose_turn
	); 
	
	
// OUTPUTS

reg [3:0]xcoor;
reg [3:0]ycoor;
reg [4:0] total_move_num;
reg [7:0] recent_move_tri;
reg [7:0] recent_move_cir;
reg [32:0]delay_counter;



reg [3:0] temper;
reg temper_two;

	
	
// GAME LOGIC	

reg [1:0]state;
reg [7:0]move_records_tri[0:2];
reg [7:0]move_records_cir[0:2];
parameter IDLE = 2'b00;
parameter TRIPLAYS = 2'b01;
parameter CIRPLAYS = 2'b10;
reg player_turn;
reg is_won;
reg is_idle;
integer k;
integer m;
integer i;
integer n;
integer s;

//DEBOUNCER

reg debounced_act_button;
reg [7:0]button0_counter;
reg [7:0]button1_counter;
reg [7:0]actbutton_counter; // counters for debouncing
reg [7:0]xy; // x and y coordinate inverse

// WINNING_checker

reg result;
reg [3:0]resultx;
reg [3:0]resulty;


initial begin

	//GAME LOGIC
	
	delay_counter = 0;
	state = IDLE;
	is_idle = 1;
	is_won = 0;
	player_turn = 0;
	temper = 4'b0000;
	temper_two = 0;
	xcoor = 4'b1111;
	ycoor = 4'b1111;
	
	board_out = 199'b0;
	
	//DEBOUNCER
	
	button0_counter = 0;
	button1_counter = 0;
	actbutton_counter = 0;
	debounced_act_button= 0;
	
	//WINNING CHECKER
	
	result = 0;
	resultx = 4'b1111;
	resulty = 4'b1111;
	
end 


always @(posedge clk)
		begin	

	// WINNING CHECKER
	// WINNING CHECKER				
	// WINNING CHECKER
	
	
		if(is_idle == 1)
			begin
				resultx <= 4'b1111;
				resulty <= 4'b1111;
			end
			
		for(i=0;i<195;i=i+2)
			begin
				if (board_out[199-i] ^ board_out[198-i])
					begin
					//horizontal check
					if((board_out[199-i]==board_out[197-i]) && (board_out[198-i]==board_out[196-i]) && (board_out[199-i]==board_out[195-i]) && board_out[198-i]==board_out[194-i] && (i%20<16))
						begin
							result <= 1;
							resultx <= i/20;
							resulty <= (i%20)/2+1;
						end
					
					if(i<160)
					
						begin
							//vertical check
							if((board_out[199-i]==board_out[179-i]) && (board_out[198-i]==board_out[178-i]) && (board_out[199-i]==board_out[159-i]) && board_out[198-i]==board_out[158-i])
								begin
									result <= 1;
									resultx <= i/20+1;
									resulty <= (i%20)/2;
								end
							
						end
					if(i<155)
						begin
							//diagonal left-right
							if((board_out[199-i]==board_out[177-i]) && (board_out[198-i]==board_out[176-i]) && (board_out[199-i]==board_out[155-i]) && board_out[198-i]==board_out[154-i] && (i%20<16))
								begin
									result <= 1;
									resultx <= i/20+1;
									resulty <= (i%20)/2+1;
								end
			
						end
					
				
					if(i<159)
					
							//diagonal right-left
						if((board_out[199-i]==board_out[181-i]) && (board_out[198-i]==board_out[180-i]) && (board_out[199-i]==board_out[163-i]) && board_out[198-i]==board_out[162-i] && (i%20>3))
							begin
								result <= 1;
								resultx <= i/20+1;
								resulty <= (i%20)/2-1;
							end
				
				
					
				end
					
		end
	
	

	
	
	
	// DEBOUNCER
	// DEBOUNCER
	// DEBOUNCER
	

	
	
	
	if(button0 == 0 && button0_counter < 'd100) 
		begin
			button0_counter <= button0_counter + 'd1 ;
		end
		
	else if (button0 ==1) 
		begin
			button0_counter <= 'd0;
		end
		

	if(button1 == 0 && button1_counter < 'd100) 
		begin	
			button1_counter <= button1_counter + 'd1 ;
		end
		
	else if (button1 ==1) 
		begin
			button1_counter <= 'd0;
		end
		
	if(actbutton == 0 && actbutton_counter < 'd100) 
		begin
			actbutton_counter <= actbutton_counter + 'd1 ;
			end
		
	else if (actbutton ==1) 
		begin
			actbutton_counter <= 'd0;
		end
		
		
	if (button0_counter == 'd5 && button0 == 0 ) 
		begin
			xy = xy << 1;
			xy = {xy[7:1],1'b0};
		end

	if (button1_counter == 'd5 && button1 == 0 ) 
		begin
			xy = xy << 1;
			xy = {xy[7:1],1'b1};
		end


	if (actbutton_counter == 'd5 && actbutton == 0 ) 
		begin
			debounced_act_button <= 1;
		end
	else 
		begin
			debounced_act_button <=0;
		end
	if(debounced_act_button == 1)
		begin
			temper <= 4'b1111;
			xcoor <= {xy[0],xy[1],xy[2],xy[3]};
			ycoor <= {xy[4],xy[5],xy[6],xy[7]};
		end
	else
	begin 
			xcoor <= 4'b1111;
			ycoor <= 4'b1111;
	
	end
		
	if(is_idle == 1) 
		begin
			xcoor <= 4'b1111;
			ycoor <= 4'b1111;
		end
		
				
		
		
	// GAME STATES
	// GAME STATES
	// GAME STATES
		
		
		


	is_won <= result;
	
	
	
	case (state)
		IDLE: begin
														
							
							delay_counter <= delay_counter + 1;
							
							// board cleaner
							
							if(delay_counter==500000000)
								begin
									total_move_num <= 4'b0;
									cir_move_num <= 4'b0;
									tri_move_num <= 4'b0;
									recent_move_cir <= 8'b0;
									recent_move_tri <= 8'b0;
									is_idle <=0 ;
														
								
									delay_counter <= 0;
									board_out <= 199'b0;
									if (player_turn) 
										begin
											state <= CIRPLAYS;
										end
									
									else
										begin
											state <= TRIPLAYS;
										end
								end
							else
								begin
									board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
									board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
								end
				end
			
		TRIPLAYS: begin
							whose_turn <= 0;
							
							if (board_out[199-2*xcoor*10-(ycoor*2)]==0 && board_out[198-2*xcoor*10-(ycoor*2)]==0 && ((xcoor<4'b1010) && (ycoor<4'b1010))) 
								begin
									
									case (tri_move_num)
									
										4'b0000:	begin
													move_records_tri[0] <= {xcoor,ycoor};
													end
										4'b0001: begin
													move_records_tri[1] <= {xcoor,ycoor};
													end
										4'b0010: begin
													move_records_tri[2] <= {xcoor,ycoor};
													end
									endcase
									
									recent_move_tri <= {xcoor,ycoor};
									tri_move_num <= tri_move_num + 1;
									total_move_num <= total_move_num +1;
									
									board_out[199-2*xcoor*10-(ycoor*2)] <= 0;
									board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
									
									xcoor <= 4'b1111;
									ycoor <= 4'b1111;
									
									
									// horizontal
									if (is_won && ((xcoor==resultx && ycoor==resulty+4'b0010) || (xcoor==resultx && ycoor==resulty-4'b0010)) && total_move_num>3)
										begin
											state <= IDLE;
											is_idle <= 1;
											tri_score <= tri_score + 3'b001;
											player_turn <= 0;
											
											if (ycoor == resulty - 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+2)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+3)*2)] <= 1;
													
												end
											else if(ycoor == resulty + 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-2)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-3)*2)] <= 1;
												end
													
											
										end
									// vertical
									else if (is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty) || (xcoor==resultx-4'b0010 && ycoor==resulty)) && total_move_num>3)
										begin
											
						
											state <= IDLE;
											is_idle <= 1;
											tri_score = tri_score + 3'b001;
											player_turn <= 0;
											
											if (xcoor == resultx - 4'b0010)
												begin
												
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor+1)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor+3)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor)*2)] <= 1;
													
												end
											else if(xcoor == resultx + 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor-3)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor)*2)] <= 1;
												end
											
											
										end
									// diagonal left right
									else if ((is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty+4'b0010) || (xcoor==resultx-4'b0010 && ycoor==resulty-4'b0010))) && total_move_num>3)
										begin
								
											state <= IDLE;
											is_idle <= 1;
											tri_score = tri_score + 3'b001;
											player_turn <= 0;
											
											
											if (xcoor==resultx+4'b0010 && ycoor==resulty+4'b0010)
												begin
												
												
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor-2)*2)] <= 1;
													
													board_out[199-(2*(xcoor-3)*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor-3)*2)] <= 1;
													
												end
											else if(xcoor==resultx-4'b0010 && ycoor==resulty-4'b0010)
												begin
												
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor+1)*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor+2)*2)] <= 1;
												
													board_out[199-(2*(xcoor+3)*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor+3)*2)] <= 1;
												end
											
											
										end
									// diagonal right left
									else if ((is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty-4'b0010) || (xcoor==resultx-4'b0010 && ycoor==resulty+4'b0010))) && total_move_num>3)
											begin
												
											state <= IDLE;
											
											is_idle <= 1;
											tri_score = tri_score + 3'b001;
											player_turn <= 0;
											
											
											if (xcoor==resultx+4'b0010 && ycoor==resulty-4'b0010)
												begin
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor+2)*2)] <= 1;
													
													board_out[199-(2*(xcoor-3)*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor+3)*2)] <= 1;
													
												end
											else if(xcoor==resultx-4'b0010 && ycoor==resulty+4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
												
													board_out[199-(2*(xcoor+1)*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor-2)*2)] <= 1;
												
													board_out[199-(2*(xcoor+3)*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor-3)*2)] <= 1;
												end
				
										
											
											end
											
											
											
									else if(total_move_num == 24) 
										begin
											state <= IDLE;
											is_idle <= 1;
										end
									else
										begin
											state <= CIRPLAYS;
										end
									
									if( tri_move_num == 5)
										begin
											board_out[199-20*(move_records_tri[0][7:4])-2*(move_records_tri[0][3:0])] <= 1; 
											board_out[198-20*(move_records_tri[0][7:4])-2*(move_records_tri[0][3:0])] <= 1; 
										end
									if( tri_move_num == 9)
										begin
											board_out[199-20*(move_records_tri[1][7:4])-2*(move_records_tri[1][3:0])] <= 1; 
											board_out[198-20*(move_records_tri[1][7:4])-2*(move_records_tri[1][3:0])] <= 1;
										end
									if( tri_move_num == 11)
										begin
											board_out[199-20*(move_records_tri[2][7:4])-2*(move_records_tri[2][3:0])] <= 1; 
											board_out[198-20*(move_records_tri[2][7:4])-2*(move_records_tri[2][3:0])] <= 1; 
										end
										
								end
							
							else 
								begin
							
									state <= TRIPLAYS;
								
								end 

							end 
			
		CIRPLAYS: begin
							whose_turn <= 1;
							
							if ((board_out[199-2*xcoor*10-(ycoor*2)]==0 && board_out[198-2*xcoor*10-(ycoor*2)]==0) && ((xcoor<4'b1010) && (ycoor<4'b1010))) 
									begin
										
										case (cir_move_num)
										
											4'b0000: begin
														move_records_cir[0] <= {xcoor,ycoor};
														end
											4'b0001: begin
														move_records_cir[1] <= {xcoor,ycoor};
														end
											4'b0010: begin
														move_records_cir[2] <= {xcoor,ycoor};
														end
										endcase
										
										recent_move_cir <= {xcoor,ycoor};
										cir_move_num <= cir_move_num + 1;
										total_move_num <= total_move_num +1;

										board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
										board_out[198-2*xcoor*10-(ycoor*2)] <= 0;
										
										xcoor <= 4'b1111;
										ycoor <= 4'b1111;
											
										
										// horizontal
										if (is_won && ((xcoor==resultx && ycoor==resulty+4'b0010) || (xcoor==resultx && ycoor==resulty-4'b0010)) && total_move_num>3)
											begin
												state <= IDLE;
												cir_score <= cir_score + 3'b001;
												player_turn <= 1;
												is_idle <= 1;
												
												if (ycoor == resulty - 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+2)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor+3)*2)] <= 1;
													
												end
											else if(ycoor == resulty + 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-2)*2)] <= 1;
													
													board_out[199-(2*xcoor*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*xcoor*10+(ycoor-3)*2)] <= 1;
												end
											end
										// vertical
										else if (is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty) || (xcoor==resultx-4'b0010 && ycoor==resulty)) && total_move_num>3)
											begin
												state <= IDLE;
												cir_score = cir_score + 3'b001;
												player_turn <= 1;
												is_idle <= 1;
												
												if (xcoor == resultx - 4'b0010)
												begin
												
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor+1)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor+3)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor)*2)] <= 1;
													
												end
											else if(xcoor == resultx + 4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor)*2)] <= 1;
													
													board_out[199-(2*(xcoor-3)*10+(ycoor)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor)*2)] <= 1;
												end
											end
										// diagonal right left
										else if (is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty-4'b0010) || (xcoor==resultx-4'b0010 && ycoor==resulty+4'b0010)) && total_move_num>3)
											begin
												state <= IDLE;
												cir_score = cir_score + 3'b001;
												player_turn <= 1;
												is_idle <= 1;
												
												if (xcoor==resultx+4'b0010 && ycoor==resulty-4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor+2)*2)] <= 1;
													
													board_out[199-(2*(xcoor-3)*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor+3)*2)] <= 1;
													
												end
											else if(xcoor==resultx-4'b0010 && ycoor==resulty+4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor+1)*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor-2)*2)] <= 1;
												
													board_out[199-(2*(xcoor+3)*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor-3)*2)] <= 1;
												end
											
											
										end
												
												
			
										// diagonal left right
										else if (is_won && ((xcoor==resultx+4'b0010 && ycoor==resulty+4'b0010) || (xcoor==resultx-4'b0010 && ycoor==resulty-4'b0010)) && total_move_num>3)
											begin
												state <= IDLE;
												cir_score = cir_score + 3'b001;
												player_turn <= 1;
												is_idle <= 1;
												
												if (xcoor==resultx+4'b0010 && ycoor==resulty+4'b0010)
												begin
													
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor-1)*10+(ycoor-1)*2)] <= 1;
													board_out[198-(2*(xcoor-1)*10+(ycoor-1)*2)] <= 1;
													
													board_out[199-(2*(xcoor-2)*10+(ycoor-2)*2)] <= 1;
													board_out[198-(2*(xcoor-2)*10+(ycoor-2)*2)] <= 1;
												
													board_out[199-(2*(xcoor-3)*10+(ycoor-3)*2)] <= 1;
													board_out[198-(2*(xcoor-3)*10+(ycoor-3)*2)] <= 1;
													
												end
											else if(xcoor==resultx-4'b0010 && ycoor==resulty-4'b0010)
												begin
												
													board_out[199-2*xcoor*10-(ycoor*2)] <= 1;
													board_out[198-2*xcoor*10-(ycoor*2)] <= 1;
													
													board_out[199-(2*(xcoor+1)*10+(ycoor+1)*2)] <= 1;
													board_out[198-(2*(xcoor+1)*10+(ycoor+1)*2)] <= 1;
													
													board_out[199-(2*(xcoor+2)*10+(ycoor+2)*2)] <= 1;
													board_out[198-(2*(xcoor+2)*10+(ycoor+2)*2)] <= 1;
												
													board_out[199-(2*(xcoor+3)*10+(ycoor+3)*2)] <= 1;
													board_out[198-(2*(xcoor+3)*10+(ycoor+3)*2)] <= 1;
												end
				
										
									
										end
											
										else if(total_move_num == 24) 
											begin
												state <= IDLE;
												is_idle <= 1;
											end
										else
											begin
												state <= TRIPLAYS;
											end
										if( cir_move_num == 5)
											begin
												board_out[199-20*(move_records_cir[0][7:4])-2*(move_records_cir[0][3:0])] <= 1; 
												board_out[198-20*(move_records_cir[0][7:4])-2*(move_records_cir[0][3:0])] <= 1; 
											end
										if( cir_move_num == 9)
											begin
												board_out[199-20*(move_records_cir[1][7:4])-2*(move_records_cir[1][3:0])] <= 1;
												board_out[198-20*(move_records_cir[1][7:4])-2*(move_records_cir[1][3:0])] <= 1;
											end
										if( cir_move_num == 11)
											begin
												board_out[199-20*(move_records_cir[2][7:4])-2*(move_records_cir[2][3:0])] <= 1;
												board_out[198-20*(move_records_cir[2][7:4])-2*(move_records_cir[2][3:0])] <= 1;	
											end
											
											
								
							end
						
							 else 
								begin 
									state <= CIRPLAYS;
								end

					end		

				
					
		endcase
end



endmodule



