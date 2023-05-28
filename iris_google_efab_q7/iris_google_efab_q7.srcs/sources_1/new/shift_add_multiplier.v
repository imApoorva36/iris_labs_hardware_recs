`timescale 1ns/1ns
`default_nettype none

module shift_add_multiplier #(parameter N = 8)(
  input wire i_clk,
  input wire i_start,
  output reg o_stop,
  input wire [N-1:0] i_operand_A,
  input wire [N-1:0] i_operand_B,
  output reg [2*N-1:0] o_product
);

  reg [N-1:0] a;
  reg [N-1:0] b;
  reg [2*N-1:0] p;
  reg [N:0] counter;
  reg [1:0] state;
  
  always @(posedge i_clk) begin
    if (i_start) begin
      a <= i_operand_A;
      b <= i_operand_B;
      p <= 0;
      o_product<=0;
      counter <= N;
      state <= 0;
    end else begin
      case (state)
        0: begin
          if (a[0]) begin
            p<=p+b;
          end
          state<=1;
          counter<=counter-1;
          a<=a>>1;
          b<=b>>1;
        end
        
        1: begin
            if(counter>0) begin
                state<=0;
            end
            else begin
                  o_product <= p;
                  o_stop <= 1;
                  state <= 3;
            end
        end
      endcase
    end
  end
endmodule
