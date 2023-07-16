module DataProcessing(
    input wire clk,
    input wire reset,
    input wire validIn,
    input wire [63:0] inData,
    output reg inputTaken,
    output reg validOut,
    output reg [7:0] outData8
);
    reg [63:0] buffer[0:2];
    reg [63:0] outData;
    integer i;
    integer counter;

    always @(validIn) begin
        if (validIn == 1'b1) begin
            inputTaken <= 1'b0;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 3; i = i + 1)
                buffer[i] <= 64'b0;
            validOut <= 1'b0;
            counter <= 0;
        end else if (validIn) begin
            inputTaken = 1'b0;
            buffer[0] <= buffer[1]; 
            buffer[1] <= buffer[2];
            buffer[2] <= inData;
            if (buffer[1] == 64'b0) begin
                counter = counter + 1;
                if (counter > 2) begin
                    buffer[1] <= (buffer[0] + buffer[2]) >> 1;
                    validOut <= 1'b1;
                end
                $display("Buffer (Fixed) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);
            end 
            $display("Buffer (Input) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);
            if (buffer[1] != 64'b0) begin
                $display("Buffer (Fixed) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);
                $display("Output:");

                for (i = 0; i < 8; i = i + 1) begin
                    outData8 = buffer[1][(i * 8) +: 8];
                    $display("outData8 = 0x%h", outData8);
                end
                validOut <= 1'b1;
            end
        end
    end
endmodule
