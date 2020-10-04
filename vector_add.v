module vector_add
(
output reg [31:0]AHB_INTERFACE_0_haddr,     //indicate read/write address
output reg [2:0]AHB_INTERFACE_0_hburst,     
output reg [3:0]AHB_INTERFACE_0_hprot,      
input [31:0]AHB_INTERFACE_0_hrdata,         //datastream you read
output reg AHB_INTERFACE_0_hready_in,       //indicate whether the slave are ready
input AHB_INTERFACE_0_hready_out,           //indicate whether the master are ready
input AHB_INTERFACE_0_hresp,                
output reg [2:0]AHB_INTERFACE_0_hsize,      //we use 010 value that indicate 4byte word size
output reg [1:0]AHB_INTERFACE_0_htrans,     
output reg [31:0]AHB_INTERFACE_0_hwdata,    //datastream you write
output reg AHB_INTERFACE_0_hwrite,          
output reg AHB_INTERFACE_0_sel,
input start,                                //start when this value go to 1 from 0.
output reg finish,                          //put finish to 1 when this process is over
input clk,  
input reset,
output [6:0] state_test                      //to check the state number when we run simulation
);

reg [6:0] state;                             // 7bit state. maximum state is 127
assign state_test = state;                   
reg [31:0] address_offset;                   // it is set to read data phase
reg [31:0] address_offset_max;               // it is set to write data phase
reg [1:0] max_cnt;                           // count for max_pooling
reg col;                                     // check whether you read first column or not
reg row;                                     // check whether you read odd row or not
reg [7:0] max1;                              // to store max pooling result in first order of 4 byte in write data.
reg [7:0] max2;                              // to store max pooling result in second order of 4 byte in write data.
reg [7:0] max3;                              // to store max pooling result in third order of 4 byte in write data.
reg [7:0] max4;                              // to store max pooling result in last order of 4 byte in write data.
reg [7:0] temp;                              // to store max pooling result in out of order of 4 byte in write data, temporarily

reg [671:0] databus_1;                       //the first databus
reg [671:0] databus_2;                       //the second databus
reg [671:0] databus_3;                       //the third databus

reg signed [7:0] w1;                         // 16 of weigh value 
reg signed [7:0] w2;
reg signed [7:0] w3;
reg signed [7:0] w4;
reg signed [7:0] w5;
reg signed [7:0] w6;
reg signed [7:0] w7;
reg signed [7:0] w8;
reg signed [7:0] w9;
reg signed [7:0] im1;                         // 24 of image value
reg signed [7:0] im2;
reg signed [7:0] im3;
reg signed [7:0] im4;
reg signed [7:0] im5;
reg signed [7:0] im6;
reg signed [7:0] im7;
reg signed [7:0] im8;
reg signed [7:0] im9;
reg signed [7:0] im10;
reg signed [7:0] im11;
reg signed [7:0] im12;
reg signed [7:0] im13;
reg signed [7:0] im14;
reg signed [7:0] im15;
reg signed [7:0] im16;
reg signed [7:0] im17;
reg signed [7:0] im18;
reg signed [7:0] im19;
reg signed [7:0] im20;
reg signed [7:0] im21;
reg signed [7:0] im22;
reg signed [7:0] im23;
reg signed [7:0] im24;

wire signed [7:0] temp1;                //8 convolution value
wire signed [7:0] temp2;
wire signed [7:0] temp3;
wire signed [7:0] temp4;
wire [7:0] temp5;
wire [7:0] temp6;
wire [7:0] temp7;
wire [7:0] temp8;

// calculate convolution in wire.

