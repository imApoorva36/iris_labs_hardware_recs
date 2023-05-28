`timescale 1ns / 1ps
module d_ff_tb;
  reg clk;
  reg reset;
  reg d;
  wire q;

  d_flip_flop_async dff (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
  );

  initial begin
    clk = 0;
    reset = 0;
    d = 0;    

    #10 forever begin
      #15 reset = ~reset;
      #10 clk = ~clk;
      #8 d = $urandom_range(0, 1);
    end    
  end

endmodule
