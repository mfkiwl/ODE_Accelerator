module division_testbench;
    reg [15:0] A;
    reg [15:0] B;
    wire [15:0] result;
    reg [15:0] expected_result;
    wire overflow_flag;
    reg expected_overflow_flag;
    reg[48:0] read_data [0:100];
    wire finish;
    reg clk;
    reg start;

    integer i;

    initial
    begin
        clk = 1;
        forever begin
            #5  clk = ~clk;
        end
    end

    division division_unit(clk, 1'b0, A, B, start, result, overflow_flag, finish);

    initial
    begin
        $readmemb("Fixed Point Arithmetic/test/division_test_cases.txt", read_data);

        #1
        for (i=0; i<100; i=i+1)
        begin
            #5
            {A, B, expected_result, expected_overflow_flag} = read_data[i];
            start <= 1;
            #10
            start <= 0;
            #235
            if (finish != 1'b1 || overflow_flag != expected_overflow_flag || ((expected_result != result) && (!overflow_flag)))
                $display("%d : FAILED", i);
            //start <= 0;
        end
        $stop;
    end
endmodule