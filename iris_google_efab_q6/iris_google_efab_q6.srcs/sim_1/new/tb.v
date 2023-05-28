`timescale 1ns / 1ns
`default_nettype none

module ZeroDetector_TB;
  reg clk;
  reg reset;
  reg sample;
  wire detection;

  ZeroDetector dut (
    .clk(clk),
    .reset(reset),
    .sample(sample),
    .detection(detection)
  );
  
  always begin
    #5 clk = ~clk;
  end

  initial begin
    clk = 1;
    reset = 1;
    sample = 1;
    
    #10 reset=0;

    //Sample case 1
    
        sample = 0;
    #10 sample = 0;
    #10 sample = 1;
    
    #10 reset=1;

    //Sample case 2
    #10 reset=0;
    
        sample = 0;
    #10 sample = 1;
    #10 sample = 1;
    #10 sample = 0;
    #10 sample = 0;
    #10 sample = 0;
    
    #10 reset=1;

    //Sample case 3
    #10 reset=0;
    
        sample = 1;
    #10 sample = 0;
    #10 sample = 0;
    #10 sample = 1;

#10    $finish;
  end

endmodule

