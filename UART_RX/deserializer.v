
module deserializer(
  input CLK,RST,
  input deser_en,
  input sampled_bit,
  output reg [7:0] P_DATA
  );
  
  reg [5:0] cntr;
  reg [2:0] i;
  
  always @(posedge CLK or negedge RST)
  begin
    
    if(!RST)
      begin
        P_DATA <= 8'd0;
        i <= 3'd0;
        cntr <= 6'd0;
      end
      
    else if(deser_en)
      begin
        
        if(cntr == 6'd7 || cntr == 6'd15 || cntr == 6'd23 || cntr == 6'd31 || cntr == 6'd39 || cntr == 6'd47 || cntr == 6'd55 || cntr == 6'd63)
          begin
            P_DATA[i] <= sampled_bit;
            i <= i + 1'd1;
          end
          
        cntr <= cntr + 1'd1;
        
      end
    
  end
  
endmodule