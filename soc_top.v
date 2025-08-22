module soc_top (
    input clk,
    input reset,
    input [2:0] alu_op,
    input [7:0] A, B,
    output reg [7:0] result,
    output reg power_enable
);

reg [2:0] idle_counter; // Reduced for area
reg alu_active;

// Optimized ALU logic for latency
always @(posedge clk or posedge reset) begin
    if (reset) begin
        result <= 0;
        idle_counter <= 0;
        alu_active <= 0;
        power_enable <= 1;
    end else begin
        // Detect active operation immediately
        if (alu_op != 3'b000) begin
            alu_active <= 1;
            idle_counter <= 0;               // Reset idle counter fast
            power_enable <= 1;               // Ensure ALU is powered on
        end else begin
            alu_active <= 0;
            if (idle_counter < 7)
                idle_counter <= idle_counter + 1;
        end

        // Power gating logic (latency-aware)
        if (idle_counter >= 3)               // Only power off if idle 3+ cycles
            power_enable <= 0;

        // ALU operation only if enabled
        if (power_enable) begin
            case (alu_op)
                3'b000: result <= result; // No-op
                3'b001: result <= A + B;
                3'b010: result <= A - B;
                3'b011: result <= A & B;
                3'b100: result <= A | B;
                3'b101: result <= A ^ B;
                default: result <= 8'h00;
            endcase
        end else begin
            result <= 8'hZZ; // Tri-state when off
        end
    end
end

endmodule

