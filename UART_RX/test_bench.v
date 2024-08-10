`timescale 1ns/1ps

module test_bench();

reg CLK,RST;
reg RX_IN;
reg PAR_EN,PAR_TYP;
reg [4:0] prescale;
wire [7:0] P_DATA;
wire DATA_VALID; 

always #(2.5) CLK = ~ CLK;

TOP DUT(
.CLK(CLK),
.RST(RST),
.RX_IN(RX_IN),
.PAR_EN(PAR_EN),
.PAR_TYP(PAR_TYP),
.prescale(prescale),
.P_DATA(P_DATA),
.DATA_VALID(DATA_VALID)
);


initial
begin
  
  $dumpfile("test_bench.vcd");
  $dumpvars;
  
  CLK = 1'd0;
  PAR_EN = 1'd0;
  PAR_TYP = 1'd0;
  
  RESET();
  
  prescale = 5'd8;
  PAR_EN = 1'd1;
  PAR_TYP = 1'd0;
  
  //RX_IN = 1'd0;
  //#(5*4)
  RX_IN = 1'd0;
  #(5*8)
  //RX_IN = 1'd1;
  //#(2*5)
  //RX_IN = 1'd0;
  //#(5*2)
  //RX_IN = 1'd0;
  //#(5*2)
  RX_IN = 1'd1;
  #(8*5)
  RX_IN = 1'd0;
  #(8*5)
  RX_IN = 1'd1;
  #(8*5)
  RX_IN = 1'd0;
  #(8*5)
  RX_IN = 1'd1;
  #(8*5)
  RX_IN = 1'd0;
  #(8*5)
  RX_IN = 1'd1;
  #(8*5)
  RX_IN = 1'd0;
  #(8*5)
  RX_IN = 1'd0;
  #(8*5)
  RX_IN =1'd0;
  
  #100
  $finish;
  
end

task RESET;
  begin
    RST = 1'd1;
    #2.5
    RST = 1'd0;
    #2.5
    RST = 1'd1;
    #2.5;
  end
endtask

endmodule