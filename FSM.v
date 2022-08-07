`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2022 04:31:29 PM
// Design Name: 
// Module Name: FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM(clk,start,fin,done,multi_act,pushpixel);
    input clk;
    input start;
    input fin;
    input done;
    
    output reg multi_act;
    output reg pushpixel;
    
    reg [1:0] state, nstate;
    parameter idle=0, push=1, cal=2, write=3;
    
    initial begin
        state <= idle;
        end
    
    always @ (posedge clk) begin
        state <= nstate;
        end
        
    always @ (*) begin
        case (state)

            idle : begin
                pushpixel <= 1'b0;
                multi_act <= 1'b0;
                if (start)
                    nstate <= push;
                else if (fin)
                    nstate <= idle;
                else 
                    nstate <= idle;
                end

            push : begin
                pushpixel <= 1'b1;
                multi_act <= 1'b0;
                nstate <= cal;
                end
                
            cal : begin
                pushpixel <= 1'b0;
                multi_act <= 1'b1;
                nstate <= push;
                /*
                  if (done)
                      nstate <= push;//write
                  else 
                      nstate <= cal;*/
                  end
                
            write : begin
                pushpixel <= 1'b0;
                multi_act <= 1'b0;
                nstate <= push;
                end
                
            endcase
        end
        
endmodule
