
module start_check(
  input strt_chk_en,
  input sampled_bit,
  output reg strt_glitch
  );
  
  always @(*)
  begin  
    
     if(strt_chk_en)
      begin
        
        if(sampled_bit == 1'd0)
          begin
            strt_glitch <= 1'd0;
          end
        else
          begin
            strt_glitch <= 1'd1;
          end
          
      end
      
    else
      begin
        strt_glitch <= 1'd0;
      end
      
  end
  
endmodule