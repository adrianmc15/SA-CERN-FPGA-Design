`timescale 1ns/1ns

module testbench;
    reg clk;
    reg reset;
    reg [63:0] inData;
    wire [7:0] outData8;
    
    initial begin
        clk = 0;
        reset = 1'b1;
        inData = 64'b0;
        #10 reset = 1'b0;
        $display("start");
        #20 inData = 64'h1111111111111111; $display("Input 1: 0x%h", inData);
        #50 inData = 64'h2222222200222222; $display("Input 2: 0x%h", inData);
        #50 inData = 64'h0000000000000000; $display("Input 3: 0x%h", inData);   
        #50 inData = 64'h4444444444444444; $display("Input 4: 0x%h", inData);
        #50 inData = 64'h6739293791021284; $display("Input 5: 0x%h", inData);
        #50 inData = 64'h0000000000000000; $display("Input 6: 0x%h", inData);
        #50 inData = 64'h6739293791021284; $display("Input 7: 0x%h", inData);
        #50 inData = 64'h4444444444444444; $display("Input 8: 0x%h", inData);
        #50 inData = 64'h0000000000000000; $display("Input 9: 0x%h", inData);
        #50 inData = 64'h6739293791021284; $display("Input 10: 0x%h", inData);

        #50;
        #1600 $finish;
    end
    always #5 clk = ~clk;
    DataProcessing u1 (.clk(clk), .reset(reset), .inData(inData), .outData8(outData8));

endmodule