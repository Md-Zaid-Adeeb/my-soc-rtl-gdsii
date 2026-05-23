module soc_top (
    input  wire clk,
    input  wire rst_n,
    input  wire uart_rx,
    output wire uart_tx,
    output wire spi_sclk,
    output wire spi_mosi,
    input  wire spi_miso,
    output wire spi_cs_n
);

wire [31:0] wb_adr;
wire [31:0] wb_dat_s2m;
wire [31:0] wb_dat_m2s;
wire        wb_we;
wire [3:0]  wb_sel;
wire        wb_stb;
wire        wb_ack;
wire        wb_cyc;

picorv32 #(.ENABLE_MUL(1),.ENABLE_DIV(1)) cpu (
    .clk(clk),.resetn(rst_n),
    .mem_valid(wb_cyc),.mem_addr(wb_adr),
    .mem_wdata(wb_dat_m2s),.mem_wstrb(wb_sel),
    .mem_rdata(wb_dat_s2m),.mem_ready(wb_ack)
);

uart uart0 (
    .clk_50m(clk),
    .din(8'h00),
    .wr_en(1'b0),
    .tx(uart_tx),
    .rx(uart_rx),
    .rdy_clr(1'b0)
);

SPI_Master spi0 (
    .i_Rst_L(rst_n),.i_Clk(clk),
    .o_SPI_Clk(spi_sclk),.o_SPI_MOSI(spi_mosi),
    .i_SPI_MISO(spi_miso)
);

assign wb_ack = wb_cyc & wb_stb;
assign wb_dat_s2m = 32'hDEADBEEF;

endmodule