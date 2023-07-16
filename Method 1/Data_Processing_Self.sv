module DataProcessing(
    input wire clk,
    input wire reset,
    input wire validIn,
    input wire [63:0] inData,
    output reg validOut,
    output reg [7:0] outData8
);
    reg [63:0] buffer[0:2];
    integer i;
    integer counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 3; i = i + 1)
                buffer[i] <= 64'b0;
            validOut <= 1'b0;
            counter <= 0;

        end else if (validIn) begin
            buffer[0] <= buffer[1];
            buffer[1] <= buffer[2];
            buffer[2] <= inData;
            $display("Buffer (Input) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);

            if (buffer[1] == 64'b0) begin
                buffer[1] <= (buffer[0] + buffer[2]) >> 1;
                counter = counter + 1;
                if (counter > 1) begin
                    validOut <= 1'b1;
                end
                $display("Buffer (Fixed) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);
            end

            if (validOut == 1'b1) begin
                $display("Output:");
                for (i = 0; i < 8; i = i + 1)
                begin
                    outData8 <= buffer[1][(i * 8) +: 8];
                    $display("outData8 = 0x%h", outData8);
                end
            end
       end
    end
endmodule