assign temp1 =((im1*w1 + im2*w2 + im3*w3 + im5*w4 + im6*w5 + im7*w6 + im9*w7 + im10*w8 + im11*w9) >0 ?  (((im1*w1 + im2*w2 + im3*w3 + im5*w4 + im6*w5 + im7*w6 + im9*w7 + im10*w8 + im11*w9) >> 7)&255) : 0); 
assign temp2 =((im2*w1 + im3*w2 + im4*w3 + im6*w4 + im7*w5 + im8*w6 + im10*w7 + im11*w8 + im12*w9) >0 ?  (((im2*w1 + im3*w2 + im4*w3 + im6*w4 + im7*w5 + im8*w6 + im10*w7 + im11*w8 + im12*w9) >> 7)&255) : 0); 
assign temp3 =((im5*w1 + im6*w2 + im7*w3 + im9*w4 + im10*w5 + im11*w6 + im13*w7 + im14*w8 + im15*w9) >0 ?  (((im5*w1 + im6*w2 + im7*w3 + im9*w4 + im10*w5 + im11*w6 + im13*w7 + im14*w8 + im15*w9)>> 7)&255) : 0); 
assign temp4 =((im6*w1 + im7*w2 + im8*w3 + im10*w4 + im11*w5 + im12*w6 + im14*w7 + im15*w8 + im16*w9) >0 ?  (((im6*w1 + im7*w2 + im8*w3 + im10*w4 + im11*w5 + im12*w6 + im14*w7 + im15*w8 + im16*w9) >> 7)&255) : 0);

assign temp5 =((im17*w1 + im18*w2 + im1*w3 + im19*w4 + im20*w5 + im5*w6 + im21*w7 + im22*w8 + im9*w9) >0 ?  (((im17*w1 + im18*w2 + im1*w3 + im19*w4 + im20*w5 + im5*w6 + im21*w7 + im22*w8 + im9*w9) >> 7)&255) : 0); 
assign temp6 =((im18*w1 + im1*w2 + im2*w3 + im20*w4 + im5*w5 + im6*w6 + im22*w7 + im9*w8 + im10*w9) >0 ?  (((im18*w1 + im1*w2 + im2*w3 + im20*w4 + im5*w5 + im6*w6 + im22*w7 + im9*w8 + im10*w9) >> 7)&255) : 0); 
assign temp7 =((im19*w1 + im20*w2 + im5*w3 + im21*w4 + im22*w5 + im9*w6 + im23*w7 + im24*w8 + im13*w9) >0 ?  (((im19*w1 + im20*w2 + im5*w3 + im21*w4 + im22*w5 + im9*w6 + im23*w7 + im24*w8 + im13*w9) >> 7)&255) : 0); 
assign temp8 =((im20*w1 + im5*w2 + im6*w3 + im22*w4 + im9*w5 + im10*w6 + im24*w7 + im13*w8 + im14*w9) >0 ?  (((im20*w1 + im5*w2 + im6*w3 + im22*w4 + im9*w5 + im10*w6 + im24*w7 + im13*w8 + im14*w9) >> 7)&255) : 0);


always @(posedge clk) begin

if ( !reset ) begin
//initialization all registor
AHB_INTERFACE_0_haddr <= 0;
AHB_INTERFACE_0_hburst <= 0;
AHB_INTERFACE_0_hprot <= 0;
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_hsize <= 0;
AHB_INTERFACE_0_htrans <= 0;
AHB_INTERFACE_0_hwdata <= 0;
AHB_INTERFACE_0_hwrite <= 0;
AHB_INTERFACE_0_sel <= 0;
address_offset <= 0;
address_offset_max <= 0;
finish <= 0;
state <= 0;
max_cnt <= 0;
col<= 0;
row <=0;
max1<= 0;
max2<= 0;
max3<= 0;
max4<= 0;
temp<= 0;
databus_1 <=0;
databus_2 <=0;
databus_3 <=0;
w1 <= 0;
w2 <= 0;
w3 <= 0;
w4 <= 0;
w5 <= 0;
w6 <= 0;
w7 <= 0;
w8 <= 0;
w9 <= 0;
im1 <= 0;
im2 <= 0;
im3 <= 0;
im4 <= 0;
im5 <= 0;
im6 <= 0;
im7 <= 0;
im8 <= 0;
im9 <= 0;
im10 <= 0;
im11 <= 0;
im12 <= 0;
im13 <= 0;
im14 <= 0;
im15 <= 0;
im16 <= 0;
im17 <= 0;
im18 <= 0;
im19 <= 0;
im20 <= 0;
im21 <= 0;
im22 <= 0;
im23 <= 0;
im24 <= 0;
end
else begin
case(state)
//loop1
7'd0: begin
if ( start )
    state <= 7'd1;
