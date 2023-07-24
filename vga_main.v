module vga_main(
input clk,
input button0,
input button1,
input actbutton,
input CLOCK_50,
output wire vsync,
output wire hsync,
output wire [7:0]vga_r,
output wire [7:0]vga_g,
output wire [7:0]vga_b,
output reg VGA_clk
);


wire[199:0]board_in;
wire[2:0]tri_score;
wire[3:0]tri_move_num;
wire[3:0]cir_move_num;
wire[2:0]cir_score;
wire whose_turn;
game_logic ( .clk(CLOCK_50), 
.button0(button0), 
.button1(button1), 
.actbutton(actbutton), 
.board_out(board_in), 
.tri_score(tri_score), 
.tri_move_num(tri_move_num), 
.cir_move_num(cir_move_num),
.cir_score(cir_score),
.whose_turn(whose_turn)
);


always @(posedge CLOCK_50) begin 
	VGA_clk <= ~VGA_clk;
end

reg [12:0]center_coordinates[0:9][0:9][0:1];
wire [12:0]posh;
wire [12:0]posv;
reg [7:0]r;
reg [7:0]g;
reg [7:0]b;

VGA_Sync(.vga_CLK(VGA_clk), .vga_VS(vsync), .vga_HS(hsync), .pos_H(posh), .pos_V(posv));

integer i;
integer k;
integer m;

reg[11:0]triangle[0:2069];
reg[11:0]dolutri[0:2069];
reg[11:0]winstri[0:1379];
reg[11:0]winscir[0:1379];
reg[11:0]alphabet[0:8969];
reg[11:0]circle[0:2649];
reg[11:0]dolucir[0:2649];
reg[11:0]numbers[0:5699];
reg[11:0]totalmovescir[0:2249];
reg[11:0]totalmovestri[0:2249];
reg[11:0]zero[0:1155];
reg[11:0]one[0:1155];
reg[11:0]two[0:1155];
reg[11:0]three[0:1155];
reg[11:0]four[0:1155];
reg[11:0]five[0:1155];
reg[11:0]six[0:1155];
reg[11:0]seven[0:1155];
reg[11:0]eight[0:1155];
reg[11:0]nine[0:1155];
reg[11:0]drawwon[0:2499];


initial begin

	for(k=0;k<10;k=k+1)
		begin
			for(m=0;m<10;m=m+1)
				begin
					center_coordinates[m][k][0] = 316+k*30;
					center_coordinates[m][k][1] = 116+m*30;
				end
		end
		
		$readmemh("txtfiles/triangle.txt", triangle);
		$readmemh("txtfiles/dolucir.txt", dolucir );

		$readmemh("txtfiles/dolutri.txt", dolutri);
		$readmemh("txtfiles/circle.txt", circle);	
		
		$readmemh("txtfiles/winstri.txt", winstri);	
		$readmemh("txtfiles/winscir.txt", winscir);	
		$readmemh("txtfiles/alphabet.txt", alphabet);	
		
		$readmemh("txtfiles/numbers.txt", numbers);	
		$readmemh("txtfiles/totalmovescir.txt", totalmovescir);
		$readmemh("txtfiles/totalmovestri.txt", totalmovestri);
	
		$readmemh("txtfiles/zero.txt", zero);	
		$readmemh("txtfiles/one.txt", one);	
		$readmemh("txtfiles/two.txt", two);	
		$readmemh("txtfiles/three.txt", three);	
		$readmemh("txtfiles/four.txt", four);	
		$readmemh("txtfiles/five.txt", five);	
		$readmemh("txtfiles/six.txt", six);	
		$readmemh("txtfiles/seven.txt", seven);	
		$readmemh("txtfiles/eight.txt", eight);	
		$readmemh("txtfiles/nine.txt", nine);	
		$readmemh("txtfiles/draw.txt", drawwon);	
		
		
			
