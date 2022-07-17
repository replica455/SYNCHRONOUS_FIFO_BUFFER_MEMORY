module FIFO_BUFFER_MEMORY( clock, data_in, read, write,  enable, data_out, reset,empty ); 
//input and output
input  clock, read, write, enable, reset;
input   [31:0]    data_in;
output  empty;
output reg [31:0] data_out; 
//internal registers and memory declairation 
reg [2:0]  count = 0;        // Counts Memory Word; There are 8 word so 3 bit register is enough
reg [31:0] memory [0:7];     // 8 Word Memory with each word size of 32 bit
reg [2:0]  read_pointer = 0; 
reg [2:0]  write_pointer = 0; //Read and write pointer  
//To check the empty condition
assign empty = (count==0)? 1'b1:1'b0; 
always @ (posedge clock) 
begin 
 if (enable==0); //if "Active High Enable" condition is low then do nothing
 else begin 
  if (reset) begin 
   read_pointer = 0; 
   write_pointer = 0; 
  end 
  else if (read ==1'b1 && count!=0) begin 
   data_out  = memory[read_pointer]; 
   read_pointer = read_pointer+1; 
  end 
  else if (write==1'b1 && count<8) begin
   memory[write_pointer]  = data_in; 
   write_pointer  = write_pointer+1; 
  end 
  else; 
 end 
//Error Handeling of read and write pointer
 if (write_pointer==8) 
  write_pointer=0; 
 else if (read_pointer==8) 
  read_pointer=0; 
 else;
// Adjusting the "count" value for function of "EMPTY"
 if (read_pointer > write_pointer) begin 
  count=read_pointer-write_pointer; 
 end 
 else if (write_pointer > read_pointer) 
  count=write_pointer-read_pointer; 
 else;
end 

endmodule 