end

7'd1: begin //try to read first 4 weight value
if ( (AHB_INTERFACE_0_hready_out == 1) ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4001_0000;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;
   
    state <= 7'd2;                

end
end

7'd2: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;
state <= 7'd3;    
end

7'd3: begin //write weight value in my registor
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    w1 <= AHB_INTERFACE_0_hrdata[7:0];
    w2 <= AHB_INTERFACE_0_hrdata[15:8];
    w3 <= AHB_INTERFACE_0_hrdata[23:16];
    w4 <= AHB_INTERFACE_0_hrdata[31:24];
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    
    state <= 7'd4;

end
end

7'd4: begin //try to read second 4 weight value
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4001_0000 + 4;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;    

    state <= 7'd5;                

end
end

7'd5: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;
state <= 7'd6;    
end

7'd6: begin //write weight value in my registor
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    w5 <= AHB_INTERFACE_0_hrdata[7:0];
    w6 <= AHB_INTERFACE_0_hrdata[15:8];
    w7 <= AHB_INTERFACE_0_hrdata[23:16];
    w8 <= AHB_INTERFACE_0_hrdata[31:24];
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;   
    state <= 7'd7;
end
end

7'd7: begin //try to read last one weight value
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4001_0000 + 8;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;
    state <= 7'd8;                
end
end

7'd8: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;
state <= 7'd9;    
end

7'd9: begin //write weight value in my registor
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    w9 <= AHB_INTERFACE_0_hrdata[7:0];
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    state <= 7'd10;
end
end

//loop2
7'd10: begin //try to read first line of image array
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4000_0000 + address_offset;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;
    state <= 7'd11;                
end
end

7'd11: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;
state <= 7'd12;
end

7'd12: begin //store the first row of image array in my databus_1
    if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    databus_1 <= databus_1 | (AHB_INTERFACE_0_hrdata<<(address_offset*8));

    
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    
    state <= 7'd13;

end
end

7'd13: begin //try to read first line of image array
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4000_0000 + 84 + address_offset;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;
    
    
    state <= 7'd14;                

end
end

7'd14: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;


state <= 7'd15;

end
7'd15: begin //store the second row of image array in my databus_2
    if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    databus_2 <=  databus_2 | (AHB_INTERFACE_0_hrdata<<(address_offset*8));

    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    
    state <= 7'd16;
end
end

7'd16: begin//try to read first line of image array
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4000_0000 + 168 + address_offset;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;

    state <= 7'd17;                

end
end

7'd17: begin
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;


state <= 7'd18;

end
7'd18: begin //store the third row of image array in my databus_3
    if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    databus_3 <=  databus_3 | (AHB_INTERFACE_0_hrdata<<(address_offset*8));
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    
    state <= 7'd19;
end
end
//check the address_offset whether it reach last of column and have to change the row. if it reach the last of column, goto the next state.
//or not, goto state 10 and read repeat.
7'd19: begin 
if ( AHB_INTERFACE_0_hready_out == 1 && AHB_INTERFACE_0_hresp == 0) begin
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hwdata <= 0;
    AHB_INTERFACE_0_hwrite <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
        if ( address_offset !=80 ) begin
        address_offset <= address_offset + 4;
        state <= 7'd10;
    end
    else begin
        
        address_offset<=0;
        state <= 7'd20;
        
    end
end
end

//try to read new row that does not read by databus
7'd20: begin
if ( AHB_INTERFACE_0_hready_out == 1 ) begin
    AHB_INTERFACE_0_htrans <= 2'b10;
    AHB_INTERFACE_0_haddr <= 32'h4000_0000 + 252 + address_offset;
    AHB_INTERFACE_0_hburst <= 0;
    AHB_INTERFACE_0_hsize <= 3'b010;
    AHB_INTERFACE_0_hready_in <= 1;
    AHB_INTERFACE_0_sel <= 1;
    AHB_INTERFACE_0_hprot <= 1;
    state <= 7'd21;
               

end
end

//move the middle of data that have to store to calculate for convolution to im17, im18.. it is like temp registor.
7'd21: begin
    im17 <= im3;
    im18 <= im4;
    im19 <= im7;
    im20 <= im8;
    im21 <= im11;
    im22 <= im12;
    im23 <= im15;
    im24 <= im16;
AHB_INTERFACE_0_hready_in <= 0;
AHB_INTERFACE_0_htrans <= 0;
state <= 7'd22;
end


//assign image value for calculate convolution.
7'd22: begin
    if ( AHB_INTERFACE_0_hready_out == 1 ) begin
   
    im1 <= databus_1[7:0];
    im2 <= databus_1[15:8];
    im3 <= databus_1[23:16];
    im4 <= databus_1[31:24];
    im5 <= databus_2[7:0];
    im6 <= databus_2[15:8];
    im7 <= databus_2[23:16];
    im8 <= databus_2[31:24];
    im9 <= databus_3[7:0];
    im10 <= databus_3[15:8];
    im11 <= databus_3[23:16];
    im12 <= databus_3[31:24];
    im13<=(AHB_INTERFACE_0_hrdata & 255);
    im14<=((AHB_INTERFACE_0_hrdata>>8) & 255);
    im15<=((AHB_INTERFACE_0_hrdata>>16) & 255);
    im16<=((AHB_INTERFACE_0_hrdata>>24) & 255);
 
 //move databus array
    databus_1 <= {databus_2[31:0], databus_1[671:32]};//(databus_1 >>32);
    databus_2 <= {databus_3[31:0], databus_2[671:32]};//(databus_2 >>32);
    
    AHB_INTERFACE_0_sel <= 0;
    AHB_INTERFACE_0_hprot <= 0;
    AHB_INTERFACE_0_hready_in <= 1;
    state<=7'd23;
 end
end

 //move databus array. and check whether the read data reach the end of array. if reached, change the row value that make just read phase.
 //And set the col as 0, that make calculate max pooling just one.
7'd23: begin
databus_3 <= {im16, im15, im14, im13, databus_3[671:32]};//databus_3 | ({im16, im15, im14, im13} << 640); 
address_offset <= address_offset + 4;
if ((address_offset%84)==80) begin
    row <= ~row;
    col <= 0;
    end
 state <= 7'd100;
 end
 
 
 //calculate max pooling.
7'd100 : begin
if (row==1) begin
state<=7'd20;
end
else if ( max_cnt==0) begin
        if (col==0) begin
                max1 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                col<=1;
                max_cnt <= 1;
                state <= 7'd20;        
        end        
        else begin
                max2 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                max1 <= ((temp5 > temp6) ? ((temp5 > temp7) ? ((temp5 > temp8) ? temp5 : temp8) : ( (temp7 > temp8) ? temp7 : temp8)) : ((temp6 > temp7) ? ((temp6 >temp8) ? temp6 : temp8) : ((temp7 > temp8) ? temp7 : temp8 )));                                        
                max_cnt <= 2;
                state <= 7'd20;    
        end        
end
else if ( max_cnt==1) begin
            if (col==0) begin
                max2 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                col<=1;
                max_cnt <= 2;
                state <= 7'd20;   

            end

            else begin
                 max3 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                 max2 <= ((temp5 > temp6) ? ((temp5 > temp7) ? ((temp5 > temp8) ? temp5 : temp8) : ( (temp7 > temp8) ? temp7 : temp8)) : ((temp6 > temp7) ? ((temp6 >temp8) ? temp6 : temp8) : ((temp7 > temp8) ? temp7 : temp8 )));                                        
                 max_cnt <= 3;
                 state <= 7'd20;  

            end
end
else if ( max_cnt==2) begin
            if (col==0) begin
                  max3 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                  col<=1;
                  max_cnt <= 3;
                  state <= 7'd20;  
             end
             else begin
                 max4 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                 max3 <= ((temp5 > temp6) ? ((temp5 > temp7) ? ((temp5 > temp8) ? temp5 : temp8) : ( (temp7 > temp8) ? temp7 : temp8)) : ((temp6 > temp7) ? ((temp6 >temp8) ? temp6 : temp8) : ((temp7 > temp8) ? temp7 : temp8 )));                                        
                 max_cnt <= 0;
                 state <= 7'd101; 
            end   
end
else if ( max_cnt==3) begin
            if (col==0) begin
                 max4 <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                 col<=1;
                 max_cnt <= 0;
                 state <= 7'd101;  
            end
            else begin
                 temp <= ((temp1 > temp2) ? ((temp1 > temp3) ? ((temp1 > temp4) ? temp1 : temp4) : ( (temp3 > temp4) ? temp3 : temp4)) : ((temp2 > temp3) ? ((temp2 >temp4) ? temp2 : temp4) : ((temp3 > temp4) ? temp3 : temp4 )));
                 max4 <= ((temp5 > temp6) ? ((temp5 > temp7) ? ((temp5 > temp8) ? temp5 : temp8) : ( (temp7 > temp8) ? temp7 : temp8)) : ((temp6 > temp7) ? ((temp6 >temp8) ? temp6 : temp8) : ((temp7 > temp8) ? temp7 : temp8 )));                                        
                 max_cnt <= 1;
                 state <= 7'd101;
             end                        
end
end

7'd101 : begin  // write finish code
      if ( AHB_INTERFACE_0_hready_out == 1 && AHB_INTERFACE_0_hresp == 0) begin
           
                AHB_INTERFACE_0_htrans <= 2'b10;
                AHB_INTERFACE_0_haddr <= 32'h4002_0000 + address_offset_max;
                AHB_INTERFACE_0_hburst <= 0;
                AHB_INTERFACE_0_hsize <= 3'b010; //Byte
                AHB_INTERFACE_0_hready_in <= 1;
                AHB_INTERFACE_0_sel <= 1;
                AHB_INTERFACE_0_hprot <= 9;
                AHB_INTERFACE_0_hwdata <= {max4, max3, max2, max1};
                AHB_INTERFACE_0_hwrite <= 1;
                address_offset_max <= address_offset_max + 4;
                state<=7'd102;
        end
     end
     
  7'd102: begin
      AHB_INTERFACE_0_htrans <= 0;
      AHB_INTERFACE_0_hready_in <= 0;
      state <= 7'd103;
  end

//check the max_pooling offset whether we reach the end of process.
  7'd103: begin
      if ( AHB_INTERFACE_0_hready_out == 1 && AHB_INTERFACE_0_hresp == 0) begin
          AHB_INTERFACE_0_sel <= 0;
          AHB_INTERFACE_0_hprot <= 0;
          AHB_INTERFACE_0_hwdata <= 0;
          AHB_INTERFACE_0_hwrite <= 0;
          AHB_INTERFACE_0_hready_in <= 1;
          if(address_offset_max==1680) begin
                state <= 7'd66;
                end
           else begin
                 max1 <= temp;
                 temp <=0 ;
                 state <= 7'd20;
                 end
              end
    end
    
//write in finish memory
7'd66: begin
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

endcase
end
end 


endmodule
 
 
 
 
