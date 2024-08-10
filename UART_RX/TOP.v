
module TOP(
  input CLK,RST,
  input RX_IN,
  input PAR_EN,PAR_TYP,
  input [4:0] prescale,
  output wire [7:0] P_DATA,
  output wire DATA_VALID
);

wire [2:0] edge_cnt;
wire [3:0] bit_cnt;
wire enable,dat_samp_en;
wire sampled_bit,deser_en;
wire stp_err,stp_chk_en,strt_glitch,strt_chk_en,par_err,par_chk_en;
wire check;

data_sampling INST1(
.CLK(CLK),
.RST(RST),
.RX_IN(RX_IN),
.prescale(prescale),
.dat_samp_en(dat_samp_en),
.edge_count(edge_cnt),
.sampled_bit(sampled_bit)
);

parity_check INST2(
.par_chk_en(par_chk_en),
.PAR_TYP(PAR_TYP),
.P_DATA(P_DATA),
.sampled_bit(sampled_bit),
.par_err(par_err)
);

edge_bit_counter INST3(
.CLK(CLK),
.RST(RST),
.check(check),
.enable(enable),
.edge_count(edge_cnt),
.bit_count(bit_cnt)
);

FSM INST4(
.CLK(CLK),
.RST(RST),
.RX_IN(RX_IN),
.PAR_EN(PAR_EN),
.edge_cnt(edge_cnt),
.bit_cnt(bit_cnt),
.stp_err(stp_err),
.par_err(par_err),
.strt_glitch(strt_glitch),
.dat_samp_en(dat_samp_en),
.enable(enable),
.deser_en(deser_en),
.par_chk_en(par_chk_en),
.strt_chk_en(strt_chk_en),
.stop_chk_en(stp_chk_en),
.check(check),
.data_valid(DATA_VALID)
);

deserializer INST5(
.CLK(CLK),
.RST(RST),
.deser_en(deser_en),
.sampled_bit(sampled_bit),
.P_DATA(P_DATA)
);

stop_check INST6(
.stp_chk_en(stp_chk_en),
.sampled_bit(sampled_bit),
.stp_err(stp_err)
);

start_check INST7(
.strt_chk_en(strt_chk_en),
.sampled_bit(sampled_bit),
.strt_glitch(strt_glitch)
);

endmodule