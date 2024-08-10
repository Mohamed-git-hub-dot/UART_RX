
module data_sampling(
  input CLK,RST,
  input RX_IN,
  input [4:0] prescale,
  input dat_samp_en,
  input [2:0] edge_count,
  output reg sampled_bit
  );
  
  wire [4:0] pre,pre1,pre2; 
  reg [2:0] DATA;
  wire flag;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        sampled_bit <= 1'd0;
        DATA <= 3'd0;
      end
      
    else if(dat_samp_en)
      begin
        if(edge_count == (pre1 - 1'd1))
          begin
            DATA[0] <= RX_IN;
          end
          
        else if(edge_count == (pre-1'd1) )
          begin
            DATA[1] <= RX_IN;
          end
          
        else if(edge_count == (pre2 - 1'd1) )
          begin
            DATA[2] <= RX_IN;
          end
          
        if( (flag) && (DATA[0] && DATA[1] && DATA[2]) || (DATA[0] && DATA[1]) || (DATA[0] && DATA[2]) || (DATA[1] && DATA[2]) )
          begin
            sampled_bit <= 1'd1;
          end
        else
          begin
            sampled_bit <= 1'd0;
          end
          
        end
  end
  
  assign pre = prescale >> 1;
  assign pre1 = pre - 1'd1;
  assign pre2 = pre + 1'd1; 
  
  assign flag = (edge_count == pre2 || edge_count == pre2-1'd1 )?  (1'd1):(1'd0);
  
endmodule
