// Hamming Encoder Module (12,8)
module HammingEncoder(
    input [7:0] data_in,       // 8-bit input data
    output [11:0] encoded_data // 12-bit encoded data with parity bits
);
    wire p1, p2, p4, p8;

    // Calculate parity bits based on Hamming (12, 8) code rules
    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[6];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6];
    assign p4 = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7];
    assign p8 = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];

    // Assemble the encoded data with parity bits
    assign encoded_data = {p8, data_in[7:4], p4, data_in[3:1], p2, data_in[0], p1};
endmodule

// Hamming Decoder Module (12,8) with Error Detection and Correction
module HammingDecoder(
    input [11:0] encoded_data,  // 12-bit received encoded data
    output reg [7:0] data_out,  // 8-bit corrected data output
    output reg error_detected,  // Flag indicating an error was detected
    output reg error_corrected  // Flag indicating an error was corrected
);
    wire p1, p2, p4, p8;
    wire [3:0] syndrome;

    // Recalculate parity bits for error detection
    assign p1 = encoded_data[0] ^ encoded_data[2] ^ encoded_data[4] ^ encoded_data[6] ^ encoded_data[8] ^ encoded_data[10];
    assign p2 = encoded_data[1] ^ encoded_data[2] ^ encoded_data[5] ^ encoded_data[6] ^ encoded_data[9] ^ encoded_data[10];
    assign p4 = encoded_data[3] ^ encoded_data[4] ^ encoded_data[5] ^ encoded_data[6] ^ encoded_data[11];
    assign p8 = encoded_data[7] ^ encoded_data[8] ^ encoded_data[9] ^ encoded_data[10] ^ encoded_data[11];

    // Syndrome vector: indicates error location (if any)
    assign syndrome = {p8, p4, p2, p1};

    always @(encoded_data) begin
        if (syndrome == 4'b0000) begin
            // No error
            error_detected = 1'b0;
            error_corrected = 1'b0;
            data_out = encoded_data[10:3]; // Extract the original 8-bit data
        end else begin
            // Error detected, correct it
            error_detected = 1'b1;
            error_corrected = 1'b1;
            data_out = encoded_data[10:3] ^ (1 << (syndrome - 1)); // Correct the single-bit error
        end
    end
endmodule

// Memory Module with EDAC (Error Detection and Correction)
module MemoryEDAC(
    input [7:0] data_in,         // 8-bit data input
    input [3:0] address,         // 4-bit memory address
    input write_enable, read_enable,
    output [7:0] data_out,       // 8-bit corrected data output
    output error_detected,       // Flag for error detection
    output error_corrected       // Flag for error correction
);
    reg [11:0] memory [15:0];    // Memory array with 16 12-bit words (12 bits per word)

    // Intermediate signals
    wire [11:0] encoded_data;
    wire [7:0] decoded_data;
    wire detected_error, corrected_error;

    // Instantiate encoder and decoder modules
    HammingEncoder encoder(.data_in(data_in), .encoded_data(encoded_data));
    HammingDecoder decoder(.encoded_data(memory[address]), .data_out(decoded_data), .error_detected(detected_error), .error_corrected(corrected_error));

    // Write operation (store encoded data in memory)
    always @(posedge write_enable) begin
        memory[address] = encoded_data; // Write the encoded data to memory
    end

    // Read operation (retrieve and decode the data from memory)
    assign data_out = decoded_data;   // Get the corrected data from decoder
    assign error_detected = detected_error; // Set the error detection flag
    assign error_corrected = corrected_error; // Set the error correction flag
endmodule
