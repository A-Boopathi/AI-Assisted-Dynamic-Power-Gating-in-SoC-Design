`timescale 1ns / 1ps

module soc_top(
    input wire clk,
    input wire rst,
    input wire [1:0] alu_op_sel,
    input wire [7:0] data_in,
    output wire [7:0] alu_result
);

  // Internal registers
  reg [7:0] reg_data = 8'h05;

  // Activity Monitoring
  reg [7:0] idle_counter = 0;
  reg [31:0] total_cycles = 0;
  reg [31:0] active_cycles = 0;
  reg alu_active = 0;
  reg power_enable = 1;

  // ALU output wire
  wire [7:0] alu_out;

  // ALU Instance with power gating
  alu ALU (
    .a(reg_data),
    .b(data_in),
    .op(alu_op_sel),
    .enable(power_enable),
    .result(alu_out)
  );

  // Output assignment
  assign alu_result = (power_enable) ? alu_out : 8'b0;

  // Activity monitoring logic
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      idle_counter <= 0;
      total_cycles <= 0;
      active_cycles <= 0;
      alu_active <= 0;
    end else begin
      total_cycles <= total_cycles + 1;

      // Determine ALU activity
      alu_active <= (alu_op_sel != 2'b00);

      if (alu_active) begin
        active_cycles <= active_cycles + 1;
        idle_counter <= 0;
      end else begin
        idle_counter <= idle_counter + 1;
      end
    end
  end

  // AI Decision Tree Logic (based on trained model)
  always @(*) begin
    if (idle_counter <= 0)
      power_enable = 1'b1;
    else if (idle_counter > 0 && idle_counter <= 3)
      power_enable = 1'b0;
    else
      power_enable = 1'b1;
  end

endmodule
