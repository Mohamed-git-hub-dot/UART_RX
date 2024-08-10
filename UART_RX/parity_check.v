
module parity_check(
  input par_chk_en,PAR_TYP,
  input [7:0] P_DATA,
  input sampled_bit,
  output reg par_err
  );
  
  parameter EVEN_PARITY = 1'd0,
            ODD_PARITY = 1'd1;
            
  reg parity_calc;
  
  always @(*)
  begin
    
    par_err <= 1'd0;
    parity_calc <= 1'd0;
    
    if(par_chk_en)
      begin
        
        if(PAR_TYP == EVEN_PARITY)
          begin
            parity_calc <= ^P_DATA;
          end
        else
          begin
            parity_calc <= ~^P_DATA;
          end
          
          if(parity_calc == sampled_bit)
            begin
              par_err <= 1'd0;
            end
          else
            begin
              par_err <= 1'd1;
            end
      end
      
    else 
      begin
        par_err <= 1'd0;
        parity_calc <= 1'd0;
      end
    
  end
  
endmodule
