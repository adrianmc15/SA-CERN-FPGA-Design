module DataProcessing(
    input wire clk,
    input wire reset,
    input wire [63:0] inData,
    output reg [7:0] outData8
);
    reg [63:0] buffer[0:2];
    reg [63:0] largeBuffer[0:7];
    reg [63:0] outData;
    reg [63:0] prevData;
    integer i;
    integer clockCount;
    integer buffCount;
    reg [31:0] runCount;
    reg outFlag;
    reg [63:0] nextData;

    // always @(validIn) begin
    //     if (validIn == 1'b1) begin
    //         inputTaken <= 1'b0;
    //     end
    // end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 3; i = i + 1)
                buffer[i] <= 64'b0;
            buffCount <= 0;
            prevData <= 64'h0; // initialise to 0
            clockCount <= 0;
            runCount <= 0;
            outFlag <= 1'b0;
            // nextData <= 64'h0;
        end 
        else begin
        if(runCount < 700) begin
             if (prevData != inData) begin
                // if prevData not equal to inData
                    // add it to the buffer at the lgBufferCounter
                    // if lgBufferCounter > max size, raise error
                    // $display("Input detected: %h", inData);

                    largeBuffer[buffCount] <= inData;
                    prevData <= inData;
                    buffCount = buffCount + 1;
                    // $display("largeBuffer %d: 0x%h", buffCount, largeBuffer[buffCount - 1]);
                    if (buffCount > 7) begin
                        $display("Large Buffer Full, data sending too fast");
                    end
                end
                if (clockCount > 9) begin
                // if clock cycle counter = 20
                    // process largeBuffer[0]
                    // shift everything in largeBuffer

                    outData = buffer[2];
                    // $display("outData (initial) = 0x%h", outData);
                    if (outData == 64'b0) begin
                        outData = (buffer[1] + largeBuffer[0]) >> 1;
                    end
                    // $display("Buffer (Input) = [0x%h] [0x%h] [0x%h]", buffer[0], buffer[1], buffer[2]);

                    // $display("outData (final) = 0x%h", outData);
                    buffer[0] <= buffer[1]; 
                    buffer[1] <= buffer[2];
                    buffer[2] <= largeBuffer[0];
                    if (outData != 64'h0 && !(largeBuffer[1] == 0 && largeBuffer[0] == 0 && buffer[2] == 0) ) begin
                        if (outFlag == 1'b1) begin
                        $display("Output:");
                            for (i = 0; i < 8; i = i + 1) begin
                                outData8 = outData[(i * 8) +: 8];
                                $display("outData8 = 0x%h", outData8);
                            end
                        end
                        outFlag <= 1'b1;
                    end

                    // shift largeBuffer
                    largeBuffer[0] <= largeBuffer[1]; 
                    largeBuffer[1] <= largeBuffer[2];
                    largeBuffer[2] <= largeBuffer[3];
                    largeBuffer[3] <= largeBuffer[4];
                    largeBuffer[4] <= largeBuffer[5];
                    largeBuffer[5] <= largeBuffer[6];
                    largeBuffer[6] <= largeBuffer[7];
                    largeBuffer[7] <= 64'h0;

                    buffCount = buffCount - 1;
                    clockCount = 0;

                end
                clockCount = clockCount + 1;
                runCount = runCount + 1;
            end
        end
    end
endmodule
