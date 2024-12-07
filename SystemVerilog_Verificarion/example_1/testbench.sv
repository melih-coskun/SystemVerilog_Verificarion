// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps
module calc_tb;
    // Inputs
    reg clk;
    reg rst;
    reg validIn;
    reg [15:0] dataIn;

    // Outputs
    wire [15:0] dataOut;
  
	// Testvector
  reg [50:0] testvectors [8];

    // Instantiate the Unit Under Test (UUT)
    calc uut(.clk(clk), .rst(rst), .validIn(validIn), .dataIn(dataIn), .dataOut(dataOut));

  	// Clock period: 10 ns
    initial begin
       clk = 0;
       forever #5 clk <= ~clk;
    end

    initial begin
      // test vector format:
      // {result (16-bit), operand-2(16-bit), operation (3-bit), operand-1(16-bit)}
      // testvectors[x][50:35], testvectors[x][34:19], testvectors[x][18:16], testvectors[x][15:0]
      
      // Please convert this tetbench to automatic testbench. Fill testvector. Use testvector.
      
      $readmemb("test_vector.tv", testvectors); // asigning input-output result file to testvectors register
       	// reset phase
		rst = 0;
       	validIn = 0;
       	dataIn = 0;
       	rst = 1;
       	#10;
       	rst = 0;

      	// ##########################################################
       	// Test Square Op.
       	// Enter operand
        dataIn 			= testvectors[3][15:0]; // 'd2
        $display("dataIn: %0b",dataIn);
       	validIn 		= 1;
       	#10;
       	validIn 		= 0;
       	#10;
       	// Enter operator
      dataIn 			= testvectors[3][18:16]; // 'd2: square
       	validIn 		= 1;
       	#10;
       	validIn 		= 0;
       	#10;
       	// Check output
      	if (dataOut === testvectors[3][50:35])
        	$display("Square Op.: OK! dataOut = %0b ", dataOut);
       	else
         	$display("Square Op.: Wrong! dataOut = %0b ", dataOut);

       // ##########################################################
       // Test Multiply Op.
       // Enter operand
      dataIn 			= testvectors[4][15:0];
      $display("dataIn_1: %0d",dataIn);
       validIn 			= 1;
       #10;
       validIn 			= 0;
       #10;
       // Enter operator
      dataIn 			= testvectors[4][18:16];
       validIn 			= 1;
       #10;
       validIn 			= 0;
       #10;
       // Enter operand
      dataIn 			= testvectors[4][34:19];
      $display("dataIn_2: %0d",dataIn);
       validIn 			= 1;
       #10;
       validIn 			= 0;
       #10;
       // Check output
      if (dataOut === testvectors[4][50:35])
        $display("Multiply Op.: OK! dataOut = %0d ", dataOut);
       else
         $display("Multiply Op.: Wrong! ");

      // ##########################################################
      // Addition Op.
      // Enter operand
      dataIn = testvectors[5][15:0];
      $display("dataIn: %0d",dataIn);
      validIn = 1;
      #10;
      validIn = 0;
      #10;
      // Enter operator
      dataIn =  testvectors[5][18:16];
      validIn = 1;
      #10;
      validIn = 0;
      #10;
      // Enter operand
      dataIn = testvectors[5][34:19];
      $display("dataIn: %0d",dataIn);
      validIn = 1;
      #10;
      validIn = 0;
      #10;
      // Check output
      if (dataOut === testvectors[5][50:35])
         $display("Addition Op.: OK! dataOut = %0d ", dataOut);
      else
        $display("Addition Op.: Wrong! ");


      // ##########################################################
      // Incrementation Op.
      // Enter operand
      dataIn = testvectors[6][15:0];
       $display("dataIn: %0d",dataIn);
      validIn = 1;
      #10;
      validIn = 0;
      #10;
      // Enter operator
      dataIn = testvectors[6][18:16] ;
      validIn = 1;
      #10;
      validIn = 0;
      #10;
      // Check output
      if (dataOut === testvectors[6][50:35])
        $display("Addition Op.: OK! dataOut = %0d ", dataOut);
      else
        $display("incrementation Op.: Wrong! ");

       #20; 

       $finish;
    end

endmodule
