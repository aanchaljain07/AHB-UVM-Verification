import ahb_pkg::*;
import uvm_pkg::*;
module top;

bit clk;
bit rst;
always #5clk=~clk;
ahb_interface pif(clk,rst);
mem_ahb dut(.HCLK(clk),.HRESETn(rst),.HSEL(pif.HSEL),.HADDR(pif.HADDR),.HTRANS(pif.HTRANS),.HWRITE(pif.HWRITE),.HSIZE(pif.HSIZE),.HBURST(pif.HBURST),.HWDATA(pif.HWDATA),.HRDATA(pif.HRDATA),.HRESP(pif.HRESP),.HREADYin(pif.HREADYin),.HREADYout(pif.HREADYout));
initial 
begin
rst=0;
#15 rst=1;
end

initial 
begin
uvm_config_db#(virtual ahb_interface)::set(null,"*","VIF",pif);
run_test ("ahb_test");
end

initial
begin
$dumpfile("dump.vcd");
$dumpvars();
end

initial begin
    $recordvars();
    $recordfile("dump.trn");
    end


endmodule
