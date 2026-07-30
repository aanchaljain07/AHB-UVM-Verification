/*class ahb_scoreboard extends uvm_scoreboard;

`uvm_component_utils(ahb_scoreboard)

uvm_tlm_analysis_fifo#(ahb_tx) fifo_s;
ahb_tx tx;
ahb_tx q[$];
ahb_tx prev_tx;

[31:0]mem[0:255];
function new(string name="ahb_scoreboard",uvm_component parent);
super.new(name,parent);
fifo_s=new("fifo_s",this);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//tx = new();
endfunction

task run_phase(uvm_phase phase);
forever
begin
fifo_s.get(tx);
data(tx);

endtask


task data(ahb_tx tx);
q.push_back(tx);

if(q.size()>1)
begin
prev_tx=q.pop_front();

if(prev_tx.HWRITE)
write_data(prev_tx,tx);
else
read_data(prev_tx,tx);


end

endtask

task write_data(ahb_tx prev_tx,ahb_tx tx);
mem[prev_tx.HWADDR]=tx.HWDATA;

endtask

task 

endclass
*/

class ahb_scoreboard extends uvm_scoreboard;
`uvm_component_utils(ahb_scoreboard)
uvm_analysis_imp#(ahb_tx,ahb_scoreboard)scbd_imp;

bit[31:0]mem[*];

function new(string name="ahb_scoreboard",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
scbd_imp=new("scbd_imp",this);
endfunction

function void write(ahb_tx tx);


if(tx.HWRITE)begin
mem[tx.HADDR]=tx.HWDATA;
`uvm_info("Scoreboard",$sformatf("Write addr=0x%0h Data=0x%0h",tx.HADDR,tx.HWDATA),UVM_LOW);


end

else begin
if(mem.exists(tx.HADDR))begin
if(mem[tx.HADDR]==tx.HRDATA)begin
`uvm_info("Scoreboard",$sformatf("PASS addr=0x%0h expected=0x%0h actual=0x%0h",tx.HADDR,mem[tx.HADDR],tx.HRDATA),UVM_LOW);
end
else begin
`uvm_info("Scoreboard",$sformatf("FAIL addr=0x%0h expected=0x%0h actual=0x%0h",tx.HADDR,mem[tx.HADDR],tx.HRDATA),UVM_LOW);
end
end
else 
`uvm_warning("Scoreboard",$sformatf("READ BEFORE WRITE addr=0x%0h data=0x%0h",tx.HADDR,tx.HRDATA));
end
endfunction

endclass



