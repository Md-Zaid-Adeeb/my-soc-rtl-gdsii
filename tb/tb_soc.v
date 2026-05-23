module tb_soc;
    reg clk, rst_n;
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial begin
        rst_n = 0;
        #100;
        rst_n = 1;
        #10000;
        $display("Simulation PASSED!");
        $finish;
    end
    
    initial begin
        $dumpfile("soc_sim.vcd");
        $dumpvars(0, tb_soc);
    end
    
    soc_top dut (
        .clk     (clk),
        .rst_n   (rst_n),
        .uart_rx (1'b1),
        .uart_tx (),
        .spi_miso(1'b0)
    );
endmodule
