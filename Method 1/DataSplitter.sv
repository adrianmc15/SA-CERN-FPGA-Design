module DataSplitter(input wire clk,
                    input wire reset,
                    input wire validIn,
                    input wire [63:0] inData,
                    output reg validOut,
                    output reg [7:0] outData8);
    
    reg [2:0] counter;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 3'b0;
            validOut <= 1'b0;
        end
        else if (validIn && counter == 3'b111) begin
            counter <= 3'b0;
            validOut <= 1'b0;
        end
        else if (validIn) begin
            counter <= counter + 3'b1;
            validOut <= 1'b1;
            outData8 <= inData[(counter*8)+:8];
        end
    end
    
endmodule
