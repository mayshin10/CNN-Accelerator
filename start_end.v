module start_end(
  output reg [31:0]AHB_INTERFACE_0_haddr,
  output reg [2:0]AHB_INTERFACE_0_hburst,
  output reg [3:0]AHB_INTERFACE_0_hprot,
  input [31:0]AHB_INTERFACE_0_hrdata,
  output reg AHB_INTERFACE_0_hready_in,
  input AHB_INTERFACE_0_hready_out,
  input AHB_INTERFACE_0_hresp,
  output reg [2:0]AHB_INTERFACE_0_hsize,
  output reg [1:0]AHB_INTERFACE_0_htrans,
  output reg [31:0]AHB_INTERFACE_0_hwdata,
  output reg AHB_INTERFACE_0_hwrite,
  output reg AHB_INTERFACE_0_sel,
  output reg start,
  input finish,  
  input clk,
  input reset
);

reg [3:0] state;
wire [31:0] start_code;
assign start_code = 32'h01020304;
wire [31:0] finish_code;
assign finish_code = 32'h04030201;
reg [31:0] read_data_reg;
always @(posedge clk) begin
    if ( !reset ) begin
        AHB_INTERFACE_0_haddr <= 0;
        AHB_INTERFACE_0_hburst <= 0;
        AHB_INTERFACE_0_hprot <= 0;
        AHB_INTERFACE_0_hready_in <= 0;
        AHB_INTERFACE_0_hsize <= 0;
        AHB_INTERFACE_0_htrans <= 0;
        AHB_INTERFACE_0_hwdata <= 0;
        AHB_INTERFACE_0_hwrite <= 0;
        AHB_INTERFACE_0_sel <= 0;        
        start <= 0;
        state <= 0;
    end
    else begin
    case(state)
        4'd0: begin // try to read
            if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h5000_0000; // start code position
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b010;
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 1;
                
                state <= 4'd1;                
            end
        end
        4'd1: begin // read the data
            if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                read_data_reg <= AHB_INTERFACE_0_hrdata;
                AHB_INTERFACE_0_sel <= 0;
                AHB_INTERFACE_0_hprot <= 0;
                AHB_INTERFACE_0_hready_in <= 1;
                
                state <= 4'd2;
            end
            else begin
                AHB_INTERFACE_0_hready_in <= 0;
            end
            AHB_INTERFACE_0_htrans <= 0;
        end
        4'd2: begin // compare the data to start code
            if ( read_data_reg == start_code ) begin
                start <= 1;
                state <= 4'd3;
            end
            else begin
                state <= 4'd0;
            end
        end
        4'd3: begin // wait for finish signal from processing module
            if ( finish == 1 ) begin
                state <= 4'd4;
            end
            AHB_INTERFACE_0_haddr <= 0;
            AHB_INTERFACE_0_hburst <= 0;
            AHB_INTERFACE_0_hprot <= 0;
            AHB_INTERFACE_0_hready_in <= 0;
            AHB_INTERFACE_0_hsize <= 0;
            AHB_INTERFACE_0_htrans <= 0;
            AHB_INTERFACE_0_hwdata <= 0;
            AHB_INTERFACE_0_hwrite <= 0;
            AHB_INTERFACE_0_sel <= 0;
        end
        4'd4: begin // write finish code
            if ( AHB_INTERFACE_0_hready_out == 1 && AHB_INTERFACE_0_hresp == 0) begin
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h5000_0004;
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b010; //Byte
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 9;
                AHB_INTERFACE_0_hwdata <= finish_code;
                AHB_INTERFACE_0_hwrite <= 1;
                state <= 4'd5;
            end
        end
        4'd5: begin
            AHB_INTERFACE_0_htrans <= 0;
            AHB_INTERFACE_0_hready_in <= 0;
            state <= 4'd6;
        end
        4'd6: begin
            if ( AHB_INTERFACE_0_hready_out == 0 && AHB_INTERFACE_0_hresp == 0) begin
                AHB_INTERFACE_0_sel <= 0;
                AHB_INTERFACE_0_hprot <= 0;
                AHB_INTERFACE_0_hwdata <= 0;
                AHB_INTERFACE_0_hwrite <= 0;
                AHB_INTERFACE_0_hready_in <= 1;
                state <= 4'd7;
            end
        end
        default: begin
        AHB_INTERFACE_0_haddr <= 0;
        AHB_INTERFACE_0_hburst <= 0;
        AHB_INTERFACE_0_hprot <= 0;
        AHB_INTERFACE_0_hready_in <= 0;
        AHB_INTERFACE_0_hsize <= 0;
        AHB_INTERFACE_0_htrans <= 0;
        AHB_INTERFACE_0_hwdata <= 0;
        AHB_INTERFACE_0_hwrite <= 0;
        AHB_INTERFACE_0_sel <= 0;
        end
        
    endcase
    end
end
endmodule