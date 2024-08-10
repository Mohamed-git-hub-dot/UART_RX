
module edge_bit_counter(
  input CLK,RST,
  input check,
  input enable,
  output reg [3:0] bit_count,
  output reg [2:0] edge_count
  );
  
  wire flag;
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        edge_count <= 3'd0;
        bit_count <= 4'd0;
      end
      
    else if(enable && edge_count < 3'd7)
      begin
        edge_count <= edge_count + 1'd1;
      end
      
    else if(enable && flag)
      begin
        bit_count <= bit_count + 1'd1;
        edge_count <= 3'd0;
      end
      
    if(check == 1'd1)
      begin
        bit_count <= 3'd0;
      end
      
  end
  
  assign flag = (edge_count == 3'd7)?  (1'd1):(1'd0);
  
endmodule
