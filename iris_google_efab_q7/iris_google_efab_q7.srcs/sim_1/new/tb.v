`timescale 1ns/1ns
`default_nettype none

module shift_add_multiplier_tb;
  reg i_clk;
  reg i_start;
  wire o_stop;
  reg [8-1:0] i_operand_A;
  reg [8-1:0] i_operand_B;
  wire [2*8-1:0] o_product;
  
  shift_add_multiplier #(8) multiplier(
    .i_clk(i_clk),
    .i_start(i_start),
    .o_stop(o_stop),
    .i_operand_A(i_operand_A),
    .i_operand_B(i_operand_B),
    .o_product(o_product)
  );
  
  always begin
    i_clk = 0;
    #5;
    i_clk = 1;
    #5;
  end
  
  initial begin
    
    i_operand_A = 8'b00101001;  
    i_operand_B = 8'b00010101;  
    i_start = 1;
    
    #200;
        i_start = 0;
    
    #1000;
    $finish;
  end
  
  always @(posedge i_clk) begin
    if (!i_start) begin
      if (o_product !== i_operand_A * i_operand_B) begin
        $display("Error: Expected product = %b, Actual product = %b", i_operand_A * i_operand_B, o_product);
        $finish;
      end
    end
  end
endmodule
