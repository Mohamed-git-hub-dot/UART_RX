
module stop_check(
  input stp_chk_en,
  input sampled_bit,
  output reg stp_err
  );
  
  always @(*)
  begin
    
    if(stp_chk_en)
      begin
         if(sampled_bit == 1'd1)
           begin
             stp_err <= 1'd0;
           end
           
         else
           begin
             stp_err <= 1'd1;
           end
      end
      
    else
      begin
        stp_err <= 1'd0;
      end
      
  end
  
endmodule
