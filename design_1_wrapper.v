//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Mon Nov 18 14:12:13 2019
//Host        : A133-05 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (AHB_INTERFACE_0_haddr,
    AHB_INTERFACE_0_hburst,
    AHB_INTERFACE_0_hprot,
    AHB_INTERFACE_0_hrdata,
    AHB_INTERFACE_0_hready_in,
    AHB_INTERFACE_0_hready_out,
    AHB_INTERFACE_0_hresp,
    AHB_INTERFACE_0_hsize,
    AHB_INTERFACE_0_htrans,
    AHB_INTERFACE_0_hwdata,
    AHB_INTERFACE_0_hwrite,
    AHB_INTERFACE_0_sel,
    DDR_0_addr,
    DDR_0_ba,
    DDR_0_cas_n,
    DDR_0_ck_n,
    DDR_0_ck_p,
    DDR_0_cke,
    DDR_0_cs_n,
    DDR_0_dm,
    DDR_0_dq,
    DDR_0_dqs_n,
    DDR_0_dqs_p,
    DDR_0_odt,
    DDR_0_ras_n,
    DDR_0_reset_n,
    DDR_0_we_n,
    FIXED_IO_0_ddr_vrn,
    FIXED_IO_0_ddr_vrp,
    FIXED_IO_0_mio,
    FIXED_IO_0_ps_clk,
    FIXED_IO_0_ps_porb,
    FIXED_IO_0_ps_srstb,
    UART0_rxd,
    UART0_txd,
    clk,
    reset);
  input [31:0]AHB_INTERFACE_0_haddr;
  input [2:0]AHB_INTERFACE_0_hburst;
  input [3:0]AHB_INTERFACE_0_hprot;
  output [31:0]AHB_INTERFACE_0_hrdata;
  input AHB_INTERFACE_0_hready_in;
  output AHB_INTERFACE_0_hready_out;
  output AHB_INTERFACE_0_hresp;
  input [2:0]AHB_INTERFACE_0_hsize;
  input [1:0]AHB_INTERFACE_0_htrans;
  input [31:0]AHB_INTERFACE_0_hwdata;
  input AHB_INTERFACE_0_hwrite;
  input AHB_INTERFACE_0_sel;
  inout [14:0]DDR_0_addr;
  inout [2:0]DDR_0_ba;
  inout DDR_0_cas_n;
  inout DDR_0_ck_n;
  inout DDR_0_ck_p;
  inout DDR_0_cke;
  inout DDR_0_cs_n;
  inout [3:0]DDR_0_dm;
  inout [31:0]DDR_0_dq;
  inout [3:0]DDR_0_dqs_n;
  inout [3:0]DDR_0_dqs_p;
  inout DDR_0_odt;
  inout DDR_0_ras_n;
  inout DDR_0_reset_n;
  inout DDR_0_we_n;
  inout FIXED_IO_0_ddr_vrn;
  inout FIXED_IO_0_ddr_vrp;
  inout [53:0]FIXED_IO_0_mio;
  inout FIXED_IO_0_ps_clk;
  inout FIXED_IO_0_ps_porb;
  inout FIXED_IO_0_ps_srstb;
  input UART0_rxd;
  output UART0_txd;
  output clk;
  output [0:0]reset;

  wire [31:0]AHB_INTERFACE_0_haddr;
  wire [2:0]AHB_INTERFACE_0_hburst;
  wire [3:0]AHB_INTERFACE_0_hprot;
  wire [31:0]AHB_INTERFACE_0_hrdata;
  wire AHB_INTERFACE_0_hready_in;
  wire AHB_INTERFACE_0_hready_out;
  wire AHB_INTERFACE_0_hresp;
  wire [2:0]AHB_INTERFACE_0_hsize;
  wire [1:0]AHB_INTERFACE_0_htrans;
  wire [31:0]AHB_INTERFACE_0_hwdata;
  wire AHB_INTERFACE_0_hwrite;
  wire AHB_INTERFACE_0_sel;
  wire [14:0]DDR_0_addr;
  wire [2:0]DDR_0_ba;
  wire DDR_0_cas_n;
  wire DDR_0_ck_n;
  wire DDR_0_ck_p;
  wire DDR_0_cke;
  wire DDR_0_cs_n;
  wire [3:0]DDR_0_dm;
  wire [31:0]DDR_0_dq;
  wire [3:0]DDR_0_dqs_n;
  wire [3:0]DDR_0_dqs_p;
  wire DDR_0_odt;
  wire DDR_0_ras_n;
  wire DDR_0_reset_n;
  wire DDR_0_we_n;
  wire FIXED_IO_0_ddr_vrn;
  wire FIXED_IO_0_ddr_vrp;
  wire [53:0]FIXED_IO_0_mio;
  wire FIXED_IO_0_ps_clk;
  wire FIXED_IO_0_ps_porb;
  wire FIXED_IO_0_ps_srstb;
  wire UART0_rxd;
  wire UART0_txd;
  wire clk;
  wire [0:0]reset;

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
        .DDR_0_addr(DDR_0_addr),
        .DDR_0_ba(DDR_0_ba),
        .DDR_0_cas_n(DDR_0_cas_n),
        .DDR_0_ck_n(DDR_0_ck_n),
        .DDR_0_ck_p(DDR_0_ck_p),
        .DDR_0_cke(DDR_0_cke),
        .DDR_0_cs_n(DDR_0_cs_n),
        .DDR_0_dm(DDR_0_dm),
        .DDR_0_dq(DDR_0_dq),
        .DDR_0_dqs_n(DDR_0_dqs_n),
        .DDR_0_dqs_p(DDR_0_dqs_p),
        .DDR_0_odt(DDR_0_odt),
        .DDR_0_ras_n(DDR_0_ras_n),
        .DDR_0_reset_n(DDR_0_reset_n),
        .DDR_0_we_n(DDR_0_we_n),
        .FIXED_IO_0_ddr_vrn(FIXED_IO_0_ddr_vrn),
        .FIXED_IO_0_ddr_vrp(FIXED_IO_0_ddr_vrp),
        .FIXED_IO_0_mio(FIXED_IO_0_mio),
        .FIXED_IO_0_ps_clk(FIXED_IO_0_ps_clk),
        .FIXED_IO_0_ps_porb(FIXED_IO_0_ps_porb),
        .FIXED_IO_0_ps_srstb(FIXED_IO_0_ps_srstb),
        .UART0_rxd(UART0_rxd),
        .UART0_txd(UART0_txd),
        .clk(clk),
        .reset(reset));
endmodule
