`timescale 1ns / 1ns
module ZeroDetector (
  input wire clk,
  input wire reset,
  input wire sample,
  output reg detection
);

  localparam [1:0] S0 = 2'b00;
  localparam [1:0] S1 = 2'b01;
  localparam [1:0] S2 = 2'b10;

  reg [1:0] state;
  reg [1:0] next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= S0;
      detection <= 1'b0;
    end
    else begin
      state <= next_state;
    end
  end

  always @* begin
    next_state = state;
        case (state)
          S0: begin
            if (sample == 1'b0)
              next_state = S1;
          end
    
          S1: begin
            if (sample == 1'b0) begin
              next_state = S2;
            end
          end
    
          S2: begin
            if (sample == 1'b0) begin
              next_state = S2;
            end
          end
          
        endcase
        
        if (state == S2) begin
          detection = 1'b1;
          end
        else
          detection = 1'b0;
  end
endmodule

