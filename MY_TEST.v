`timescale 1ns / 1ps

module MY_TEST;

	// Inputs
	reg clock;
	reg [31:0] data_in;
	reg read;
	reg write;
	reg enable;
	reg reset;

	// Outputs
	wire [31:0] data_out;
	wire empty;
	

	// Instantiate the Unit Under Test (UUT)
	FIFO_BUFFER_MEMORY uut (
		.clock(clock), 
		.data_in(data_in), 
		.read(read), 
		.write(write), 
		.enable(enable), 
		.data_out(data_out), 
		.reset(reset), 
		.empty(empty)
		);

	initial begin
		// Initialize Inputs
		clock = 1'b0;
		data_in = 32'hx;
		read = 0;
		write = 0;
		enable = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
      enable  = 1'b1; //Made the circuit enable

      reset  = 1'b1;

      #20;

      reset  = 1'b0; // Made the reset Low 
		
		//UnderFlow Test - Expected output 32'bX
		
		read=1'b1;
		// Calling off the Underflow test 
		#20;
		
		read=1'b0;
		
		// Writing operation
		
		write  = 1'b1;
		
		data_in  = 32'h0;

      #20;

      data_in  = 32'h1;

      #20;

      data_in  = 32'h2;

      #20;

      data_in  = 32'h3;

      #20;

      data_in  = 32'h4;
		
		
      #20;

      data_in  = 32'h5;

      #20;

      data_in  = 32'h6;
      
		

      #20;

      data_in  = 32'h7; 

     
		#20
		
		write=1'b0;  
		
		read=1'b1;
		
		#190
		read=1'b0;
		
		#20
		write=1'b1;
		data_in=32'h8;
		
		#20
		write=1'b0;
		#20
		read=1'b1;
		
		
		
		#300
		read=1'b0;
		
		#20
		write=1'b1;
		data_in=32'h9;
		
		#20
		write=1'b0;
		//#20
		read=1'b1;
		
		#900000
		$finish;
		
	end
   always #10 clock = ~clock; 
        initial begin
        $dumpfile("FIFO_BUFFER_MEMORY.vcd"); 
		$dumpvars(0,MY_TEST);
       end
endmodule

