module normalization_s (
    input [24:0] res,
    input [7:0] exp_base,
    output reg [23:0] man_res,
    output reg [7:0] exp_res,
    output reg overflow
);
    reg [24:0] normalized_result;
    always @(*) begin
        normalized_result = res;
        exp_res = exp_base;

        if (normalized_result[24]) begin
            normalized_result = normalized_result >> 1;
            exp_res = exp_base + 1;
        end else while (normalized_result[23] == 0 && exp_res > 0) begin
            normalized_result = normalized_result << 1;
            exp_res = exp_res - 1;
        end

        man_res = normalized_result[23:0];
        overflow = (exp_res >= 8'b11111111);
    end
endmodule
