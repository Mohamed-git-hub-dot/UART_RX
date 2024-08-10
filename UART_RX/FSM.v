
module FSM(
  input CLK,RST,
  input RX_IN,
  input PAR_EN,
  input [2:0] edge_cnt,
  input [3:0] bit_cnt,
  input stp_err,par_err,strt_glitch,
  output reg dat_samp_en,enable,deser_en,
  output reg par_chk_en,strt_chk_en,stop_chk_en,
  output reg check,
  output reg data_valid 
  );
  
  parameter [2:0]  IDLE = 3'b000,
                   START = 3'b001,
                   DATA = 3'b010,
                   PARITY = 3'b011,
                   STOP = 3'b100; 
  
  reg [2:0] curr_state,next_state;
  
  always @(posedge CLK or negedge RST)
  begin
    if(!RST)
      begin
        curr_state <= IDLE;
      end
      
    else
      begin
        curr_state <= next_state;
      end
  end
  
  always @(*)
  begin
    
    case(curr_state)
      
      IDLE:
      begin
        
        check = 1'd1;
        dat_samp_en = 1'd0;
        enable = 1'd0;
        deser_en = 1'd0;
        par_chk_en = 1'd0;
        strt_chk_en = 1'd0;
        stop_chk_en = 1'd0;
        data_valid = 1'd0;
        
        if(RX_IN == 1'd0)
          begin
            next_state = START;
          end
        else
          begin
            next_state = IDLE;
          end
  
      end
      
      START:
      begin
        
        check = 1'd0;
        dat_samp_en = 1'd1;
        enable = 1'd1;
        deser_en = 1'd0;
        par_chk_en = 1'd0;
        stop_chk_en = 1'd0;
        data_valid = 1'd0;
        
        if(edge_cnt  == 3'd6 || edge_cnt == 3'd7)
          begin
            strt_chk_en = 1'd1;
          end
        else
          begin
            strt_chk_en = 1'd0;
          end
        
        if(edge_cnt == 3'd7 && bit_cnt == 4'd0)
          begin
            if(strt_glitch == 1'd1)
              begin
                next_state = IDLE;
              end
            else
              begin
                next_state = DATA;
              end
          end
          
        else
          begin
            next_state = START;
          end
        
      end
      
      DATA:
      begin
      
        check = 1'd0;     
        dat_samp_en = 1'd1;
        enable = 1'd1;
        deser_en = 1'd1;
        par_chk_en = 1'd0;
        strt_chk_en = 1'd0;
        stop_chk_en = 1'd0;
        data_valid = 1'd0;
        
        if(edge_cnt == 3'd7 && bit_cnt == 4'd8)
          begin
            if(PAR_EN == 1'd1)
              begin
                next_state = PARITY;
              end
            else
              begin
                next_state = STOP;
              end
          end
          
        else
          begin
            next_state = DATA;
          end
          
      end
      
      PARITY:
      begin
        
        check = 1'd0;
        dat_samp_en = 1'd1;
        enable = 1'd1;
        deser_en = 1'd0;
        strt_chk_en = 1'd0;
        stop_chk_en = 1'd0;
        data_valid = 1'd0;
        
        if(edge_cnt == 3'd6 || edge_cnt ==  3'd7)
          begin
            par_chk_en = 1'd1;
          end
        else
          begin
            par_chk_en = 1'd0;
          end
        
        if(edge_cnt == 3'd7 && bit_cnt == 4'd9)
          begin
            if(par_err == 1'd1)
              begin
                next_state = IDLE;
              end
            else
              begin
                next_state = STOP;
              end
          end
          
        else
          begin
            next_state = PARITY;
          end
      end
      
      STOP:
      begin
        
        check = 1'd0;
        dat_samp_en = 1'd1;
        enable = 1'd1;
        deser_en = 1'd0;
        par_chk_en = 1'd0;
        strt_chk_en = 1'd0;
        
        if(edge_cnt == 3'd6 || edge_cnt == 3'd7)
          begin
            stop_chk_en = 1'd1;
          end
        else
          begin
            stop_chk_en = 1'd0;
          end
        
        if(PAR_EN && edge_cnt == 3'd7 && bit_cnt == 4'd10)
          begin
            
            if(stp_err == 1'd1)
              begin
                next_state = IDLE;
                data_valid = 1'd0;
              end
            else
              begin
                next_state = IDLE;
                data_valid = 1'd1;
              end
          end
          
        else if(!PAR_EN && edge_cnt == 3'd7 && bit_cnt == 4'd9)
          begin
            
            if(stp_err == 1'd1)
              begin
                next_state = IDLE;
                data_valid = 1'd0;
              end
            else
              begin
                next_state = IDLE;
                data_valid = 1'd1;
              end
          end
          
        else
          begin
            next_state = STOP;
          end
      end
      
      default:
      begin
        
        check = 1'd0;
        next_state = IDLE;
        dat_samp_en = 1'd0;
        enable = 1'd0;
        deser_en = 1'd0;
        par_chk_en = 1'd0;
        strt_chk_en = 1'd0;
        stop_chk_en = 1'd0;
        data_valid = 1'd0;
        
      end
      
    endcase
    
  end
  
endmodule
