`timescale 1ns / 1ps
module d_flip_flop_async(
  input wire clk,       
  input wire reset,     
  input wire d,         
  output reg q          
);

  always @(posedge clk or negedge reset) begin
    if (!reset)        //active-low reset condition check
      q <= 1'b0;       
    else
      q <= d;          
  end

endmodule
