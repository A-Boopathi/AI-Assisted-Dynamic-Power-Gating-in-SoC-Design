module reg_file(
    input clk,
    input we,
    input [1:0] wr_addr,
    input [3:0] wr_data,
    input [1:0] rd_addr,
    output reg [3:0] rd_data
);
    reg [3:0] regs[3:0];

    always @(posedge clk) begin
        if (we)
            regs[wr_addr] <= wr_data;
    end

    always @(*) begin
        rd_data = regs[rd_addr];
    end
endmodule