end

	
always @(posedge VGA_clk)
	begin
	
	
	// DRAW
	
	if((438<posv && posv<463) && (414<posh && posh<514) && (drawwon[(posh-414)+100*(posv-438)]!=12'b111111111111) && (tri_move_num+cir_move_num==24))
		begin
			r <= {drawwon[(posh-414)+100*(posv-438)][11:8],4'b0000};
			g <= {drawwon[(posh-414)+100*(posv-438)][7:4],4'b0000};
			b <= {drawwon[(posh-414)+100*(posv-438)][3:0],4'b0000};
		end
	
	// ALPHABET
	
	else if((63<posv && posv<93) && (304<posh && posh<603) && (alphabet[(posh-304)+299*(posv-63)]!=12'b111111111111))
		begin
			r <= {alphabet[(posh-304)+299*(posv-63)][11:8],4'b0000};
			g <= {alphabet[(posh-304)+299*(posv-63)][7:4],4'b0000};
			b <= {alphabet[(posh-304)+299*(posv-63)][3:0],4'b0000};
		end
		
	// NUMBERS
	else if((103<posv && posv<403) && (278<posh && posh<297) && (numbers[(posh-278)+19*(posv-103)]!=12'b111111111111))
		begin
			r <= {numbers[(posh-278)+19*(posv-103)][11:8],4'b0000};
			g <= {numbers[(posh-278)+19*(posv-103)][7:4],4'b0000};
			b <= {numbers[(posh-278)+19*(posv-103)][3:0],4'b0000};
		end
		
	// TRIANGLE
	else if((172<posv && posv<218) && (188<posh && posh<233) && (triangle[(posh-188)+45*(posv-172)]!=12'b111111111111) && whose_turn == 1)
		begin
			r <= {triangle[(posh-188)+45*(posv-172)][11:8],4'b0000};
			g <= {triangle[(posh-188)+45*(posv-172)][7:4],4'b0000};
			b <= {triangle[(posh-188)+45*(posv-172)][3:0],4'b0000};
		end
		
	else if((172<posv && posv<218) && (188<posh && posh<233) && (dolutri[(posh-188)+45*(posv-172)]!=12'b111111111111) && whose_turn == 0)
		begin
			r <= {dolutri[(posh-188)+45*(posv-172)][11:8],4'b0000};
			g <= {dolutri[(posh-188)+45*(posv-172)][7:4],4'b0000};
			b <= {dolutri[(posh-188)+45*(posv-172)][3:0],4'b0000};
		end
	// CIRCLE
	else if((175<posv && posv<225) && (660<posh && posh<713) && (circle[(posh-660)+53*(posv-175)]!=12'b111111111111) && whose_turn == 0)
		begin
			r <= {circle[(posh-660)+53*(posv-175)][11:8],4'b0000};
			g <= {circle[(posh-660)+53*(posv-175)][7:4],4'b0000};
			b <= {circle[(posh-660)+53*(posv-175)][3:0],4'b0000};
		end
		
	else if((175<posv && posv<225) && (660<posh && posh<713) && (dolucir[(posh-660)+53*(posv-175)]!=12'b111111111111) && whose_turn == 1)
		begin
			r <= {dolucir[(posh-660)+53*(posv-175)][11:8],4'b0000};
			g <= {dolucir[(posh-660)+53*(posv-175)][7:4],4'b0000};
			b <= {dolucir[(posh-660)+53*(posv-175)][3:0],4'b0000};
		end
	// MOVES TRIANGLE
	else if((243<posv && posv<268) && (163<posh && posh<253) && (totalmovestri[(posh-163)+90*(posv-243)]!=12'b111111111111))
		begin
			r <= {totalmovestri[(posh-163)+90*(posv-243)][11:8],4'b0000};
			g <= {totalmovestri[(posh-163)+90*(posv-243)][7:4],4'b0000};
			b <= {totalmovestri[(posh-163)+90*(posv-243)][3:0],4'b0000};
		end
	// MOVES CIRCLE
	else if((243<posv && posv<268) && (643<posh && posh<733) && (totalmovescir[(posh-643)+90*(posv-243)]!=12'b111111111111))
		begin
			r <= {totalmovescir[(posh-643)+90*(posv-243)][11:8],4'b0000};
			g <= {totalmovescir[(posh-643)+90*(posv-243)][7:4],4'b0000};
			b <= {totalmovescir[(posh-643)+90*(posv-243)][3:0],4'b0000};
		end
	// TRIANGLE WIN
	else if((321<posv && posv<344) && (176<posh && posh<236) && (winstri[(posh-176)+60*(posv-321)]!=12'b111111111111))
		begin
			r <= {winstri[(posh-176)+60*(posv-321)][11:8],4'b0000};
			g <= {winstri[(posh-176)+60*(posv-321)][7:4],4'b0000};
			b <= {winstri[(posh-176)+60*(posv-321)][3:0],4'b0000};
		end
	// CIRCLE WIN
	else if((321<posv && posv<344) && (654<posh && posh<714) && (winscir[(posh-654)+60*(posv-321)]!=12'b111111111111))
		begin
			r <= {winscir[(posh-654)+60*(posv-321)][11:8],4'b0000};
			g <= {winscir[(posh-654)+60*(posv-321)][7:4],4'b0000};
			b <= {winscir[(posh-654)+60*(posv-321)][3:0],4'b0000};
		end
		
		
	// NUMBERING
	
	else if((279<posv && posv<313) && (181<posh && posh<223) && (zero[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==0)
		begin
			r <= {zero[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {zero[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {zero[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (zero[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==0)
		begin
			r <= {zero[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {zero[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {zero[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (zero[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==0)
		begin
			r <= {zero[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {zero[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {zero[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (zero[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==0)
		begin
			r <= {zero[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {zero[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {zero[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (one[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==1)
		begin
			r <= {one[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {one[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {one[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (one[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==1)
		begin
			r <= {one[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {one[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {one[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (one[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==1)
		begin
			r <= {one[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {one[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {one[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (one[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==1)
		begin
			r <= {one[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {one[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {one[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (two[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==2)
		begin
			r <= {two[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {two[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {two[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (two[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==2)
		begin
			r <= {two[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {two[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {two[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (two[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==2)
		begin
			r <= {two[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {two[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {two[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (two[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==2)
		begin
			r <= {two[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {two[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {two[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (three[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==3)
		begin
			r <= {three[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {three[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {three[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (three[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==3)
		begin
			r <= {three[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {three[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {three[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (three[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==3)
		begin
			r <= {three[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {three[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {three[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (three[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==3)
		begin
			r <= {three[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {three[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {three[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (four[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==4)
		begin
			r <= {four[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {four[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {four[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (four[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==4)
		begin
			r <= {four[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {four[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {four[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (four[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==4)
		begin
			r <= {four[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {four[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {four[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (four[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==4)
		begin
			r <= {four[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {four[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {four[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (five[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==5)
		begin
			r <= {five[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {five[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {five[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (five[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==5)
		begin
			r <= {five[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {five[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {five[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (five[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==5)
		begin
			r <= {five[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {five[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {five[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (five[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==5)
		begin
			r <= {five[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {five[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {five[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (six[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==6)
		begin
			r <= {six[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {six[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {six[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (six[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==6)
		begin
			r <= {six[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {six[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {six[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (six[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==6)
		begin
			r <= {six[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {six[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {six[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (six[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==6)
		begin
			r <= {six[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {six[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {six[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (seven[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==7)
		begin
			r <= {seven[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {seven[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {seven[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (seven[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==7)
		begin
			r <= {seven[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {seven[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {seven[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (seven[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==7)
		begin
			r <= {seven[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {seven[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {seven[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (seven[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==7)
		begin
			r <= {seven[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {seven[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {seven[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (eight[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==8)
		begin
			r <= {eight[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {eight[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {eight[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (eight[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==8)
		begin
			r <= {eight[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {eight[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {eight[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (eight[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==8)
		begin
			r <= {eight[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {eight[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {eight[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (eight[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==8)
		begin
			r <= {eight[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {eight[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {eight[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end


	else if((279<posv && posv<313) && (181<posh && posh<223) && (nine[(posh-181)+34*(posv-279)]!=12'b111111111111) && tri_move_num==9)
		begin
			r <= {nine[(posh-181)+34*(posv-279)][11:8],4'b0000};
			g <= {nine[(posh-181)+34*(posv-279)][7:4],4'b0000};
			b <= {nine[(posh-181)+34*(posv-279)][3:0],4'b0000};
		end
	else if((279<posv && posv<313) && (671<posh && posh<705) && (nine[(posh-671)+34*(posv-279)]!=12'b111111111111) && cir_move_num==9)
		begin
			r <= {nine[(posh-671)+34*(posv-279)][11:8],4'b0000};
			g <= {nine[(posh-671)+34*(posv-279)][7:4],4'b0000};
			b <= {nine[(posh-671)+34*(posv-279)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (181<posh && posh<223) && (nine[(posh-181)+34*(posv-350)]!=12'b111111111111) && tri_score==9)
		begin
			r <= {nine[(posh-181)+34*(posv-350)][11:8],4'b0000};
			g <= {nine[(posh-181)+34*(posv-350)][7:4],4'b0000};
			b <= {nine[(posh-181)+34*(posv-350)][3:0],4'b0000};
		end
	else if((350<posv && posv<384) && (671<posh && posh<705) && (nine[(posh-671)+34*(posv-350)]!=12'b111111111111) && cir_score==9)
		begin
			r <= {nine[(posh-671)+34*(posv-350)][11:8],4'b0000};
			g <= {nine[(posh-671)+34*(posv-350)][7:4],4'b0000};
			b <= {nine[(posh-671)+34*(posv-350)][3:0],4'b0000};
		end




	// VERTICAL LINES FOR GRID ------------------------------------------------------------------------------------------------------------------------
	else 
	
		begin

	if((15<posv && posv<515) && (150<posh && posh<153))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
	
	else if((15<posv && posv<515) && (180<posh && posh<183))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (210<posh && posh<213))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (240<posh && posh<243))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (270<posh && posh<273))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (300<posh && posh<303))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (330<posh && posh<333))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    else if((15<posv && posv<515) && (360<posh && posh<363))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (390<posh && posh<393))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (420<posh && posh<423))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (450<posh && posh<453))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (480<posh && posh<483))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (510<posh && posh<513))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (540<posh && posh<543))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (570<posh && posh<573))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (600<posh && posh<603))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (630<posh && posh<633))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (660<posh && posh<663))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (690<posh && posh<693))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (720<posh && posh<723))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (750<posh && posh<753))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (780<posh && posh<783))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((15<posv && posv<515) && (810<posh && posh<813))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
			
			
			
	// HORIZONTAL LINES FOR GRID------------------------------------------------------------------------------------------------------------------------
	
	else if((40<posv && posv<43) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
	
	
	else if((70<posv && posv<73) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((100<posv && posv<103) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((130<posv && posv<133) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((160<posv && posv<163) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((190<posv && posv<193) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((220<posv && posv<223) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
		end
    

    
    else if((250<posv && posv<253) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((280<posv && posv<283) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((310<posv && posv<313) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((340<posv && posv<343) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((370<posv && posv<373) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((400<posv && posv<403) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((430<posv && posv<433) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((460<posv && posv<463) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((490<posv && posv<493) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
    

    
    else if((520<posv && posv<523) && (144<posh && posh<784))
			begin
				r <= 224;
				g <= 224;
				b <= 224;
			end
			
	else if((35<posv && posv<515) && (144<posh && posh<784))
		begin
			r <= 255;
			g <= 255;
			b <= 255;
		end
	
	
	// GAME BORDERS ---------------------------------------------------------------------------------------------------------------------------------------
	
	
	if((100<posv && posv<403) && (300<posh && posh<303))
			begin
				r <= 0;
				g <= 0;
				b <= 0;
			end
			
	if((100<posv && posv<403) && (600<posh && posh<603))
			begin
				r <= 0;
				g <= 0;
				b <= 0;
			end
			
	if((100<posv && posv<103) && (300<posh && posh<603))
			begin
				r <= 0;
				g <= 0;
				b <= 0;
			end
			
	if((400<posv && posv<403) && (300<posh && posh<603))
			begin
				r <= 0;
				g <= 0;
				b <= 0;
			end
			
	// CIRCLE ---------------------------------------------------------------------------------------------------------------------------------------
	
	if(((posh-center_coordinates[0][0][0])**2+(posv-center_coordinates[0][0][1])**2) <= 100 && board_in[199]==1 && board_in[198]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][1][0])**2+(posv-center_coordinates[0][1][1])**2) <= 100 && board_in[197]==1 && board_in[196]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][2][0])**2+(posv-center_coordinates[0][2][1])**2) <= 100 && board_in[195]==1 && board_in[194]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][3][0])**2+(posv-center_coordinates[0][3][1])**2) <= 100 && board_in[193]==1 && board_in[192]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[0][4][0])**2+(posv-center_coordinates[0][4][1])**2) <= 100 && board_in[191]==1 && board_in[190]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][5][0])**2+(posv-center_coordinates[0][5][1])**2) <= 100 && board_in[189]==1 && board_in[188]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][6][0])**2+(posv-center_coordinates[0][6][1])**2) <= 100 && board_in[187]==1 && board_in[186]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][7][0])**2+(posv-center_coordinates[0][7][1])**2) <= 100 && board_in[185]==1 && board_in[184]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][8][0])**2+(posv-center_coordinates[0][8][1])**2) <= 100 && board_in[183]==1 && board_in[182]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[0][9][0])**2+(posv-center_coordinates[0][9][1])**2) <= 100 && board_in[181]==1 && board_in[180]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][0][0])**2+(posv-center_coordinates[1][0][1])**2) <= 100 && board_in[179]==1 && board_in[178]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][1][0])**2+(posv-center_coordinates[1][1][1])**2) <= 100 && board_in[177]==1 && board_in[176]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][2][0])**2+(posv-center_coordinates[1][2][1])**2) <= 100 && board_in[175]==1 && board_in[174]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][3][0])**2+(posv-center_coordinates[1][3][1])**2) <= 100 && board_in[173]==1 && board_in[172]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][4][0])**2+(posv-center_coordinates[1][4][1])**2) <= 100 && board_in[171]==1 && board_in[170]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][5][0])**2+(posv-center_coordinates[1][5][1])**2) <= 100 && board_in[169]==1 && board_in[168]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[1][6][0])**2+(posv-center_coordinates[1][6][1])**2) <= 100 && board_in[167]==1 && board_in[166]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][7][0])**2+(posv-center_coordinates[1][7][1])**2) <= 100 && board_in[165]==1 && board_in[164]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][8][0])**2+(posv-center_coordinates[1][8][1])**2) <= 100 && board_in[163]==1 && board_in[162]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[1][9][0])**2+(posv-center_coordinates[1][9][1])**2) <= 100 && board_in[161]==1 && board_in[160]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][0][0])**2+(posv-center_coordinates[2][0][1])**2) <= 100 && board_in[159]==1 && board_in[158]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][1][0])**2+(posv-center_coordinates[2][1][1])**2) <= 100 && board_in[157]==1 && board_in[156]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][2][0])**2+(posv-center_coordinates[2][2][1])**2) <= 100 && board_in[155]==1 && board_in[154]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][3][0])**2+(posv-center_coordinates[2][3][1])**2) <= 100 && board_in[153]==1 && board_in[152]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[2][4][0])**2+(posv-center_coordinates[2][4][1])**2) <= 100 && board_in[151]==1 && board_in[150]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][5][0])**2+(posv-center_coordinates[2][5][1])**2) <= 100 && board_in[149]==1 && board_in[148]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][6][0])**2+(posv-center_coordinates[2][6][1])**2) <= 100 && board_in[147]==1 && board_in[146]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][7][0])**2+(posv-center_coordinates[2][7][1])**2) <= 100 && board_in[145]==1 && board_in[144]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[2][8][0])**2+(posv-center_coordinates[2][8][1])**2) <= 100 && board_in[143]==1 && board_in[142]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[2][9][0])**2+(posv-center_coordinates[2][9][1])**2) <= 100 && board_in[141]==1 && board_in[140]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][0][0])**2+(posv-center_coordinates[3][0][1])**2) <= 100 && board_in[139]==1 && board_in[138]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][1][0])**2+(posv-center_coordinates[3][1][1])**2) <= 100 && board_in[137]==1 && board_in[136]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][2][0])**2+(posv-center_coordinates[3][2][1])**2) <= 100 && board_in[135]==1 && board_in[134]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][3][0])**2+(posv-center_coordinates[3][3][1])**2) <= 100 && board_in[133]==1 && board_in[132]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][4][0])**2+(posv-center_coordinates[3][4][1])**2) <= 100 && board_in[131]==1 && board_in[130]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[3][5][0])**2+(posv-center_coordinates[3][5][1])**2) <= 100 && board_in[129]==1 && board_in[128]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][6][0])**2+(posv-center_coordinates[3][6][1])**2) <= 100 && board_in[127]==1 && board_in[126]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][7][0])**2+(posv-center_coordinates[3][7][1])**2) <= 100 && board_in[125]==1 && board_in[124]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[3][8][0])**2+(posv-center_coordinates[3][8][1])**2) <= 100 && board_in[123]==1 && board_in[122]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[3][9][0])**2+(posv-center_coordinates[3][9][1])**2) <= 100 && board_in[121]==1 && board_in[120]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][0][0])**2+(posv-center_coordinates[4][0][1])**2) <= 100 && board_in[119]==1 && board_in[118]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][1][0])**2+(posv-center_coordinates[4][1][1])**2) <= 100 && board_in[117]==1 && board_in[116]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][2][0])**2+(posv-center_coordinates[4][2][1])**2) <= 100 && board_in[115]==1 && board_in[114]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][3][0])**2+(posv-center_coordinates[4][3][1])**2) <= 100 && board_in[113]==1 && board_in[112]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][4][0])**2+(posv-center_coordinates[4][4][1])**2) <= 100 && board_in[111]==1 && board_in[110]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][5][0])**2+(posv-center_coordinates[4][5][1])**2) <= 100 && board_in[109]==1 && board_in[108]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][6][0])**2+(posv-center_coordinates[4][6][1])**2) <= 100 && board_in[107]==1 && board_in[106]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][7][0])**2+(posv-center_coordinates[4][7][1])**2) <= 100 && board_in[105]==1 && board_in[104]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
if(((posh-center_coordinates[4][8][0])**2+(posv-center_coordinates[4][8][1])**2) <= 100 && board_in[103]==1 && board_in[102]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[4][9][0])**2+(posv-center_coordinates[4][9][1])**2) <= 100 && board_in[101]==1 && board_in[100]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][0][0])**2+(posv-center_coordinates[5][0][1])**2) <= 100 && board_in[99]==1 && board_in[98]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][1][0])**2+(posv-center_coordinates[5][1][1])**2) <= 100 && board_in[97]==1 && board_in[96]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][2][0])**2+(posv-center_coordinates[5][2][1])**2) <= 100 && board_in[95]==1 && board_in[94]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][3][0])**2+(posv-center_coordinates[5][3][1])**2) <= 100 && board_in[93]==1 && board_in[92]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][4][0])**2+(posv-center_coordinates[5][4][1])**2) <= 100 && board_in[91]==1 && board_in[90]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][5][0])**2+(posv-center_coordinates[5][5][1])**2) <= 100 && board_in[89]==1 && board_in[88]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[5][6][0])**2+(posv-center_coordinates[5][6][1])**2) <= 100 && board_in[87]==1 && board_in[86]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][7][0])**2+(posv-center_coordinates[5][7][1])**2) <= 100 && board_in[85]==1 && board_in[84]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][8][0])**2+(posv-center_coordinates[5][8][1])**2) <= 100 && board_in[83]==1 && board_in[82]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[5][9][0])**2+(posv-center_coordinates[5][9][1])**2) <= 100 && board_in[81]==1 && board_in[80]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][0][0])**2+(posv-center_coordinates[6][0][1])**2) <= 100 && board_in[79]==1 && board_in[78]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;end
        

        
        if(((posh-center_coordinates[6][1][0])**2+(posv-center_coordinates[6][1][1])**2) <= 100 && board_in[77]==1 && board_in[76]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][2][0])**2+(posv-center_coordinates[6][2][1])**2) <= 100 && board_in[75]==1 && board_in[74]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][3][0])**2+(posv-center_coordinates[6][3][1])**2) <= 100 && board_in[73]==1 && board_in[72]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][4][0])**2+(posv-center_coordinates[6][4][1])**2) <= 100 && board_in[71]==1 && board_in[70]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][5][0])**2+(posv-center_coordinates[6][5][1])**2) <= 100 && board_in[69]==1 && board_in[68]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[6][6][0])**2+(posv-center_coordinates[6][6][1])**2) <= 100 && board_in[67]==1 && board_in[66]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][7][0])**2+(posv-center_coordinates[6][7][1])**2) <= 100 && board_in[65]==1 && board_in[64]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[6][8][0])**2+(posv-center_coordinates[6][8][1])**2) <= 100 && board_in[63]==1 && board_in[62]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[6][9][0])**2+(posv-center_coordinates[6][9][1])**2) <= 100 && board_in[61]==1 && board_in[60]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][0][0])**2+(posv-center_coordinates[7][0][1])**2) <= 100 && board_in[59]==1 && board_in[58]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][1][0])**2+(posv-center_coordinates[7][1][1])**2) <= 100 && board_in[57]==1 && board_in[56]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        if(((posh-center_coordinates[7][2][0])**2+(posv-center_coordinates[7][2][1])**2) <= 100 && board_in[55]==1 && board_in[54]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][3][0])**2+(posv-center_coordinates[7][3][1])**2) <= 100 && board_in[53]==1 && board_in[52]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[7][4][0])**2+(posv-center_coordinates[7][4][1])**2) <= 100 && board_in[51]==1 && board_in[50]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][5][0])**2+(posv-center_coordinates[7][5][1])**2) <= 100 && board_in[49]==1 && board_in[48]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][6][0])**2+(posv-center_coordinates[7][6][1])**2) <= 100 && board_in[47]==1 && board_in[46]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[7][7][0])**2+(posv-center_coordinates[7][7][1])**2) <= 100 && board_in[45]==1 && board_in[44]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][8][0])**2+(posv-center_coordinates[7][8][1])**2) <= 100 && board_in[43]==1 && board_in[42]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[7][9][0])**2+(posv-center_coordinates[7][9][1])**2) <= 100 && board_in[41]==1 && board_in[40]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][0][0])**2+(posv-center_coordinates[8][0][1])**2) <= 100 && board_in[39]==1 && board_in[38]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
			if(((posh-center_coordinates[8][1][0])**2+(posv-center_coordinates[8][1][1])**2) <= 100 && board_in[37]==1 && board_in[36]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][2][0])**2+(posv-center_coordinates[8][2][1])**2) <= 100 && board_in[35]==1 && board_in[34]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][3][0])**2+(posv-center_coordinates[8][3][1])**2) <= 100 && board_in[33]==1 && board_in[32]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][4][0])**2+(posv-center_coordinates[8][4][1])**2) <= 100 && board_in[31]==1 && board_in[30]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
end
        

        
        if(((posh-center_coordinates[8][5][0])**2+(posv-center_coordinates[8][5][1])**2) <= 100 && board_in[29]==1 && board_in[28]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][6][0])**2+(posv-center_coordinates[8][6][1])**2) <= 100 && board_in[27]==1 && board_in[26]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][7][0])**2+(posv-center_coordinates[8][7][1])**2) <= 100 && board_in[25]==1 && board_in[24]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[8][8][0])**2+(posv-center_coordinates[8][8][1])**2) <= 100 && board_in[23]==1 && board_in[22]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[8][9][0])**2+(posv-center_coordinates[8][9][1])**2) <= 100 && board_in[21]==1 && board_in[20]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][0][0])**2+(posv-center_coordinates[9][0][1])**2) <= 100 && board_in[19]==1 && board_in[18]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][1][0])**2+(posv-center_coordinates[9][1][1])**2) <= 100 && board_in[17]==1 && board_in[16]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][2][0])**2+(posv-center_coordinates[9][2][1])**2) <= 100 && board_in[15]==1 && board_in[14]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        
if(((posh-center_coordinates[9][3][0])**2+(posv-center_coordinates[9][3][1])**2) <= 100 && board_in[13]==1 && board_in[12]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][4][0])**2+(posv-center_coordinates[9][4][1])**2) <= 100 && board_in[11]==1 && board_in[10]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][5][0])**2+(posv-center_coordinates[9][5][1])**2) <= 100 && board_in[9]==1 && board_in[8]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][6][0])**2+(posv-center_coordinates[9][6][1])**2) <= 100 && board_in[7]==1 && board_in[6]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

if(((posh-center_coordinates[9][7][0])**2+(posv-center_coordinates[9][7][1])**2) <= 100 && board_in[5]==1 && board_in[4]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][8][0])**2+(posv-center_coordinates[9][8][1])**2) <= 100 && board_in[3]==1 && board_in[2]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
        

        
        if(((posh-center_coordinates[9][9][0])**2+(posv-center_coordinates[9][9][1])**2) <= 100 && board_in[1]==1 && board_in[0]==0)
    		begin
    			r <= 180;
    			g <= 180;
    			b <= 0;
    		end
               
		
	// TRIANGLE ---------------------------------------------------------------------------------------------------------------------------------------


			if( ( ((posv > (center_coordinates[0][0][1]-10)) && (posh <= center_coordinates[0][0][0]) && (posv-(center_coordinates[0][0][1]-10) >  ((-2)*(posh-center_coordinates[0][0][0]))) && (posv-(center_coordinates[0][0][1]-10)<20))   || ((posv > (center_coordinates[0][0][1]-10)) && (posh > center_coordinates[0][0][0]) && (posv-(center_coordinates[0][0][1]-10) >  ((2)*(posh-center_coordinates[0][0][0]))) && (posv-(center_coordinates[0][0][1]-10)<20)))   &&  (board_in[199] == 0 && board_in[198] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][1][1]-10)) && (posh <= center_coordinates[0][1][0]) && (posv-(center_coordinates[0][1][1]-10) >  ((-2)*(posh-center_coordinates[0][1][0]))) && (posv-(center_coordinates[0][1][1]-10)<20))   || ((posv > (center_coordinates[0][1][1]-10)) && (posh > center_coordinates[0][1][0]) && (posv-(center_coordinates[0][1][1]-10) >  ((2)*(posh-center_coordinates[0][1][0]))) && (posv-(center_coordinates[0][1][1]-10)<20)))   &&  (board_in[197] == 0 && board_in[196] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][2][1]-10)) && (posh <= center_coordinates[0][2][0]) && (posv-(center_coordinates[0][2][1]-10) >  ((-2)*(posh-center_coordinates[0][2][0]))) && (posv-(center_coordinates[0][2][1]-10)<20))   || ((posv > (center_coordinates[0][2][1]-10)) && (posh > center_coordinates[0][2][0]) && (posv-(center_coordinates[0][2][1]-10) >  ((2)*(posh-center_coordinates[0][2][0]))) && (posv-(center_coordinates[0][2][1]-10)<20)))   &&  (board_in[195] == 0 && board_in[194] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][3][1]-10)) && (posh <= center_coordinates[0][3][0]) && (posv-(center_coordinates[0][3][1]-10) >  ((-2)*(posh-center_coordinates[0][3][0]))) && (posv-(center_coordinates[0][3][1]-10)<20))   || ((posv > (center_coordinates[0][3][1]-10)) && (posh > center_coordinates[0][3][0]) && (posv-(center_coordinates[0][3][1]-10) >  ((2)*(posh-center_coordinates[0][3][0]))) && (posv-(center_coordinates[0][3][1]-10)<20)))   &&  (board_in[193] == 0 && board_in[192] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][4][1]-10)) && (posh <= center_coordinates[0][4][0]) && (posv-(center_coordinates[0][4][1]-10) >  ((-2)*(posh-center_coordinates[0][4][0]))) && (posv-(center_coordinates[0][4][1]-10)<20))   || ((posv > (center_coordinates[0][4][1]-10)) && (posh > center_coordinates[0][4][0]) && (posv-(center_coordinates[0][4][1]-10) >  ((2)*(posh-center_coordinates[0][4][0]))) && (posv-(center_coordinates[0][4][1]-10)<20)))   &&  (board_in[191] == 0 && board_in[190] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][5][1]-10)) && (posh <= center_coordinates[0][5][0]) && (posv-(center_coordinates[0][5][1]-10) >  ((-2)*(posh-center_coordinates[0][5][0]))) && (posv-(center_coordinates[0][5][1]-10)<20))   || ((posv > (center_coordinates[0][5][1]-10)) && (posh > center_coordinates[0][5][0]) && (posv-(center_coordinates[0][5][1]-10) >  ((2)*(posh-center_coordinates[0][5][0]))) && (posv-(center_coordinates[0][5][1]-10)<20)))   &&  (board_in[189] == 0 && board_in[188] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][6][1]-10)) && (posh <= center_coordinates[0][6][0]) && (posv-(center_coordinates[0][6][1]-10) >  ((-2)*(posh-center_coordinates[0][6][0]))) && (posv-(center_coordinates[0][6][1]-10)<20))   || ((posv > (center_coordinates[0][6][1]-10)) && (posh > center_coordinates[0][6][0]) && (posv-(center_coordinates[0][6][1]-10) >  ((2)*(posh-center_coordinates[0][6][0]))) && (posv-(center_coordinates[0][6][1]-10)<20)))   &&  (board_in[187] == 0 && board_in[186] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][7][1]-10)) && (posh <= center_coordinates[0][7][0]) && (posv-(center_coordinates[0][7][1]-10) >  ((-2)*(posh-center_coordinates[0][7][0]))) && (posv-(center_coordinates[0][7][1]-10)<20))   || ((posv > (center_coordinates[0][7][1]-10)) && (posh > center_coordinates[0][7][0]) && (posv-(center_coordinates[0][7][1]-10) >  ((2)*(posh-center_coordinates[0][7][0]))) && (posv-(center_coordinates[0][7][1]-10)<20)))   &&  (board_in[185] == 0 && board_in[184] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][8][1]-10)) && (posh <= center_coordinates[0][8][0]) && (posv-(center_coordinates[0][8][1]-10) >  ((-2)*(posh-center_coordinates[0][8][0]))) && (posv-(center_coordinates[0][8][1]-10)<20))   || ((posv > (center_coordinates[0][8][1]-10)) && (posh > center_coordinates[0][8][0]) && (posv-(center_coordinates[0][8][1]-10) >  ((2)*(posh-center_coordinates[0][8][0]))) && (posv-(center_coordinates[0][8][1]-10)<20)))   &&  (board_in[183] == 0 && board_in[182] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[0][9][1]-10)) && (posh <= center_coordinates[0][9][0]) && (posv-(center_coordinates[0][9][1]-10) >  ((-2)*(posh-center_coordinates[0][9][0]))) && (posv-(center_coordinates[0][9][1]-10)<20))   || ((posv > (center_coordinates[0][9][1]-10)) && (posh > center_coordinates[0][9][0]) && (posv-(center_coordinates[0][9][1]-10) >  ((2)*(posh-center_coordinates[0][9][0]))) && (posv-(center_coordinates[0][9][1]-10)<20)))   &&  (board_in[181] == 0 && board_in[180] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][0][1]-10)) && (posh <= center_coordinates[1][0][0]) && (posv-(center_coordinates[1][0][1]-10) >  ((-2)*(posh-center_coordinates[1][0][0]))) && (posv-(center_coordinates[1][0][1]-10)<20))   || ((posv > (center_coordinates[1][0][1]-10)) && (posh > center_coordinates[1][0][0]) && (posv-(center_coordinates[1][0][1]-10) >  ((2)*(posh-center_coordinates[1][0][0]))) && (posv-(center_coordinates[1][0][1]-10)<20)))   &&  (board_in[179] == 0 && board_in[178] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][1][1]-10)) && (posh <= center_coordinates[1][1][0]) && (posv-(center_coordinates[1][1][1]-10) >  ((-2)*(posh-center_coordinates[1][1][0]))) && (posv-(center_coordinates[1][1][1]-10)<20))   || ((posv > (center_coordinates[1][1][1]-10)) && (posh > center_coordinates[1][1][0]) && (posv-(center_coordinates[1][1][1]-10) >  ((2)*(posh-center_coordinates[1][1][0]))) && (posv-(center_coordinates[1][1][1]-10)<20)))   &&  (board_in[177] == 0 && board_in[176] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][2][1]-10)) && (posh <= center_coordinates[1][2][0]) && (posv-(center_coordinates[1][2][1]-10) >  ((-2)*(posh-center_coordinates[1][2][0]))) && (posv-(center_coordinates[1][2][1]-10)<20))   || ((posv > (center_coordinates[1][2][1]-10)) && (posh > center_coordinates[1][2][0]) && (posv-(center_coordinates[1][2][1]-10) >  ((2)*(posh-center_coordinates[1][2][0]))) && (posv-(center_coordinates[1][2][1]-10)<20)))   &&  (board_in[175] == 0 && board_in[174] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][3][1]-10)) && (posh <= center_coordinates[1][3][0]) && (posv-(center_coordinates[1][3][1]-10) >  ((-2)*(posh-center_coordinates[1][3][0]))) && (posv-(center_coordinates[1][3][1]-10)<20))   || ((posv > (center_coordinates[1][3][1]-10)) && (posh > center_coordinates[1][3][0]) && (posv-(center_coordinates[1][3][1]-10) >  ((2)*(posh-center_coordinates[1][3][0]))) && (posv-(center_coordinates[1][3][1]-10)<20)))   &&  (board_in[173] == 0 && board_in[172] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][4][1]-10)) && (posh <= center_coordinates[1][4][0]) && (posv-(center_coordinates[1][4][1]-10) >  ((-2)*(posh-center_coordinates[1][4][0]))) && (posv-(center_coordinates[1][4][1]-10)<20))   || ((posv > (center_coordinates[1][4][1]-10)) && (posh > center_coordinates[1][4][0]) && (posv-(center_coordinates[1][4][1]-10) >  ((2)*(posh-center_coordinates[1][4][0]))) && (posv-(center_coordinates[1][4][1]-10)<20)))   &&  (board_in[171] == 0 && board_in[170] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][5][1]-10)) && (posh <= center_coordinates[1][5][0]) && (posv-(center_coordinates[1][5][1]-10) >  ((-2)*(posh-center_coordinates[1][5][0]))) && (posv-(center_coordinates[1][5][1]-10)<20))   || ((posv > (center_coordinates[1][5][1]-10)) && (posh > center_coordinates[1][5][0]) && (posv-(center_coordinates[1][5][1]-10) >  ((2)*(posh-center_coordinates[1][5][0]))) && (posv-(center_coordinates[1][5][1]-10)<20)))   &&  (board_in[169] == 0 && board_in[168] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][6][1]-10)) && (posh <= center_coordinates[1][6][0]) && (posv-(center_coordinates[1][6][1]-10) >  ((-2)*(posh-center_coordinates[1][6][0]))) && (posv-(center_coordinates[1][6][1]-10)<20))   || ((posv > (center_coordinates[1][6][1]-10)) && (posh > center_coordinates[1][6][0]) && (posv-(center_coordinates[1][6][1]-10) >  ((2)*(posh-center_coordinates[1][6][0]))) && (posv-(center_coordinates[1][6][1]-10)<20)))   &&  (board_in[167] == 0 && board_in[166] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][7][1]-10)) && (posh <= center_coordinates[1][7][0]) && (posv-(center_coordinates[1][7][1]-10) >  ((-2)*(posh-center_coordinates[1][7][0]))) && (posv-(center_coordinates[1][7][1]-10)<20))   || ((posv > (center_coordinates[1][7][1]-10)) && (posh > center_coordinates[1][7][0]) && (posv-(center_coordinates[1][7][1]-10) >  ((2)*(posh-center_coordinates[1][7][0]))) && (posv-(center_coordinates[1][7][1]-10)<20)))   &&  (board_in[165] == 0 && board_in[164] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][8][1]-10)) && (posh <= center_coordinates[1][8][0]) && (posv-(center_coordinates[1][8][1]-10) >  ((-2)*(posh-center_coordinates[1][8][0]))) && (posv-(center_coordinates[1][8][1]-10)<20))   || ((posv > (center_coordinates[1][8][1]-10)) && (posh > center_coordinates[1][8][0]) && (posv-(center_coordinates[1][8][1]-10) >  ((2)*(posh-center_coordinates[1][8][0]))) && (posv-(center_coordinates[1][8][1]-10)<20)))   &&  (board_in[163] == 0 && board_in[162] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[1][9][1]-10)) && (posh <= center_coordinates[1][9][0]) && (posv-(center_coordinates[1][9][1]-10) >  ((-2)*(posh-center_coordinates[1][9][0]))) && (posv-(center_coordinates[1][9][1]-10)<20))   || ((posv > (center_coordinates[1][9][1]-10)) && (posh > center_coordinates[1][9][0]) && (posv-(center_coordinates[1][9][1]-10) >  ((2)*(posh-center_coordinates[1][9][0]))) && (posv-(center_coordinates[1][9][1]-10)<20)))   &&  (board_in[161] == 0 && board_in[160] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][0][1]-10)) && (posh <= center_coordinates[2][0][0]) && (posv-(center_coordinates[2][0][1]-10) >  ((-2)*(posh-center_coordinates[2][0][0]))) && (posv-(center_coordinates[2][0][1]-10)<20))   || ((posv > (center_coordinates[2][0][1]-10)) && (posh > center_coordinates[2][0][0]) && (posv-(center_coordinates[2][0][1]-10) >  ((2)*(posh-center_coordinates[2][0][0]))) && (posv-(center_coordinates[2][0][1]-10)<20)))   &&  (board_in[159] == 0 && board_in[158] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][1][1]-10)) && (posh <= center_coordinates[2][1][0]) && (posv-(center_coordinates[2][1][1]-10) >  ((-2)*(posh-center_coordinates[2][1][0]))) && (posv-(center_coordinates[2][1][1]-10)<20))   || ((posv > (center_coordinates[2][1][1]-10)) && (posh > center_coordinates[2][1][0]) && (posv-(center_coordinates[2][1][1]-10) >  ((2)*(posh-center_coordinates[2][1][0]))) && (posv-(center_coordinates[2][1][1]-10)<20)))   &&  (board_in[157] == 0 && board_in[156] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][2][1]-10)) && (posh <= center_coordinates[2][2][0]) && (posv-(center_coordinates[2][2][1]-10) >  ((-2)*(posh-center_coordinates[2][2][0]))) && (posv-(center_coordinates[2][2][1]-10)<20))   || ((posv > (center_coordinates[2][2][1]-10)) && (posh > center_coordinates[2][2][0]) && (posv-(center_coordinates[2][2][1]-10) >  ((2)*(posh-center_coordinates[2][2][0]))) && (posv-(center_coordinates[2][2][1]-10)<20)))   &&  (board_in[155] == 0 && board_in[154] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][3][1]-10)) && (posh <= center_coordinates[2][3][0]) && (posv-(center_coordinates[2][3][1]-10) >  ((-2)*(posh-center_coordinates[2][3][0]))) && (posv-(center_coordinates[2][3][1]-10)<20))   || ((posv > (center_coordinates[2][3][1]-10)) && (posh > center_coordinates[2][3][0]) && (posv-(center_coordinates[2][3][1]-10) >  ((2)*(posh-center_coordinates[2][3][0]))) && (posv-(center_coordinates[2][3][1]-10)<20)))   &&  (board_in[153] == 0 && board_in[152] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][4][1]-10)) && (posh <= center_coordinates[2][4][0]) && (posv-(center_coordinates[2][4][1]-10) >  ((-2)*(posh-center_coordinates[2][4][0]))) && (posv-(center_coordinates[2][4][1]-10)<20))   || ((posv > (center_coordinates[2][4][1]-10)) && (posh > center_coordinates[2][4][0]) && (posv-(center_coordinates[2][4][1]-10) >  ((2)*(posh-center_coordinates[2][4][0]))) && (posv-(center_coordinates[2][4][1]-10)<20)))   &&  (board_in[151] == 0 && board_in[150] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][5][1]-10)) && (posh <= center_coordinates[2][5][0]) && (posv-(center_coordinates[2][5][1]-10) >  ((-2)*(posh-center_coordinates[2][5][0]))) && (posv-(center_coordinates[2][5][1]-10)<20))   || ((posv > (center_coordinates[2][5][1]-10)) && (posh > center_coordinates[2][5][0]) && (posv-(center_coordinates[2][5][1]-10) >  ((2)*(posh-center_coordinates[2][5][0]))) && (posv-(center_coordinates[2][5][1]-10)<20)))   &&  (board_in[149] == 0 && board_in[148] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][6][1]-10)) && (posh <= center_coordinates[2][6][0]) && (posv-(center_coordinates[2][6][1]-10) >  ((-2)*(posh-center_coordinates[2][6][0]))) && (posv-(center_coordinates[2][6][1]-10)<20))   || ((posv > (center_coordinates[2][6][1]-10)) && (posh > center_coordinates[2][6][0]) && (posv-(center_coordinates[2][6][1]-10) >  ((2)*(posh-center_coordinates[2][6][0]))) && (posv-(center_coordinates[2][6][1]-10)<20)))   &&  (board_in[147] == 0 && board_in[146] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][7][1]-10)) && (posh <= center_coordinates[2][7][0]) && (posv-(center_coordinates[2][7][1]-10) >  ((-2)*(posh-center_coordinates[2][7][0]))) && (posv-(center_coordinates[2][7][1]-10)<20))   || ((posv > (center_coordinates[2][7][1]-10)) && (posh > center_coordinates[2][7][0]) && (posv-(center_coordinates[2][7][1]-10) >  ((2)*(posh-center_coordinates[2][7][0]))) && (posv-(center_coordinates[2][7][1]-10)<20)))   &&  (board_in[145] == 0 && board_in[144] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][8][1]-10)) && (posh <= center_coordinates[2][8][0]) && (posv-(center_coordinates[2][8][1]-10) >  ((-2)*(posh-center_coordinates[2][8][0]))) && (posv-(center_coordinates[2][8][1]-10)<20))   || ((posv > (center_coordinates[2][8][1]-10)) && (posh > center_coordinates[2][8][0]) && (posv-(center_coordinates[2][8][1]-10) >  ((2)*(posh-center_coordinates[2][8][0]))) && (posv-(center_coordinates[2][8][1]-10)<20)))   &&  (board_in[143] == 0 && board_in[142] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[2][9][1]-10)) && (posh <= center_coordinates[2][9][0]) && (posv-(center_coordinates[2][9][1]-10) >  ((-2)*(posh-center_coordinates[2][9][0]))) && (posv-(center_coordinates[2][9][1]-10)<20))   || ((posv > (center_coordinates[2][9][1]-10)) && (posh > center_coordinates[2][9][0]) && (posv-(center_coordinates[2][9][1]-10) >  ((2)*(posh-center_coordinates[2][9][0]))) && (posv-(center_coordinates[2][9][1]-10)<20)))   &&  (board_in[141] == 0 && board_in[140] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][0][1]-10)) && (posh <= center_coordinates[3][0][0]) && (posv-(center_coordinates[3][0][1]-10) >  ((-2)*(posh-center_coordinates[3][0][0]))) && (posv-(center_coordinates[3][0][1]-10)<20))   || ((posv > (center_coordinates[3][0][1]-10)) && (posh > center_coordinates[3][0][0]) && (posv-(center_coordinates[3][0][1]-10) >  ((2)*(posh-center_coordinates[3][0][0]))) && (posv-(center_coordinates[3][0][1]-10)<20)))   &&  (board_in[139] == 0 && board_in[138] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][1][1]-10)) && (posh <= center_coordinates[3][1][0]) && (posv-(center_coordinates[3][1][1]-10) >  ((-2)*(posh-center_coordinates[3][1][0]))) && (posv-(center_coordinates[3][1][1]-10)<20))   || ((posv > (center_coordinates[3][1][1]-10)) && (posh > center_coordinates[3][1][0]) && (posv-(center_coordinates[3][1][1]-10) >  ((2)*(posh-center_coordinates[3][1][0]))) && (posv-(center_coordinates[3][1][1]-10)<20)))   &&  (board_in[137] == 0 && board_in[136] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][2][1]-10)) && (posh <= center_coordinates[3][2][0]) && (posv-(center_coordinates[3][2][1]-10) >  ((-2)*(posh-center_coordinates[3][2][0]))) && (posv-(center_coordinates[3][2][1]-10)<20))   || ((posv > (center_coordinates[3][2][1]-10)) && (posh > center_coordinates[3][2][0]) && (posv-(center_coordinates[3][2][1]-10) >  ((2)*(posh-center_coordinates[3][2][0]))) && (posv-(center_coordinates[3][2][1]-10)<20)))   &&  (board_in[135] == 0 && board_in[134] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][3][1]-10)) && (posh <= center_coordinates[3][3][0]) && (posv-(center_coordinates[3][3][1]-10) >  ((-2)*(posh-center_coordinates[3][3][0]))) && (posv-(center_coordinates[3][3][1]-10)<20))   || ((posv > (center_coordinates[3][3][1]-10)) && (posh > center_coordinates[3][3][0]) && (posv-(center_coordinates[3][3][1]-10) >  ((2)*(posh-center_coordinates[3][3][0]))) && (posv-(center_coordinates[3][3][1]-10)<20)))   &&  (board_in[133] == 0 && board_in[132] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][4][1]-10)) && (posh <= center_coordinates[3][4][0]) && (posv-(center_coordinates[3][4][1]-10) >  ((-2)*(posh-center_coordinates[3][4][0]))) && (posv-(center_coordinates[3][4][1]-10)<20))   || ((posv > (center_coordinates[3][4][1]-10)) && (posh > center_coordinates[3][4][0]) && (posv-(center_coordinates[3][4][1]-10) >  ((2)*(posh-center_coordinates[3][4][0]))) && (posv-(center_coordinates[3][4][1]-10)<20)))   &&  (board_in[131] == 0 && board_in[130] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][5][1]-10)) && (posh <= center_coordinates[3][5][0]) && (posv-(center_coordinates[3][5][1]-10) >  ((-2)*(posh-center_coordinates[3][5][0]))) && (posv-(center_coordinates[3][5][1]-10)<20))   || ((posv > (center_coordinates[3][5][1]-10)) && (posh > center_coordinates[3][5][0]) && (posv-(center_coordinates[3][5][1]-10) >  ((2)*(posh-center_coordinates[3][5][0]))) && (posv-(center_coordinates[3][5][1]-10)<20)))   &&  (board_in[129] == 0 && board_in[128] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][6][1]-10)) && (posh <= center_coordinates[3][6][0]) && (posv-(center_coordinates[3][6][1]-10) >  ((-2)*(posh-center_coordinates[3][6][0]))) && (posv-(center_coordinates[3][6][1]-10)<20))   || ((posv > (center_coordinates[3][6][1]-10)) && (posh > center_coordinates[3][6][0]) && (posv-(center_coordinates[3][6][1]-10) >  ((2)*(posh-center_coordinates[3][6][0]))) && (posv-(center_coordinates[3][6][1]-10)<20)))   &&  (board_in[127] == 0 && board_in[126] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][7][1]-10)) && (posh <= center_coordinates[3][7][0]) && (posv-(center_coordinates[3][7][1]-10) >  ((-2)*(posh-center_coordinates[3][7][0]))) && (posv-(center_coordinates[3][7][1]-10)<20))   || ((posv > (center_coordinates[3][7][1]-10)) && (posh > center_coordinates[3][7][0]) && (posv-(center_coordinates[3][7][1]-10) >  ((2)*(posh-center_coordinates[3][7][0]))) && (posv-(center_coordinates[3][7][1]-10)<20)))   &&  (board_in[125] == 0 && board_in[124] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][8][1]-10)) && (posh <= center_coordinates[3][8][0]) && (posv-(center_coordinates[3][8][1]-10) >  ((-2)*(posh-center_coordinates[3][8][0]))) && (posv-(center_coordinates[3][8][1]-10)<20))   || ((posv > (center_coordinates[3][8][1]-10)) && (posh > center_coordinates[3][8][0]) && (posv-(center_coordinates[3][8][1]-10) >  ((2)*(posh-center_coordinates[3][8][0]))) && (posv-(center_coordinates[3][8][1]-10)<20)))   &&  (board_in[123] == 0 && board_in[122] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[3][9][1]-10)) && (posh <= center_coordinates[3][9][0]) && (posv-(center_coordinates[3][9][1]-10) >  ((-2)*(posh-center_coordinates[3][9][0]))) && (posv-(center_coordinates[3][9][1]-10)<20))   || ((posv > (center_coordinates[3][9][1]-10)) && (posh > center_coordinates[3][9][0]) && (posv-(center_coordinates[3][9][1]-10) >  ((2)*(posh-center_coordinates[3][9][0]))) && (posv-(center_coordinates[3][9][1]-10)<20)))   &&  (board_in[121] == 0 && board_in[120] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][0][1]-10)) && (posh <= center_coordinates[4][0][0]) && (posv-(center_coordinates[4][0][1]-10) >  ((-2)*(posh-center_coordinates[4][0][0]))) && (posv-(center_coordinates[4][0][1]-10)<20))   || ((posv > (center_coordinates[4][0][1]-10)) && (posh > center_coordinates[4][0][0]) && (posv-(center_coordinates[4][0][1]-10) >  ((2)*(posh-center_coordinates[4][0][0]))) && (posv-(center_coordinates[4][0][1]-10)<20)))   &&  (board_in[119] == 0 && board_in[118] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][1][1]-10)) && (posh <= center_coordinates[4][1][0]) && (posv-(center_coordinates[4][1][1]-10) >  ((-2)*(posh-center_coordinates[4][1][0]))) && (posv-(center_coordinates[4][1][1]-10)<20))   || ((posv > (center_coordinates[4][1][1]-10)) && (posh > center_coordinates[4][1][0]) && (posv-(center_coordinates[4][1][1]-10) >  ((2)*(posh-center_coordinates[4][1][0]))) && (posv-(center_coordinates[4][1][1]-10)<20)))   &&  (board_in[117] == 0 && board_in[116] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][2][1]-10)) && (posh <= center_coordinates[4][2][0]) && (posv-(center_coordinates[4][2][1]-10) >  ((-2)*(posh-center_coordinates[4][2][0]))) && (posv-(center_coordinates[4][2][1]-10)<20))   || ((posv > (center_coordinates[4][2][1]-10)) && (posh > center_coordinates[4][2][0]) && (posv-(center_coordinates[4][2][1]-10) >  ((2)*(posh-center_coordinates[4][2][0]))) && (posv-(center_coordinates[4][2][1]-10)<20)))   &&  (board_in[115] == 0 && board_in[114] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][3][1]-10)) && (posh <= center_coordinates[4][3][0]) && (posv-(center_coordinates[4][3][1]-10) >  ((-2)*(posh-center_coordinates[4][3][0]))) && (posv-(center_coordinates[4][3][1]-10)<20))   || ((posv > (center_coordinates[4][3][1]-10)) && (posh > center_coordinates[4][3][0]) && (posv-(center_coordinates[4][3][1]-10) >  ((2)*(posh-center_coordinates[4][3][0]))) && (posv-(center_coordinates[4][3][1]-10)<20)))   &&  (board_in[113] == 0 && board_in[112] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][4][1]-10)) && (posh <= center_coordinates[4][4][0]) && (posv-(center_coordinates[4][4][1]-10) >  ((-2)*(posh-center_coordinates[4][4][0]))) && (posv-(center_coordinates[4][4][1]-10)<20))   || ((posv > (center_coordinates[4][4][1]-10)) && (posh > center_coordinates[4][4][0]) && (posv-(center_coordinates[4][4][1]-10) >  ((2)*(posh-center_coordinates[4][4][0]))) && (posv-(center_coordinates[4][4][1]-10)<20)))   &&  (board_in[111] == 0 && board_in[110] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][5][1]-10)) && (posh <= center_coordinates[4][5][0]) && (posv-(center_coordinates[4][5][1]-10) >  ((-2)*(posh-center_coordinates[4][5][0]))) && (posv-(center_coordinates[4][5][1]-10)<20))   || ((posv > (center_coordinates[4][5][1]-10)) && (posh > center_coordinates[4][5][0]) && (posv-(center_coordinates[4][5][1]-10) >  ((2)*(posh-center_coordinates[4][5][0]))) && (posv-(center_coordinates[4][5][1]-10)<20)))   &&  (board_in[109] == 0 && board_in[108] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][6][1]-10)) && (posh <= center_coordinates[4][6][0]) && (posv-(center_coordinates[4][6][1]-10) >  ((-2)*(posh-center_coordinates[4][6][0]))) && (posv-(center_coordinates[4][6][1]-10)<20))   || ((posv > (center_coordinates[4][6][1]-10)) && (posh > center_coordinates[4][6][0]) && (posv-(center_coordinates[4][6][1]-10) >  ((2)*(posh-center_coordinates[4][6][0]))) && (posv-(center_coordinates[4][6][1]-10)<20)))   &&  (board_in[107] == 0 && board_in[106] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][7][1]-10)) && (posh <= center_coordinates[4][7][0]) && (posv-(center_coordinates[4][7][1]-10) >  ((-2)*(posh-center_coordinates[4][7][0]))) && (posv-(center_coordinates[4][7][1]-10)<20))   || ((posv > (center_coordinates[4][7][1]-10)) && (posh > center_coordinates[4][7][0]) && (posv-(center_coordinates[4][7][1]-10) >  ((2)*(posh-center_coordinates[4][7][0]))) && (posv-(center_coordinates[4][7][1]-10)<20)))   &&  (board_in[105] == 0 && board_in[104] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][8][1]-10)) && (posh <= center_coordinates[4][8][0]) && (posv-(center_coordinates[4][8][1]-10) >  ((-2)*(posh-center_coordinates[4][8][0]))) && (posv-(center_coordinates[4][8][1]-10)<20))   || ((posv > (center_coordinates[4][8][1]-10)) && (posh > center_coordinates[4][8][0]) && (posv-(center_coordinates[4][8][1]-10) >  ((2)*(posh-center_coordinates[4][8][0]))) && (posv-(center_coordinates[4][8][1]-10)<20)))   &&  (board_in[103] == 0 && board_in[102] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[4][9][1]-10)) && (posh <= center_coordinates[4][9][0]) && (posv-(center_coordinates[4][9][1]-10) >  ((-2)*(posh-center_coordinates[4][9][0]))) && (posv-(center_coordinates[4][9][1]-10)<20))   || ((posv > (center_coordinates[4][9][1]-10)) && (posh > center_coordinates[4][9][0]) && (posv-(center_coordinates[4][9][1]-10) >  ((2)*(posh-center_coordinates[4][9][0]))) && (posv-(center_coordinates[4][9][1]-10)<20)))   &&  (board_in[101] == 0 && board_in[100] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][0][1]-10)) && (posh <= center_coordinates[5][0][0]) && (posv-(center_coordinates[5][0][1]-10) >  ((-2)*(posh-center_coordinates[5][0][0]))) && (posv-(center_coordinates[5][0][1]-10)<20))   || ((posv > (center_coordinates[5][0][1]-10)) && (posh > center_coordinates[5][0][0]) && (posv-(center_coordinates[5][0][1]-10) >  ((2)*(posh-center_coordinates[5][0][0]))) && (posv-(center_coordinates[5][0][1]-10)<20)))   &&  (board_in[99] == 0 && board_in[98] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][1][1]-10)) && (posh <= center_coordinates[5][1][0]) && (posv-(center_coordinates[5][1][1]-10) >  ((-2)*(posh-center_coordinates[5][1][0]))) && (posv-(center_coordinates[5][1][1]-10)<20))   || ((posv > (center_coordinates[5][1][1]-10)) && (posh > center_coordinates[5][1][0]) && (posv-(center_coordinates[5][1][1]-10) >  ((2)*(posh-center_coordinates[5][1][0]))) && (posv-(center_coordinates[5][1][1]-10)<20)))   &&  (board_in[97] == 0 && board_in[96] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][2][1]-10)) && (posh <= center_coordinates[5][2][0]) && (posv-(center_coordinates[5][2][1]-10) >  ((-2)*(posh-center_coordinates[5][2][0]))) && (posv-(center_coordinates[5][2][1]-10)<20))   || ((posv > (center_coordinates[5][2][1]-10)) && (posh > center_coordinates[5][2][0]) && (posv-(center_coordinates[5][2][1]-10) >  ((2)*(posh-center_coordinates[5][2][0]))) && (posv-(center_coordinates[5][2][1]-10)<20)))   &&  (board_in[95] == 0 && board_in[94] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][3][1]-10)) && (posh <= center_coordinates[5][3][0]) && (posv-(center_coordinates[5][3][1]-10) >  ((-2)*(posh-center_coordinates[5][3][0]))) && (posv-(center_coordinates[5][3][1]-10)<20))   || ((posv > (center_coordinates[5][3][1]-10)) && (posh > center_coordinates[5][3][0]) && (posv-(center_coordinates[5][3][1]-10) >  ((2)*(posh-center_coordinates[5][3][0]))) && (posv-(center_coordinates[5][3][1]-10)<20)))   &&  (board_in[93] == 0 && board_in[92] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][4][1]-10)) && (posh <= center_coordinates[5][4][0]) && (posv-(center_coordinates[5][4][1]-10) >  ((-2)*(posh-center_coordinates[5][4][0]))) && (posv-(center_coordinates[5][4][1]-10)<20))   || ((posv > (center_coordinates[5][4][1]-10)) && (posh > center_coordinates[5][4][0]) && (posv-(center_coordinates[5][4][1]-10) >  ((2)*(posh-center_coordinates[5][4][0]))) && (posv-(center_coordinates[5][4][1]-10)<20)))   &&  (board_in[91] == 0 && board_in[90] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][5][1]-10)) && (posh <= center_coordinates[5][5][0]) && (posv-(center_coordinates[5][5][1]-10) >  ((-2)*(posh-center_coordinates[5][5][0]))) && (posv-(center_coordinates[5][5][1]-10)<20))   || ((posv > (center_coordinates[5][5][1]-10)) && (posh > center_coordinates[5][5][0]) && (posv-(center_coordinates[5][5][1]-10) >  ((2)*(posh-center_coordinates[5][5][0]))) && (posv-(center_coordinates[5][5][1]-10)<20)))   &&  (board_in[89] == 0 && board_in[88] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][6][1]-10)) && (posh <= center_coordinates[5][6][0]) && (posv-(center_coordinates[5][6][1]-10) >  ((-2)*(posh-center_coordinates[5][6][0]))) && (posv-(center_coordinates[5][6][1]-10)<20))   || ((posv > (center_coordinates[5][6][1]-10)) && (posh > center_coordinates[5][6][0]) && (posv-(center_coordinates[5][6][1]-10) >  ((2)*(posh-center_coordinates[5][6][0]))) && (posv-(center_coordinates[5][6][1]-10)<20)))   &&  (board_in[87] == 0 && board_in[86] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][7][1]-10)) && (posh <= center_coordinates[5][7][0]) && (posv-(center_coordinates[5][7][1]-10) >  ((-2)*(posh-center_coordinates[5][7][0]))) && (posv-(center_coordinates[5][7][1]-10)<20))   || ((posv > (center_coordinates[5][7][1]-10)) && (posh > center_coordinates[5][7][0]) && (posv-(center_coordinates[5][7][1]-10) >  ((2)*(posh-center_coordinates[5][7][0]))) && (posv-(center_coordinates[5][7][1]-10)<20)))   &&  (board_in[85] == 0 && board_in[84] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][8][1]-10)) && (posh <= center_coordinates[5][8][0]) && (posv-(center_coordinates[5][8][1]-10) >  ((-2)*(posh-center_coordinates[5][8][0]))) && (posv-(center_coordinates[5][8][1]-10)<20))   || ((posv > (center_coordinates[5][8][1]-10)) && (posh > center_coordinates[5][8][0]) && (posv-(center_coordinates[5][8][1]-10) >  ((2)*(posh-center_coordinates[5][8][0]))) && (posv-(center_coordinates[5][8][1]-10)<20)))   &&  (board_in[83] == 0 && board_in[82] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[5][9][1]-10)) && (posh <= center_coordinates[5][9][0]) && (posv-(center_coordinates[5][9][1]-10) >  ((-2)*(posh-center_coordinates[5][9][0]))) && (posv-(center_coordinates[5][9][1]-10)<20))   || ((posv > (center_coordinates[5][9][1]-10)) && (posh > center_coordinates[5][9][0]) && (posv-(center_coordinates[5][9][1]-10) >  ((2)*(posh-center_coordinates[5][9][0]))) && (posv-(center_coordinates[5][9][1]-10)<20)))   &&  (board_in[81] == 0 && board_in[80] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][0][1]-10)) && (posh <= center_coordinates[6][0][0]) && (posv-(center_coordinates[6][0][1]-10) >  ((-2)*(posh-center_coordinates[6][0][0]))) && (posv-(center_coordinates[6][0][1]-10)<20))   || ((posv > (center_coordinates[6][0][1]-10)) && (posh > center_coordinates[6][0][0]) && (posv-(center_coordinates[6][0][1]-10) >  ((2)*(posh-center_coordinates[6][0][0]))) && (posv-(center_coordinates[6][0][1]-10)<20)))   &&  (board_in[79] == 0 && board_in[78] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][1][1]-10)) && (posh <= center_coordinates[6][1][0]) && (posv-(center_coordinates[6][1][1]-10) >  ((-2)*(posh-center_coordinates[6][1][0]))) && (posv-(center_coordinates[6][1][1]-10)<20))   || ((posv > (center_coordinates[6][1][1]-10)) && (posh > center_coordinates[6][1][0]) && (posv-(center_coordinates[6][1][1]-10) >  ((2)*(posh-center_coordinates[6][1][0]))) && (posv-(center_coordinates[6][1][1]-10)<20)))   &&  (board_in[77] == 0 && board_in[76] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][2][1]-10)) && (posh <= center_coordinates[6][2][0]) && (posv-(center_coordinates[6][2][1]-10) >  ((-2)*(posh-center_coordinates[6][2][0]))) && (posv-(center_coordinates[6][2][1]-10)<20))   || ((posv > (center_coordinates[6][2][1]-10)) && (posh > center_coordinates[6][2][0]) && (posv-(center_coordinates[6][2][1]-10) >  ((2)*(posh-center_coordinates[6][2][0]))) && (posv-(center_coordinates[6][2][1]-10)<20)))   &&  (board_in[75] == 0 && board_in[74] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][3][1]-10)) && (posh <= center_coordinates[6][3][0]) && (posv-(center_coordinates[6][3][1]-10) >  ((-2)*(posh-center_coordinates[6][3][0]))) && (posv-(center_coordinates[6][3][1]-10)<20))   || ((posv > (center_coordinates[6][3][1]-10)) && (posh > center_coordinates[6][3][0]) && (posv-(center_coordinates[6][3][1]-10) >  ((2)*(posh-center_coordinates[6][3][0]))) && (posv-(center_coordinates[6][3][1]-10)<20)))   &&  (board_in[73] == 0 && board_in[72] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][4][1]-10)) && (posh <= center_coordinates[6][4][0]) && (posv-(center_coordinates[6][4][1]-10) >  ((-2)*(posh-center_coordinates[6][4][0]))) && (posv-(center_coordinates[6][4][1]-10)<20))   || ((posv > (center_coordinates[6][4][1]-10)) && (posh > center_coordinates[6][4][0]) && (posv-(center_coordinates[6][4][1]-10) >  ((2)*(posh-center_coordinates[6][4][0]))) && (posv-(center_coordinates[6][4][1]-10)<20)))   &&  (board_in[71] == 0 && board_in[70] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][5][1]-10)) && (posh <= center_coordinates[6][5][0]) && (posv-(center_coordinates[6][5][1]-10) >  ((-2)*(posh-center_coordinates[6][5][0]))) && (posv-(center_coordinates[6][5][1]-10)<20))   || ((posv > (center_coordinates[6][5][1]-10)) && (posh > center_coordinates[6][5][0]) && (posv-(center_coordinates[6][5][1]-10) >  ((2)*(posh-center_coordinates[6][5][0]))) && (posv-(center_coordinates[6][5][1]-10)<20)))   &&  (board_in[69] == 0 && board_in[68] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][6][1]-10)) && (posh <= center_coordinates[6][6][0]) && (posv-(center_coordinates[6][6][1]-10) >  ((-2)*(posh-center_coordinates[6][6][0]))) && (posv-(center_coordinates[6][6][1]-10)<20))   || ((posv > (center_coordinates[6][6][1]-10)) && (posh > center_coordinates[6][6][0]) && (posv-(center_coordinates[6][6][1]-10) >  ((2)*(posh-center_coordinates[6][6][0]))) && (posv-(center_coordinates[6][6][1]-10)<20)))   &&  (board_in[67] == 0 && board_in[66] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][7][1]-10)) && (posh <= center_coordinates[6][7][0]) && (posv-(center_coordinates[6][7][1]-10) >  ((-2)*(posh-center_coordinates[6][7][0]))) && (posv-(center_coordinates[6][7][1]-10)<20))   || ((posv > (center_coordinates[6][7][1]-10)) && (posh > center_coordinates[6][7][0]) && (posv-(center_coordinates[6][7][1]-10) >  ((2)*(posh-center_coordinates[6][7][0]))) && (posv-(center_coordinates[6][7][1]-10)<20)))   &&  (board_in[65] == 0 && board_in[64] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][8][1]-10)) && (posh <= center_coordinates[6][8][0]) && (posv-(center_coordinates[6][8][1]-10) >  ((-2)*(posh-center_coordinates[6][8][0]))) && (posv-(center_coordinates[6][8][1]-10)<20))   || ((posv > (center_coordinates[6][8][1]-10)) && (posh > center_coordinates[6][8][0]) && (posv-(center_coordinates[6][8][1]-10) >  ((2)*(posh-center_coordinates[6][8][0]))) && (posv-(center_coordinates[6][8][1]-10)<20)))   &&  (board_in[63] == 0 && board_in[62] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[6][9][1]-10)) && (posh <= center_coordinates[6][9][0]) && (posv-(center_coordinates[6][9][1]-10) >  ((-2)*(posh-center_coordinates[6][9][0]))) && (posv-(center_coordinates[6][9][1]-10)<20))   || ((posv > (center_coordinates[6][9][1]-10)) && (posh > center_coordinates[6][9][0]) && (posv-(center_coordinates[6][9][1]-10) >  ((2)*(posh-center_coordinates[6][9][0]))) && (posv-(center_coordinates[6][9][1]-10)<20)))   &&  (board_in[61] == 0 && board_in[60] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][0][1]-10)) && (posh <= center_coordinates[7][0][0]) && (posv-(center_coordinates[7][0][1]-10) >  ((-2)*(posh-center_coordinates[7][0][0]))) && (posv-(center_coordinates[7][0][1]-10)<20))   || ((posv > (center_coordinates[7][0][1]-10)) && (posh > center_coordinates[7][0][0]) && (posv-(center_coordinates[7][0][1]-10) >  ((2)*(posh-center_coordinates[7][0][0]))) && (posv-(center_coordinates[7][0][1]-10)<20)))   &&  (board_in[59] == 0 && board_in[58] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][1][1]-10)) && (posh <= center_coordinates[7][1][0]) && (posv-(center_coordinates[7][1][1]-10) >  ((-2)*(posh-center_coordinates[7][1][0]))) && (posv-(center_coordinates[7][1][1]-10)<20))   || ((posv > (center_coordinates[7][1][1]-10)) && (posh > center_coordinates[7][1][0]) && (posv-(center_coordinates[7][1][1]-10) >  ((2)*(posh-center_coordinates[7][1][0]))) && (posv-(center_coordinates[7][1][1]-10)<20)))   &&  (board_in[57] == 0 && board_in[56] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][2][1]-10)) && (posh <= center_coordinates[7][2][0]) && (posv-(center_coordinates[7][2][1]-10) >  ((-2)*(posh-center_coordinates[7][2][0]))) && (posv-(center_coordinates[7][2][1]-10)<20))   || ((posv > (center_coordinates[7][2][1]-10)) && (posh > center_coordinates[7][2][0]) && (posv-(center_coordinates[7][2][1]-10) >  ((2)*(posh-center_coordinates[7][2][0]))) && (posv-(center_coordinates[7][2][1]-10)<20)))   &&  (board_in[55] == 0 && board_in[54] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][3][1]-10)) && (posh <= center_coordinates[7][3][0]) && (posv-(center_coordinates[7][3][1]-10) >  ((-2)*(posh-center_coordinates[7][3][0]))) && (posv-(center_coordinates[7][3][1]-10)<20))   || ((posv > (center_coordinates[7][3][1]-10)) && (posh > center_coordinates[7][3][0]) && (posv-(center_coordinates[7][3][1]-10) >  ((2)*(posh-center_coordinates[7][3][0]))) && (posv-(center_coordinates[7][3][1]-10)<20)))   &&  (board_in[53] == 0 && board_in[52] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][4][1]-10)) && (posh <= center_coordinates[7][4][0]) && (posv-(center_coordinates[7][4][1]-10) >  ((-2)*(posh-center_coordinates[7][4][0]))) && (posv-(center_coordinates[7][4][1]-10)<20))   || ((posv > (center_coordinates[7][4][1]-10)) && (posh > center_coordinates[7][4][0]) && (posv-(center_coordinates[7][4][1]-10) >  ((2)*(posh-center_coordinates[7][4][0]))) && (posv-(center_coordinates[7][4][1]-10)<20)))   &&  (board_in[51] == 0 && board_in[50] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][5][1]-10)) && (posh <= center_coordinates[7][5][0]) && (posv-(center_coordinates[7][5][1]-10) >  ((-2)*(posh-center_coordinates[7][5][0]))) && (posv-(center_coordinates[7][5][1]-10)<20))   || ((posv > (center_coordinates[7][5][1]-10)) && (posh > center_coordinates[7][5][0]) && (posv-(center_coordinates[7][5][1]-10) >  ((2)*(posh-center_coordinates[7][5][0]))) && (posv-(center_coordinates[7][5][1]-10)<20)))   &&  (board_in[49] == 0 && board_in[48] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][6][1]-10)) && (posh <= center_coordinates[7][6][0]) && (posv-(center_coordinates[7][6][1]-10) >  ((-2)*(posh-center_coordinates[7][6][0]))) && (posv-(center_coordinates[7][6][1]-10)<20))   || ((posv > (center_coordinates[7][6][1]-10)) && (posh > center_coordinates[7][6][0]) && (posv-(center_coordinates[7][6][1]-10) >  ((2)*(posh-center_coordinates[7][6][0]))) && (posv-(center_coordinates[7][6][1]-10)<20)))   &&  (board_in[47] == 0 && board_in[46] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][7][1]-10)) && (posh <= center_coordinates[7][7][0]) && (posv-(center_coordinates[7][7][1]-10) >  ((-2)*(posh-center_coordinates[7][7][0]))) && (posv-(center_coordinates[7][7][1]-10)<20))   || ((posv > (center_coordinates[7][7][1]-10)) && (posh > center_coordinates[7][7][0]) && (posv-(center_coordinates[7][7][1]-10) >  ((2)*(posh-center_coordinates[7][7][0]))) && (posv-(center_coordinates[7][7][1]-10)<20)))   &&  (board_in[45] == 0 && board_in[44] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][8][1]-10)) && (posh <= center_coordinates[7][8][0]) && (posv-(center_coordinates[7][8][1]-10) >  ((-2)*(posh-center_coordinates[7][8][0]))) && (posv-(center_coordinates[7][8][1]-10)<20))   || ((posv > (center_coordinates[7][8][1]-10)) && (posh > center_coordinates[7][8][0]) && (posv-(center_coordinates[7][8][1]-10) >  ((2)*(posh-center_coordinates[7][8][0]))) && (posv-(center_coordinates[7][8][1]-10)<20)))   &&  (board_in[43] == 0 && board_in[42] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[7][9][1]-10)) && (posh <= center_coordinates[7][9][0]) && (posv-(center_coordinates[7][9][1]-10) >  ((-2)*(posh-center_coordinates[7][9][0]))) && (posv-(center_coordinates[7][9][1]-10)<20))   || ((posv > (center_coordinates[7][9][1]-10)) && (posh > center_coordinates[7][9][0]) && (posv-(center_coordinates[7][9][1]-10) >  ((2)*(posh-center_coordinates[7][9][0]))) && (posv-(center_coordinates[7][9][1]-10)<20)))   &&  (board_in[41] == 0 && board_in[40] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][0][1]-10)) && (posh <= center_coordinates[8][0][0]) && (posv-(center_coordinates[8][0][1]-10) >  ((-2)*(posh-center_coordinates[8][0][0]))) && (posv-(center_coordinates[8][0][1]-10)<20))   || ((posv > (center_coordinates[8][0][1]-10)) && (posh > center_coordinates[8][0][0]) && (posv-(center_coordinates[8][0][1]-10) >  ((2)*(posh-center_coordinates[8][0][0]))) && (posv-(center_coordinates[8][0][1]-10)<20)))   &&  (board_in[39] == 0 && board_in[38] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][1][1]-10)) && (posh <= center_coordinates[8][1][0]) && (posv-(center_coordinates[8][1][1]-10) >  ((-2)*(posh-center_coordinates[8][1][0]))) && (posv-(center_coordinates[8][1][1]-10)<20))   || ((posv > (center_coordinates[8][1][1]-10)) && (posh > center_coordinates[8][1][0]) && (posv-(center_coordinates[8][1][1]-10) >  ((2)*(posh-center_coordinates[8][1][0]))) && (posv-(center_coordinates[8][1][1]-10)<20)))   &&  (board_in[37] == 0 && board_in[36] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][2][1]-10)) && (posh <= center_coordinates[8][2][0]) && (posv-(center_coordinates[8][2][1]-10) >  ((-2)*(posh-center_coordinates[8][2][0]))) && (posv-(center_coordinates[8][2][1]-10)<20))   || ((posv > (center_coordinates[8][2][1]-10)) && (posh > center_coordinates[8][2][0]) && (posv-(center_coordinates[8][2][1]-10) >  ((2)*(posh-center_coordinates[8][2][0]))) && (posv-(center_coordinates[8][2][1]-10)<20)))   &&  (board_in[35] == 0 && board_in[34] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][3][1]-10)) && (posh <= center_coordinates[8][3][0]) && (posv-(center_coordinates[8][3][1]-10) >  ((-2)*(posh-center_coordinates[8][3][0]))) && (posv-(center_coordinates[8][3][1]-10)<20))   || ((posv > (center_coordinates[8][3][1]-10)) && (posh > center_coordinates[8][3][0]) && (posv-(center_coordinates[8][3][1]-10) >  ((2)*(posh-center_coordinates[8][3][0]))) && (posv-(center_coordinates[8][3][1]-10)<20)))   &&  (board_in[33] == 0 && board_in[32] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][4][1]-10)) && (posh <= center_coordinates[8][4][0]) && (posv-(center_coordinates[8][4][1]-10) >  ((-2)*(posh-center_coordinates[8][4][0]))) && (posv-(center_coordinates[8][4][1]-10)<20))   || ((posv > (center_coordinates[8][4][1]-10)) && (posh > center_coordinates[8][4][0]) && (posv-(center_coordinates[8][4][1]-10) >  ((2)*(posh-center_coordinates[8][4][0]))) && (posv-(center_coordinates[8][4][1]-10)<20)))   &&  (board_in[31] == 0 && board_in[30] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][5][1]-10)) && (posh <= center_coordinates[8][5][0]) && (posv-(center_coordinates[8][5][1]-10) >  ((-2)*(posh-center_coordinates[8][5][0]))) && (posv-(center_coordinates[8][5][1]-10)<20))   || ((posv > (center_coordinates[8][5][1]-10)) && (posh > center_coordinates[8][5][0]) && (posv-(center_coordinates[8][5][1]-10) >  ((2)*(posh-center_coordinates[8][5][0]))) && (posv-(center_coordinates[8][5][1]-10)<20)))   &&  (board_in[29] == 0 && board_in[28] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][6][1]-10)) && (posh <= center_coordinates[8][6][0]) && (posv-(center_coordinates[8][6][1]-10) >  ((-2)*(posh-center_coordinates[8][6][0]))) && (posv-(center_coordinates[8][6][1]-10)<20))   || ((posv > (center_coordinates[8][6][1]-10)) && (posh > center_coordinates[8][6][0]) && (posv-(center_coordinates[8][6][1]-10) >  ((2)*(posh-center_coordinates[8][6][0]))) && (posv-(center_coordinates[8][6][1]-10)<20)))   &&  (board_in[27] == 0 && board_in[26] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][7][1]-10)) && (posh <= center_coordinates[8][7][0]) && (posv-(center_coordinates[8][7][1]-10) >  ((-2)*(posh-center_coordinates[8][7][0]))) && (posv-(center_coordinates[8][7][1]-10)<20))   || ((posv > (center_coordinates[8][7][1]-10)) && (posh > center_coordinates[8][7][0]) && (posv-(center_coordinates[8][7][1]-10) >  ((2)*(posh-center_coordinates[8][7][0]))) && (posv-(center_coordinates[8][7][1]-10)<20)))   &&  (board_in[25] == 0 && board_in[24] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][8][1]-10)) && (posh <= center_coordinates[8][8][0]) && (posv-(center_coordinates[8][8][1]-10) >  ((-2)*(posh-center_coordinates[8][8][0]))) && (posv-(center_coordinates[8][8][1]-10)<20))   || ((posv > (center_coordinates[8][8][1]-10)) && (posh > center_coordinates[8][8][0]) && (posv-(center_coordinates[8][8][1]-10) >  ((2)*(posh-center_coordinates[8][8][0]))) && (posv-(center_coordinates[8][8][1]-10)<20)))   &&  (board_in[23] == 0 && board_in[22] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[8][9][1]-10)) && (posh <= center_coordinates[8][9][0]) && (posv-(center_coordinates[8][9][1]-10) >  ((-2)*(posh-center_coordinates[8][9][0]))) && (posv-(center_coordinates[8][9][1]-10)<20))   || ((posv > (center_coordinates[8][9][1]-10)) && (posh > center_coordinates[8][9][0]) && (posv-(center_coordinates[8][9][1]-10) >  ((2)*(posh-center_coordinates[8][9][0]))) && (posv-(center_coordinates[8][9][1]-10)<20)))   &&  (board_in[21] == 0 && board_in[20] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][0][1]-10)) && (posh <= center_coordinates[9][0][0]) && (posv-(center_coordinates[9][0][1]-10) >  ((-2)*(posh-center_coordinates[9][0][0]))) && (posv-(center_coordinates[9][0][1]-10)<20))   || ((posv > (center_coordinates[9][0][1]-10)) && (posh > center_coordinates[9][0][0]) && (posv-(center_coordinates[9][0][1]-10) >  ((2)*(posh-center_coordinates[9][0][0]))) && (posv-(center_coordinates[9][0][1]-10)<20)))   &&  (board_in[19] == 0 && board_in[18] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][1][1]-10)) && (posh <= center_coordinates[9][1][0]) && (posv-(center_coordinates[9][1][1]-10) >  ((-2)*(posh-center_coordinates[9][1][0]))) && (posv-(center_coordinates[9][1][1]-10)<20))   || ((posv > (center_coordinates[9][1][1]-10)) && (posh > center_coordinates[9][1][0]) && (posv-(center_coordinates[9][1][1]-10) >  ((2)*(posh-center_coordinates[9][1][0]))) && (posv-(center_coordinates[9][1][1]-10)<20)))   &&  (board_in[17] == 0 && board_in[16] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][2][1]-10)) && (posh <= center_coordinates[9][2][0]) && (posv-(center_coordinates[9][2][1]-10) >  ((-2)*(posh-center_coordinates[9][2][0]))) && (posv-(center_coordinates[9][2][1]-10)<20))   || ((posv > (center_coordinates[9][2][1]-10)) && (posh > center_coordinates[9][2][0]) && (posv-(center_coordinates[9][2][1]-10) >  ((2)*(posh-center_coordinates[9][2][0]))) && (posv-(center_coordinates[9][2][1]-10)<20)))   &&  (board_in[15] == 0 && board_in[14] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][3][1]-10)) && (posh <= center_coordinates[9][3][0]) && (posv-(center_coordinates[9][3][1]-10) >  ((-2)*(posh-center_coordinates[9][3][0]))) && (posv-(center_coordinates[9][3][1]-10)<20))   || ((posv > (center_coordinates[9][3][1]-10)) && (posh > center_coordinates[9][3][0]) && (posv-(center_coordinates[9][3][1]-10) >  ((2)*(posh-center_coordinates[9][3][0]))) && (posv-(center_coordinates[9][3][1]-10)<20)))   &&  (board_in[13] == 0 && board_in[12] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][4][1]-10)) && (posh <= center_coordinates[9][4][0]) && (posv-(center_coordinates[9][4][1]-10) >  ((-2)*(posh-center_coordinates[9][4][0]))) && (posv-(center_coordinates[9][4][1]-10)<20))   || ((posv > (center_coordinates[9][4][1]-10)) && (posh > center_coordinates[9][4][0]) && (posv-(center_coordinates[9][4][1]-10) >  ((2)*(posh-center_coordinates[9][4][0]))) && (posv-(center_coordinates[9][4][1]-10)<20)))   &&  (board_in[11] == 0 && board_in[10] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][5][1]-10)) && (posh <= center_coordinates[9][5][0]) && (posv-(center_coordinates[9][5][1]-10) >  ((-2)*(posh-center_coordinates[9][5][0]))) && (posv-(center_coordinates[9][5][1]-10)<20))   || ((posv > (center_coordinates[9][5][1]-10)) && (posh > center_coordinates[9][5][0]) && (posv-(center_coordinates[9][5][1]-10) >  ((2)*(posh-center_coordinates[9][5][0]))) && (posv-(center_coordinates[9][5][1]-10)<20)))   &&  (board_in[9] == 0 && board_in[8] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][6][1]-10)) && (posh <= center_coordinates[9][6][0]) && (posv-(center_coordinates[9][6][1]-10) >  ((-2)*(posh-center_coordinates[9][6][0]))) && (posv-(center_coordinates[9][6][1]-10)<20))   || ((posv > (center_coordinates[9][6][1]-10)) && (posh > center_coordinates[9][6][0]) && (posv-(center_coordinates[9][6][1]-10) >  ((2)*(posh-center_coordinates[9][6][0]))) && (posv-(center_coordinates[9][6][1]-10)<20)))   &&  (board_in[7] == 0 && board_in[6] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][7][1]-10)) && (posh <= center_coordinates[9][7][0]) && (posv-(center_coordinates[9][7][1]-10) >  ((-2)*(posh-center_coordinates[9][7][0]))) && (posv-(center_coordinates[9][7][1]-10)<20))   || ((posv > (center_coordinates[9][7][1]-10)) && (posh > center_coordinates[9][7][0]) && (posv-(center_coordinates[9][7][1]-10) >  ((2)*(posh-center_coordinates[9][7][0]))) && (posv-(center_coordinates[9][7][1]-10)<20)))   &&  (board_in[5] == 0 && board_in[4] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][8][1]-10)) && (posh <= center_coordinates[9][8][0]) && (posv-(center_coordinates[9][8][1]-10) >  ((-2)*(posh-center_coordinates[9][8][0]))) && (posv-(center_coordinates[9][8][1]-10)<20))   || ((posv > (center_coordinates[9][8][1]-10)) && (posh > center_coordinates[9][8][0]) && (posv-(center_coordinates[9][8][1]-10) >  ((2)*(posh-center_coordinates[9][8][0]))) && (posv-(center_coordinates[9][8][1]-10)<20)))   &&  (board_in[3] == 0 && board_in[2] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

					  

			if( ( ((posv > (center_coordinates[9][9][1]-10)) && (posh <= center_coordinates[9][9][0]) && (posv-(center_coordinates[9][9][1]-10) >  ((-2)*(posh-center_coordinates[9][9][0]))) && (posv-(center_coordinates[9][9][1]-10)<20))   || ((posv > (center_coordinates[9][9][1]-10)) && (posh > center_coordinates[9][9][0]) && (posv-(center_coordinates[9][9][1]-10) >  ((2)*(posh-center_coordinates[9][9][0]))) && (posv-(center_coordinates[9][9][1]-10)<20)))   &&  (board_in[1] == 0 && board_in[0] == 1) ) 
				 begin
					r <= 0;
					g <= 180;
					b <= 180;
				 end 

  
			// RED SQUARES --------------------------------------------------------------------------------------------------------------------------------
			
			
			

			if( posv > (center_coordinates[0][0][1]-15) && posv < (center_coordinates[0][0][1]+15) && posh < (center_coordinates[0][0][0]+15) && posh > (center_coordinates[0][0][0]-15) && board_in[199] == 1 && board_in[198] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][1][1]-15) && posv < (center_coordinates[0][1][1]+15) && posh < (center_coordinates[0][1][0]+15) && posh > (center_coordinates[0][1][0]-15) && board_in[197] == 1 && board_in[196] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][2][1]-15) && posv < (center_coordinates[0][2][1]+15) && posh < (center_coordinates[0][2][0]+15) && posh > (center_coordinates[0][2][0]-15) && board_in[195] == 1 && board_in[194] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][3][1]-15) && posv < (center_coordinates[0][3][1]+15) && posh < (center_coordinates[0][3][0]+15) && posh > (center_coordinates[0][3][0]-15) && board_in[193] == 1 && board_in[192] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][4][1]-15) && posv < (center_coordinates[0][4][1]+15) && posh < (center_coordinates[0][4][0]+15) && posh > (center_coordinates[0][4][0]-15) && board_in[191] == 1 && board_in[190] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][5][1]-15) && posv < (center_coordinates[0][5][1]+15) && posh < (center_coordinates[0][5][0]+15) && posh > (center_coordinates[0][5][0]-15) && board_in[189] == 1 && board_in[188] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][6][1]-15) && posv < (center_coordinates[0][6][1]+15) && posh < (center_coordinates[0][6][0]+15) && posh > (center_coordinates[0][6][0]-15) && board_in[187] == 1 && board_in[186] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][7][1]-15) && posv < (center_coordinates[0][7][1]+15) && posh < (center_coordinates[0][7][0]+15) && posh > (center_coordinates[0][7][0]-15) && board_in[185] == 1 && board_in[184] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][8][1]-15) && posv < (center_coordinates[0][8][1]+15) && posh < (center_coordinates[0][8][0]+15) && posh > (center_coordinates[0][8][0]-15) && board_in[183] == 1 && board_in[182] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[0][9][1]-15) && posv < (center_coordinates[0][9][1]+15) && posh < (center_coordinates[0][9][0]+15) && posh > (center_coordinates[0][9][0]-15) && board_in[181] == 1 && board_in[180] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][0][1]-15) && posv < (center_coordinates[1][0][1]+15) && posh < (center_coordinates[1][0][0]+15) && posh > (center_coordinates[1][0][0]-15) && board_in[179] == 1 && board_in[178] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][1][1]-15) && posv < (center_coordinates[1][1][1]+15) && posh < (center_coordinates[1][1][0]+15) && posh > (center_coordinates[1][1][0]-15) && board_in[177] == 1 && board_in[176] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][2][1]-15) && posv < (center_coordinates[1][2][1]+15) && posh < (center_coordinates[1][2][0]+15) && posh > (center_coordinates[1][2][0]-15) && board_in[175] == 1 && board_in[174] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][3][1]-15) && posv < (center_coordinates[1][3][1]+15) && posh < (center_coordinates[1][3][0]+15) && posh > (center_coordinates[1][3][0]-15) && board_in[173] == 1 && board_in[172] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][4][1]-15) && posv < (center_coordinates[1][4][1]+15) && posh < (center_coordinates[1][4][0]+15) && posh > (center_coordinates[1][4][0]-15) && board_in[171] == 1 && board_in[170] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][5][1]-15) && posv < (center_coordinates[1][5][1]+15) && posh < (center_coordinates[1][5][0]+15) && posh > (center_coordinates[1][5][0]-15) && board_in[169] == 1 && board_in[168] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][6][1]-15) && posv < (center_coordinates[1][6][1]+15) && posh < (center_coordinates[1][6][0]+15) && posh > (center_coordinates[1][6][0]-15) && board_in[167] == 1 && board_in[166] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][7][1]-15) && posv < (center_coordinates[1][7][1]+15) && posh < (center_coordinates[1][7][0]+15) && posh > (center_coordinates[1][7][0]-15) && board_in[165] == 1 && board_in[164] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][8][1]-15) && posv < (center_coordinates[1][8][1]+15) && posh < (center_coordinates[1][8][0]+15) && posh > (center_coordinates[1][8][0]-15) && board_in[163] == 1 && board_in[162] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[1][9][1]-15) && posv < (center_coordinates[1][9][1]+15) && posh < (center_coordinates[1][9][0]+15) && posh > (center_coordinates[1][9][0]-15) && board_in[161] == 1 && board_in[160] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][0][1]-15) && posv < (center_coordinates[2][0][1]+15) && posh < (center_coordinates[2][0][0]+15) && posh > (center_coordinates[2][0][0]-15) && board_in[159] == 1 && board_in[158] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][1][1]-15) && posv < (center_coordinates[2][1][1]+15) && posh < (center_coordinates[2][1][0]+15) && posh > (center_coordinates[2][1][0]-15) && board_in[157] == 1 && board_in[156] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][2][1]-15) && posv < (center_coordinates[2][2][1]+15) && posh < (center_coordinates[2][2][0]+15) && posh > (center_coordinates[2][2][0]-15) && board_in[155] == 1 && board_in[154] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][3][1]-15) && posv < (center_coordinates[2][3][1]+15) && posh < (center_coordinates[2][3][0]+15) && posh > (center_coordinates[2][3][0]-15) && board_in[153] == 1 && board_in[152] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][4][1]-15) && posv < (center_coordinates[2][4][1]+15) && posh < (center_coordinates[2][4][0]+15) && posh > (center_coordinates[2][4][0]-15) && board_in[151] == 1 && board_in[150] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][5][1]-15) && posv < (center_coordinates[2][5][1]+15) && posh < (center_coordinates[2][5][0]+15) && posh > (center_coordinates[2][5][0]-15) && board_in[149] == 1 && board_in[148] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][6][1]-15) && posv < (center_coordinates[2][6][1]+15) && posh < (center_coordinates[2][6][0]+15) && posh > (center_coordinates[2][6][0]-15) && board_in[147] == 1 && board_in[146] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][7][1]-15) && posv < (center_coordinates[2][7][1]+15) && posh < (center_coordinates[2][7][0]+15) && posh > (center_coordinates[2][7][0]-15) && board_in[145] == 1 && board_in[144] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][8][1]-15) && posv < (center_coordinates[2][8][1]+15) && posh < (center_coordinates[2][8][0]+15) && posh > (center_coordinates[2][8][0]-15) && board_in[143] == 1 && board_in[142] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[2][9][1]-15) && posv < (center_coordinates[2][9][1]+15) && posh < (center_coordinates[2][9][0]+15) && posh > (center_coordinates[2][9][0]-15) && board_in[141] == 1 && board_in[140] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][0][1]-15) && posv < (center_coordinates[3][0][1]+15) && posh < (center_coordinates[3][0][0]+15) && posh > (center_coordinates[3][0][0]-15) && board_in[139] == 1 && board_in[138] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][1][1]-15) && posv < (center_coordinates[3][1][1]+15) && posh < (center_coordinates[3][1][0]+15) && posh > (center_coordinates[3][1][0]-15) && board_in[137] == 1 && board_in[136] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][2][1]-15) && posv < (center_coordinates[3][2][1]+15) && posh < (center_coordinates[3][2][0]+15) && posh > (center_coordinates[3][2][0]-15) && board_in[135] == 1 && board_in[134] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][3][1]-15) && posv < (center_coordinates[3][3][1]+15) && posh < (center_coordinates[3][3][0]+15) && posh > (center_coordinates[3][3][0]-15) && board_in[133] == 1 && board_in[132] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][4][1]-15) && posv < (center_coordinates[3][4][1]+15) && posh < (center_coordinates[3][4][0]+15) && posh > (center_coordinates[3][4][0]-15) && board_in[131] == 1 && board_in[130] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][5][1]-15) && posv < (center_coordinates[3][5][1]+15) && posh < (center_coordinates[3][5][0]+15) && posh > (center_coordinates[3][5][0]-15) && board_in[129] == 1 && board_in[128] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][6][1]-15) && posv < (center_coordinates[3][6][1]+15) && posh < (center_coordinates[3][6][0]+15) && posh > (center_coordinates[3][6][0]-15) && board_in[127] == 1 && board_in[126] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][7][1]-15) && posv < (center_coordinates[3][7][1]+15) && posh < (center_coordinates[3][7][0]+15) && posh > (center_coordinates[3][7][0]-15) && board_in[125] == 1 && board_in[124] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][8][1]-15) && posv < (center_coordinates[3][8][1]+15) && posh < (center_coordinates[3][8][0]+15) && posh > (center_coordinates[3][8][0]-15) && board_in[123] == 1 && board_in[122] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[3][9][1]-15) && posv < (center_coordinates[3][9][1]+15) && posh < (center_coordinates[3][9][0]+15) && posh > (center_coordinates[3][9][0]-15) && board_in[121] == 1 && board_in[120] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][0][1]-15) && posv < (center_coordinates[4][0][1]+15) && posh < (center_coordinates[4][0][0]+15) && posh > (center_coordinates[4][0][0]-15) && board_in[119] == 1 && board_in[118] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][1][1]-15) && posv < (center_coordinates[4][1][1]+15) && posh < (center_coordinates[4][1][0]+15) && posh > (center_coordinates[4][1][0]-15) && board_in[117] == 1 && board_in[116] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][2][1]-15) && posv < (center_coordinates[4][2][1]+15) && posh < (center_coordinates[4][2][0]+15) && posh > (center_coordinates[4][2][0]-15) && board_in[115] == 1 && board_in[114] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][3][1]-15) && posv < (center_coordinates[4][3][1]+15) && posh < (center_coordinates[4][3][0]+15) && posh > (center_coordinates[4][3][0]-15) && board_in[113] == 1 && board_in[112] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][4][1]-15) && posv < (center_coordinates[4][4][1]+15) && posh < (center_coordinates[4][4][0]+15) && posh > (center_coordinates[4][4][0]-15) && board_in[111] == 1 && board_in[110] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][5][1]-15) && posv < (center_coordinates[4][5][1]+15) && posh < (center_coordinates[4][5][0]+15) && posh > (center_coordinates[4][5][0]-15) && board_in[109] == 1 && board_in[108] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][6][1]-15) && posv < (center_coordinates[4][6][1]+15) && posh < (center_coordinates[4][6][0]+15) && posh > (center_coordinates[4][6][0]-15) && board_in[107] == 1 && board_in[106] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][7][1]-15) && posv < (center_coordinates[4][7][1]+15) && posh < (center_coordinates[4][7][0]+15) && posh > (center_coordinates[4][7][0]-15) && board_in[105] == 1 && board_in[104] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][8][1]-15) && posv < (center_coordinates[4][8][1]+15) && posh < (center_coordinates[4][8][0]+15) && posh > (center_coordinates[4][8][0]-15) && board_in[103] == 1 && board_in[102] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[4][9][1]-15) && posv < (center_coordinates[4][9][1]+15) && posh < (center_coordinates[4][9][0]+15) && posh > (center_coordinates[4][9][0]-15) && board_in[101] == 1 && board_in[100] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][0][1]-15) && posv < (center_coordinates[5][0][1]+15) && posh < (center_coordinates[5][0][0]+15) && posh > (center_coordinates[5][0][0]-15) && board_in[99] == 1 && board_in[98] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][1][1]-15) && posv < (center_coordinates[5][1][1]+15) && posh < (center_coordinates[5][1][0]+15) && posh > (center_coordinates[5][1][0]-15) && board_in[97] == 1 && board_in[96] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][2][1]-15) && posv < (center_coordinates[5][2][1]+15) && posh < (center_coordinates[5][2][0]+15) && posh > (center_coordinates[5][2][0]-15) && board_in[95] == 1 && board_in[94] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][3][1]-15) && posv < (center_coordinates[5][3][1]+15) && posh < (center_coordinates[5][3][0]+15) && posh > (center_coordinates[5][3][0]-15) && board_in[93] == 1 && board_in[92] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][4][1]-15) && posv < (center_coordinates[5][4][1]+15) && posh < (center_coordinates[5][4][0]+15) && posh > (center_coordinates[5][4][0]-15) && board_in[91] == 1 && board_in[90] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][5][1]-15) && posv < (center_coordinates[5][5][1]+15) && posh < (center_coordinates[5][5][0]+15) && posh > (center_coordinates[5][5][0]-15) && board_in[89] == 1 && board_in[88] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][6][1]-15) && posv < (center_coordinates[5][6][1]+15) && posh < (center_coordinates[5][6][0]+15) && posh > (center_coordinates[5][6][0]-15) && board_in[87] == 1 && board_in[86] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][7][1]-15) && posv < (center_coordinates[5][7][1]+15) && posh < (center_coordinates[5][7][0]+15) && posh > (center_coordinates[5][7][0]-15) && board_in[85] == 1 && board_in[84] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][8][1]-15) && posv < (center_coordinates[5][8][1]+15) && posh < (center_coordinates[5][8][0]+15) && posh > (center_coordinates[5][8][0]-15) && board_in[83] == 1 && board_in[82] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[5][9][1]-15) && posv < (center_coordinates[5][9][1]+15) && posh < (center_coordinates[5][9][0]+15) && posh > (center_coordinates[5][9][0]-15) && board_in[81] == 1 && board_in[80] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][0][1]-15) && posv < (center_coordinates[6][0][1]+15) && posh < (center_coordinates[6][0][0]+15) && posh > (center_coordinates[6][0][0]-15) && board_in[79] == 1 && board_in[78] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][1][1]-15) && posv < (center_coordinates[6][1][1]+15) && posh < (center_coordinates[6][1][0]+15) && posh > (center_coordinates[6][1][0]-15) && board_in[77] == 1 && board_in[76] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][2][1]-15) && posv < (center_coordinates[6][2][1]+15) && posh < (center_coordinates[6][2][0]+15) && posh > (center_coordinates[6][2][0]-15) && board_in[75] == 1 && board_in[74] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][3][1]-15) && posv < (center_coordinates[6][3][1]+15) && posh < (center_coordinates[6][3][0]+15) && posh > (center_coordinates[6][3][0]-15) && board_in[73] == 1 && board_in[72] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][4][1]-15) && posv < (center_coordinates[6][4][1]+15) && posh < (center_coordinates[6][4][0]+15) && posh > (center_coordinates[6][4][0]-15) && board_in[71] == 1 && board_in[70] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][5][1]-15) && posv < (center_coordinates[6][5][1]+15) && posh < (center_coordinates[6][5][0]+15) && posh > (center_coordinates[6][5][0]-15) && board_in[69] == 1 && board_in[68] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][6][1]-15) && posv < (center_coordinates[6][6][1]+15) && posh < (center_coordinates[6][6][0]+15) && posh > (center_coordinates[6][6][0]-15) && board_in[67] == 1 && board_in[66] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][7][1]-15) && posv < (center_coordinates[6][7][1]+15) && posh < (center_coordinates[6][7][0]+15) && posh > (center_coordinates[6][7][0]-15) && board_in[65] == 1 && board_in[64] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][8][1]-15) && posv < (center_coordinates[6][8][1]+15) && posh < (center_coordinates[6][8][0]+15) && posh > (center_coordinates[6][8][0]-15) && board_in[63] == 1 && board_in[62] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[6][9][1]-15) && posv < (center_coordinates[6][9][1]+15) && posh < (center_coordinates[6][9][0]+15) && posh > (center_coordinates[6][9][0]-15) && board_in[61] == 1 && board_in[60] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][0][1]-15) && posv < (center_coordinates[7][0][1]+15) && posh < (center_coordinates[7][0][0]+15) && posh > (center_coordinates[7][0][0]-15) && board_in[59] == 1 && board_in[58] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][1][1]-15) && posv < (center_coordinates[7][1][1]+15) && posh < (center_coordinates[7][1][0]+15) && posh > (center_coordinates[7][1][0]-15) && board_in[57] == 1 && board_in[56] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][2][1]-15) && posv < (center_coordinates[7][2][1]+15) && posh < (center_coordinates[7][2][0]+15) && posh > (center_coordinates[7][2][0]-15) && board_in[55] == 1 && board_in[54] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][3][1]-15) && posv < (center_coordinates[7][3][1]+15) && posh < (center_coordinates[7][3][0]+15) && posh > (center_coordinates[7][3][0]-15) && board_in[53] == 1 && board_in[52] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][4][1]-15) && posv < (center_coordinates[7][4][1]+15) && posh < (center_coordinates[7][4][0]+15) && posh > (center_coordinates[7][4][0]-15) && board_in[51] == 1 && board_in[50] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][5][1]-15) && posv < (center_coordinates[7][5][1]+15) && posh < (center_coordinates[7][5][0]+15) && posh > (center_coordinates[7][5][0]-15) && board_in[49] == 1 && board_in[48] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][6][1]-15) && posv < (center_coordinates[7][6][1]+15) && posh < (center_coordinates[7][6][0]+15) && posh > (center_coordinates[7][6][0]-15) && board_in[47] == 1 && board_in[46] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][7][1]-15) && posv < (center_coordinates[7][7][1]+15) && posh < (center_coordinates[7][7][0]+15) && posh > (center_coordinates[7][7][0]-15) && board_in[45] == 1 && board_in[44] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][8][1]-15) && posv < (center_coordinates[7][8][1]+15) && posh < (center_coordinates[7][8][0]+15) && posh > (center_coordinates[7][8][0]-15) && board_in[43] == 1 && board_in[42] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[7][9][1]-15) && posv < (center_coordinates[7][9][1]+15) && posh < (center_coordinates[7][9][0]+15) && posh > (center_coordinates[7][9][0]-15) && board_in[41] == 1 && board_in[40] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][0][1]-15) && posv < (center_coordinates[8][0][1]+15) && posh < (center_coordinates[8][0][0]+15) && posh > (center_coordinates[8][0][0]-15) && board_in[39] == 1 && board_in[38] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][1][1]-15) && posv < (center_coordinates[8][1][1]+15) && posh < (center_coordinates[8][1][0]+15) && posh > (center_coordinates[8][1][0]-15) && board_in[37] == 1 && board_in[36] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][2][1]-15) && posv < (center_coordinates[8][2][1]+15) && posh < (center_coordinates[8][2][0]+15) && posh > (center_coordinates[8][2][0]-15) && board_in[35] == 1 && board_in[34] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][3][1]-15) && posv < (center_coordinates[8][3][1]+15) && posh < (center_coordinates[8][3][0]+15) && posh > (center_coordinates[8][3][0]-15) && board_in[33] == 1 && board_in[32] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][4][1]-15) && posv < (center_coordinates[8][4][1]+15) && posh < (center_coordinates[8][4][0]+15) && posh > (center_coordinates[8][4][0]-15) && board_in[31] == 1 && board_in[30] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][5][1]-15) && posv < (center_coordinates[8][5][1]+15) && posh < (center_coordinates[8][5][0]+15) && posh > (center_coordinates[8][5][0]-15) && board_in[29] == 1 && board_in[28] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][6][1]-15) && posv < (center_coordinates[8][6][1]+15) && posh < (center_coordinates[8][6][0]+15) && posh > (center_coordinates[8][6][0]-15) && board_in[27] == 1 && board_in[26] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][7][1]-15) && posv < (center_coordinates[8][7][1]+15) && posh < (center_coordinates[8][7][0]+15) && posh > (center_coordinates[8][7][0]-15) && board_in[25] == 1 && board_in[24] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][8][1]-15) && posv < (center_coordinates[8][8][1]+15) && posh < (center_coordinates[8][8][0]+15) && posh > (center_coordinates[8][8][0]-15) && board_in[23] == 1 && board_in[22] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[8][9][1]-15) && posv < (center_coordinates[8][9][1]+15) && posh < (center_coordinates[8][9][0]+15) && posh > (center_coordinates[8][9][0]-15) && board_in[21] == 1 && board_in[20] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][0][1]-15) && posv < (center_coordinates[9][0][1]+15) && posh < (center_coordinates[9][0][0]+15) && posh > (center_coordinates[9][0][0]-15) && board_in[19] == 1 && board_in[18] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][1][1]-15) && posv < (center_coordinates[9][1][1]+15) && posh < (center_coordinates[9][1][0]+15) && posh > (center_coordinates[9][1][0]-15) && board_in[17] == 1 && board_in[16] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][2][1]-15) && posv < (center_coordinates[9][2][1]+15) && posh < (center_coordinates[9][2][0]+15) && posh > (center_coordinates[9][2][0]-15) && board_in[15] == 1 && board_in[14] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][3][1]-15) && posv < (center_coordinates[9][3][1]+15) && posh < (center_coordinates[9][3][0]+15) && posh > (center_coordinates[9][3][0]-15) && board_in[13] == 1 && board_in[12] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][4][1]-15) && posv < (center_coordinates[9][4][1]+15) && posh < (center_coordinates[9][4][0]+15) && posh > (center_coordinates[9][4][0]-15) && board_in[11] == 1 && board_in[10] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][5][1]-15) && posv < (center_coordinates[9][5][1]+15) && posh < (center_coordinates[9][5][0]+15) && posh > (center_coordinates[9][5][0]-15) && board_in[9] == 1 && board_in[8] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][6][1]-15) && posv < (center_coordinates[9][6][1]+15) && posh < (center_coordinates[9][6][0]+15) && posh > (center_coordinates[9][6][0]-15) && board_in[7] == 1 && board_in[6] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][7][1]-15) && posv < (center_coordinates[9][7][1]+15) && posh < (center_coordinates[9][7][0]+15) && posh > (center_coordinates[9][7][0]-15) && board_in[5] == 1 && board_in[4] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][8][1]-15) && posv < (center_coordinates[9][8][1]+15) && posh < (center_coordinates[9][8][0]+15) && posh > (center_coordinates[9][8][0]-15) && board_in[3] == 1 && board_in[2] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end


			if( posv > (center_coordinates[9][9][1]-15) && posv < (center_coordinates[9][9][1]+15) && posh < (center_coordinates[9][9][0]+15) && posh > (center_coordinates[9][9][0]-15) && board_in[1] == 1 && board_in[0] == 1  )
				 begin
					r <= 180;
					g <= 0;
					b <= 0;
				 end
				 
				 
		 // TEXTS -----------------------------------------------------------------------------------------------------------------------------------------
		 
		 /* Total move symbol left
				if((posv>275 && posv<279) && (posh>174 && posh <210)) 
					begin	
						r<=150;
						g<=0;
						b<=255;
					end
				if((posv>279 && posv<314) && (posh>190 && posh <194)) 
					begin	
						r<=150;
						g<=0;
						b<=255;
					end
					
				// Total move symbol right
				if((posv>275 && posv<279) && (posh>727 && posh <753)) 
					begin	
						r<=150;
						g<=0;
						b<=255;
					end
				if((posv>279 && posv<314) && (posh>733 && posh <737)) 
					begin	
						r<=150;
						g<=0;
						b<=255;
					end

				// Total Win Symbol left
				if((posv>379 && posv<383) && (posh>174 && posh <214)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>210 && posh <214)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>192 && posh <196)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>174 && posh <178)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end

				// Total Win Symbol Right
				if((posv>379 && posv<383) && (posh>705 && posh <753)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>749 && posh <753)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>727 && posh <731)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end
				if((posv>344 && posv<379) && (posh>705 && posh <709)) 
					begin	
						r<=255;
						g<=210;
						b<=0;
					end  */

			
			end
												
	
end

assign vga_r = ((posh> 144 && posh <= 783 && posv>35 && posv<=514) ? r:0);
assign vga_g = ((posh> 144 && posh <= 783 && posv>35 && posv<=514) ? g:0); 
assign vga_b = ((posh> 144 && posh <= 783 && posv>35 && posv<=514) ? b:0);
endmodule



