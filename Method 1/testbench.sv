`timescale 1ns/1ns

module testbench;
    reg clk;
    reg reset;
    reg validIn;
    reg [63:0] inData;
    wire validOut;
    wire [7:0] outData8;
    reg inputTaken;
    
    initial begin
        clk = 0;
        reset = 1'b1;
        validIn = 1'b0;
        inData = 64'b0;
        #10 reset = 1'b0;
        $display("start");
        $display("Input 1");
        validIn = 1'b0;
        #10 validIn = 1'b1; inData = 64'h1111111111111111;
        #10 $display("Input 2"); validIn = 1'b1; inData = 64'h2222222200222222;
        #10 $display("Input 3"); validIn = 1'b1; inData = 64'h0000000000000000;
        #10 $display("Input 4"); validIn = 1'b1; inData = 64'h4444444444444444;
        #20 $display("Input 5"); validIn = 1'b1; inData = 64'h6739293791021284;
        #10 $display("Input 6"); validIn = 1'b1; inData = 64'h0;
        #10 $display("Input 7"); validIn = 1'b1; inData = 64'h6739293791021284;
        #40 validIn = 1'b0;
        #100 $finish;
    end
    always #5 clk = ~clk;
    DataProcessing u1 (.clk(clk), .reset(reset), .validIn(validIn), .inData(inData), .validOut(validOut), .outData8(outData8));

endmodule