module max_pooling(
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
  
  input start_intermediate,
  output reg finish,
  
  input clk,
  input reset,
  
  output [3:0] state_test,
  output [7:0] test_a,
  output [7:0] test_b,
  output [7:0] test_c
);
reg [5:0] cnt;
reg [3:0] state;
assign state_test = state;
reg [31:0] address_offset;
reg [31:0] address_offset_2;
reg [15:0] data_a_reg;
reg [15:0] data_b_reg;
reg [15:0] data_c_reg;

wire [7:0] data_c_0;

assign data_c_0 = data_c_reg[7:0];


assign test_a = data_a_reg[15:0];
assign test_b = data_b_reg[15:0];
assign test_c = data_c_reg;

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
        cnt<=0;
        address_offset <= 0;
        address_offset_2 <=0;   
        finish <= 0;
        state <= 0;
    end
    else begin
        case(state)
        4'd0: begin
            if ( start_intermediate )
                state <= 4'd1;
        end
        4'd1: begin //try read A
            if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h4002_0000 + address_offset;
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b001;  //half_word
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 1;
                
                state <= 4'd11;                
            end
        end
        4'd2: begin // read the data A
            if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                data_a_reg <= AHB_INTERFACE_0_hrdata;
                AHB_INTERFACE_0_sel <= 0;
                AHB_INTERFACE_0_hprot <= 0;
                AHB_INTERFACE_0_hready_in <= 1;
                state <= 4'd3;
            end
        end
        4'd3: begin //try read B
            if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h4002_0052 + address_offset;
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b001;  //half_word
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 1;
                
                state <= 4'd12;                
            end
        end
        4'd4: begin // read the data B
                if ( AHB_INTERFACE_0_hready_out == 1 ) begin
                data_b_reg <= AHB_INTERFACE_0_hrdata;
                AHB_INTERFACE_0_sel <= 0;
                AHB_INTERFACE_0_hprot <= 0;
                AHB_INTERFACE_0_hready_in <= 1;
                
                state <= 4'd5;
            end
        end

   4'd5: begin
   if(data_a_reg[7:0]>data_b_reg[7:0]) begin
      data_c_reg[7:0]<=data_a_reg[7:0];
      end
   else begin
      data_c_reg[7:0]<=data_b_reg[7:0];
      end
   if(data_a_reg[15:8]>data_b_reg[15:8]) begin
      data_c_reg[15:8]<=data_a_reg[15:8];
      end
   else begin
      data_c_reg[15:8]<=data_b_reg[15:8];
      end
   state<= 4'd6;
   
   end

   4'd6: begin
   if(data_c_reg[7:0]<data_c_reg[15:8]) begin
      data_c_reg[7:0]<=data_c_reg[15:8];
      end
   state<= 4'd7;
   
   end




        4'd7: begin // write finish code
            if ( AHB_INTERFACE_0_hready_out == 1 && AHB_INTERFACE_0_hresp == 0) begin
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h4002_0000 + address_offset_2;
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b000; //byte
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 9;
                AHB_INTERFACE_0_hwdata <= data_c_0;
                AHB_INTERFACE_0_hwrite <= 1;
                state <= 4'd8;
            end
        end

        4'd8: begin
            AHB_INTERFACE_0_htrans <= 0;
            AHB_INTERFACE_0_hready_in <= 0;
            state <= 4'd9;
        end
        4'd9: begin
            if ( AHB_INTERFACE_0_hready_out == 0 && AHB_INTERFACE_0_hresp == 0) begin
                AHB_INTERFACE_0_sel <= 0;
                AHB_INTERFACE_0_hprot <= 0;
                AHB_INTERFACE_0_hwdata <= 0;
                AHB_INTERFACE_0_hwrite <= 0;
                AHB_INTERFACE_0_hready_in <= 1;
                
                if ( address_offset == 32'd6640 ) begin // = 6724-84
                    state <= 4'd10;
                end
                else if(cnt!= 40) begin
                    address_offset<=address_offset+2;
                  cnt <= cnt+1;
                  state<=4'd1;
                  address_offset_2 <= address_offset_2+1;
               end
               else begin
                  address_offset<= address_offset+84;
                 cnt<=0;
                 state<= 4'd1;
                 address_offset_2<= address_offset_2 + 1;   
               end
             end
        end
           
        4'd10: begin
            finish <= 1;
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
        4'd11: begin
            AHB_INTERFACE_0_hready_in <= 0;
            AHB_INTERFACE_0_htrans <= 0;
            state <= 4'd2;    
        end
        4'd12: begin
            AHB_INTERFACE_0_hready_in <= 0;
            AHB_INTERFACE_0_htrans <= 0;
            state <= 4'd4;
        end
        
        endcase
    end
end 


endmodule