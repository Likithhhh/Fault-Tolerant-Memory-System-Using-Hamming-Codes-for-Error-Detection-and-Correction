module testbench;
    reg [7:0] data_in;        // 8-bit data input
    reg [3:0] address;        // 4-bit address input
    reg write_enable, read_enable;
    wire [7:0] data_out;      // 8-bit corrected data output
    wire error_detected, error_corrected;

    // Instantiate the MemoryEDAC module
    MemoryEDAC mem_edac(
        .data_in(data_in),
        .address(address),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .data_out(data_out),
        .error_detected(error_detected),
        .error_corrected(error_corrected)
    );

    // Test sequence
    initial begin
        // Initialize signals
        data_in = 8'b10101010;
        address = 4'b0000;
        write_enable = 0;
        read_enable = 0;

        // Write data to memory
        #5 write_enable = 1; // Enable write operation
        #5 write_enable = 0; // Disable write operation
        
        // Simulate a read with no error
        #5 address = 4'b0000;  // Read from address 0
        #5 read_enable = 1;    // Enable read operation
        #5 read_enable = 0;    // Disable read operation

        // Simulate a read with a bit-flip error
        #5 mem_edac.memory[address] = 12'b101010101010 ^ (1 << 2); // Simulate a bit-flip error in memory
        #5 read_enable = 1;    // Enable read operation
        #5 read_enable = 0;    // Disable read operation

        // Finish simulation
        #5 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t, data_in = %b, data_out = %b, error_detected = %b, error_corrected = %b", 
                 $time, data_in, data_out, error_detected, error_corrected);
    end

    // Dump waveform for analysis
    initial begin
        $dumpfile("simulation.vcd");  // Specify VCD file for waveform output
        $dumpvars(0, testbench);      // Dump all signals in testbench
    end
endmodule
