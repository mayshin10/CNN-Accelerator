//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Thu Apr 18 21:10:19 2019
//Host        : changsu-desktop running 64-bit Ubuntu 16.04.6 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module top
   (
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    UART0_rxd,
    UART0_txd,
    led,
    push_n);


  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input UART0_rxd;
  output UART0_txd;
  output [7:0] led;
  input [2:0] push_n;
  
  wire [2:0] push;
  assign push = ~push_n;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire UART0_rxd;
  wire UART0_txd;
  
  wire clk;
  wire [0:0]reset;
  
  wire [31:0]AHB_INTERFACE_0_hrdata;
  wire AHB_INTERFACE_0_hready_out;
  wire AHB_INTERFACE_0_hresp;

  wire [31:0]AHB_INTERFACE_0_haddr_p;
  wire [2:0]AHB_INTERFACE_0_hburst_p;
  wire [3:0]AHB_INTERFACE_0_hprot_p;
  wire AHB_INTERFACE_0_hready_in_p;
  wire [2:0]AHB_INTERFACE_0_hsize_p;
  wire [1:0]AHB_INTERFACE_0_htrans_p;
  wire [31:0]AHB_INTERFACE_0_hwdata_p;
  wire AHB_INTERFACE_0_hwrite_p;
  wire AHB_INTERFACE_0_sel_p;
  
  wire [31:0]AHB_INTERFACE_0_haddr_sf;
  wire [2:0]AHB_INTERFACE_0_hburst_sf;
  wire [3:0]AHB_INTERFACE_0_hprot_sf;
  wire AHB_INTERFACE_0_hready_in_sf;
  wire [2:0]AHB_INTERFACE_0_hsize_sf;
  wire [1:0]AHB_INTERFACE_0_htrans_sf;
  wire [31:0]AHB_INTERFACE_0_hwdata_sf;
  wire AHB_INTERFACE_0_hwrite_sf;
  wire AHB_INTERFACE_0_sel_sf;
  
  wire [31:0]AHB_INTERFACE_0_haddr;
  wire [2:0]AHB_INTERFACE_0_hburst;
  wire [3:0]AHB_INTERFACE_0_hprot;
  wire AHB_INTERFACE_0_hready_in;
  wire [2:0]AHB_INTERFACE_0_hsize;
  wire [1:0]AHB_INTERFACE_0_htrans;
  wire [31:0]AHB_INTERFACE_0_hwdata;
  wire AHB_INTERFACE_0_hwrite;
  wire AHB_INTERFACE_0_sel;
  
  assign AHB_INTERFACE_0_haddr = AHB_INTERFACE_0_haddr_p | AHB_INTERFACE_0_haddr_sf;
  assign AHB_INTERFACE_0_hburst = AHB_INTERFACE_0_hburst_p | AHB_INTERFACE_0_hburst_sf;
  assign AHB_INTERFACE_0_hprot = AHB_INTERFACE_0_hprot_p | AHB_INTERFACE_0_hprot_sf;
  assign AHB_INTERFACE_0_hready_in = AHB_INTERFACE_0_hready_in_p | AHB_INTERFACE_0_hready_in_sf;
  assign AHB_INTERFACE_0_hsize = AHB_INTERFACE_0_hsize_p | AHB_INTERFACE_0_hsize_sf;
  assign AHB_INTERFACE_0_htrans = AHB_INTERFACE_0_htrans_p | AHB_INTERFACE_0_htrans_sf;
  assign AHB_INTERFACE_0_hwdata = AHB_INTERFACE_0_hwdata_p | AHB_INTERFACE_0_hwdata_sf;
  assign AHB_INTERFACE_0_hwrite = AHB_INTERFACE_0_hwrite_p | AHB_INTERFACE_0_hwrite_sf;
  assign AHB_INTERFACE_0_sel = AHB_INTERFACE_0_sel_p | AHB_INTERFACE_0_sel_sf;
  
  wire [3:0] state_test;
  wire start;
  wire finish;
  
  assign led[7] = start;
  assign led[6] = finish;

  vector_add p_1 (
        .AHB_INTERFACE_0_haddr(AHB_INTERFACE_0_haddr_p),
        .AHB_INTERFACE_0_hburst(AHB_INTERFACE_0_hburst_p),
        .AHB_INTERFACE_0_hprot(AHB_INTERFACE_0_hprot_p),
        .AHB_INTERFACE_0_hrdata(AHB_INTERFACE_0_hrdata),//
        .AHB_INTERFACE_0_hready_in(AHB_INTERFACE_0_hready_in_p),
        .AHB_INTERFACE_0_hready_out(AHB_INTERFACE_0_hready_out),//
        .AHB_INTERFACE_0_hresp(AHB_INTERFACE_0_hresp),//
        .AHB_INTERFACE_0_hsize(AHB_INTERFACE_0_hsize_p),
        .AHB_INTERFACE_0_htrans(AHB_INTERFACE_0_htrans_p),
        .AHB_INTERFACE_0_hwdata(AHB_INTERFACE_0_hwdata_p),
        .AHB_INTERFACE_0_hwrite(AHB_INTERFACE_0_hwrite_p),
        .AHB_INTERFACE_0_sel(AHB_INTERFACE_0_sel_p),
        .start(start),
        .finish(finish),
        .clk(clk),
        .reset(reset),
        .state_test(state_test)
    );

    start_end sf_1 (
        .AHB_INTERFACE_0_haddr(AHB_INTERFACE_0_haddr_sf),
        .AHB_INTERFACE_0_hburst(AHB_INTERFACE_0_hburst_sf),
        .AHB_INTERFACE_0_hprot(AHB_INTERFACE_0_hprot_sf),
        .AHB_INTERFACE_0_hrdata(AHB_INTERFACE_0_hrdata),//
        .AHB_INTERFACE_0_hready_in(AHB_INTERFACE_0_hready_in_sf),
        .AHB_INTERFACE_0_hready_out(AHB_INTERFACE_0_hready_out),//
        .AHB_INTERFACE_0_hresp(AHB_INTERFACE_0_hresp),//
        .AHB_INTERFACE_0_hsize(AHB_INTERFACE_0_hsize_sf),
        .AHB_INTERFACE_0_htrans(AHB_INTERFACE_0_htrans_sf),
        .AHB_INTERFACE_0_hwdata(AHB_INTERFACE_0_hwdata_sf),
        .AHB_INTERFACE_0_hwrite(AHB_INTERFACE_0_hwrite_sf),
        .AHB_INTERFACE_0_sel(AHB_INTERFACE_0_sel_sf),
        .start(start),
        .finish(finish),
        .clk(clk),
        .reset(reset)
    );

  design_1 design_1_i
       (.AHB_INTERFACE_0_haddr(AHB_INTERFACE_0_haddr),
        .AHB_INTERFACE_0_hburst(AHB_INTERFACE_0_hburst),
        .AHB_INTERFACE_0_hprot(AHB_INTERFACE_0_hprot),
        .AHB_INTERFACE_0_hrdata(AHB_INTERFACE_0_hrdata),
        .AHB_INTERFACE_0_hready_in(AHB_INTERFACE_0_hready_in),
        .AHB_INTERFACE_0_hready_out(AHB_INTERFACE_0_hready_out),
        .AHB_INTERFACE_0_hresp(AHB_INTERFACE_0_hresp),
        .AHB_INTERFACE_0_hsize(AHB_INTERFACE_0_hsize),
        .AHB_INTERFACE_0_htrans(AHB_INTERFACE_0_htrans),
        .AHB_INTERFACE_0_hwdata(AHB_INTERFACE_0_hwdata),
        .AHB_INTERFACE_0_hwrite(AHB_INTERFACE_0_hwrite),
        .AHB_INTERFACE_0_sel(AHB_INTERFACE_0_sel),
        .DDR_0_addr(DDR_addr),
        .DDR_0_ba(DDR_ba),
        .DDR_0_cas_n(DDR_cas_n),
        .DDR_0_ck_n(DDR_ck_n),
        .DDR_0_ck_p(DDR_ck_p),
        .DDR_0_cke(DDR_cke),
        .DDR_0_cs_n(DDR_cs_n),
        .DDR_0_dm(DDR_dm),
        .DDR_0_dq(DDR_dq),
        .DDR_0_dqs_n(DDR_dqs_n),
        .DDR_0_dqs_p(DDR_dqs_p),
        .DDR_0_odt(DDR_odt),
        .DDR_0_ras_n(DDR_ras_n),
        .DDR_0_reset_n(DDR_reset_n),
        .DDR_0_we_n(DDR_we_n),
        .FIXED_IO_0_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_0_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_0_mio(FIXED_IO_mio),
        .FIXED_IO_0_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_0_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_0_ps_srstb(FIXED_IO_ps_srstb),
        .UART0_rxd(UART0_rxd),
        .UART0_txd(UART0_txd),
        .clk(clk),
        .reset(reset));
endmodule
