class ahb_driver extends uvm_driver#(ahb_tx);

`uvm_component_utils(ahb_driver)
int incr_count=9;
virtual ahb_interface vif;
bit [31:0] h_wdata;


function new(string name="ahb_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!(uvm_config_db#(virtual ahb_interface)::get(this,"","VIF",vif)))
`uvm_info(get_type_name(),"failed ",UVM_NONE)
else
`uvm_info(get_type_name(),"success",UVM_NONE)
endfunction



task run_phase(uvm_phase phase);
reset();

forever

begin
$display("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodrv");

seq_item_port.get_next_item(req);
$display("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooodrv");

fork
ahb_address_phase(req);
ahb_data_phase(req);
join
seq_item_port.item_done();
end
endtask

task reset();
if(!vif.rst)
begin
vif.HSEL<=0;
vif.HADDR<=0; 
vif.HTRANS<=0;
vif.HWRITE<=0; 
vif.HSIZE<=0;
vif.HBURST<=0; 
vif.HREADYin<=0;
@(posedge vif.HCLK);
//@(posedge vif.HCLK);

end
endtask


task ahb_address_phase(ahb_tx tx);
int h_size,i;

@(posedge vif.HCLK);

wait(vif.HREADYout);
begin
vif.HSEL<=1'b1;
vif.HADDR<=tx.HADDR; 
vif.HTRANS<=2'b10;
vif.HWRITE<=tx.HWRITE; 
vif.HSIZE<=tx.HSIZE;
vif.HBURST<=tx.HBURST; 
vif.HREADYin<=1'b1; 
end
case(tx.HSIZE)
3'b000:h_size=1;
3'b001:h_size=2;
3'b010:h_size=4;
endcase

case(tx.HBURST)
3'b010,3'b011:i=4;
3'b100,3'b101:i=8;
3'b110,3'b111:i=16;
3'b001:i=incr_count;
endcase
if(tx.HBURST==3'b000)
begin

end
else if(tx.HBURST%2==0)
ahb_wrap(tx,h_size,i);
else
ahb_incr(tx,h_size,i);
endtask

task ahb_wrap(ahb_tx tx,int h_size,int i);
int h_boundary=h_size*i;
int lp_boundary=(tx.HADDR/h_boundary)*h_boundary;
int up_boundary=lp_boundary+h_boundary;
$display("h_boundary=%0d,lp_boundary=%0d,up_boundary=%0d,HADDRS=%0d",h_boundary,lp_boundary,up_boundary,tx.HADDR);
repeat(i-1)
begin
@(posedge vif.HCLK)
if(tx.HADDR+h_size>=up_boundary)
tx.HADDR=lp_boundary;
else
tx.HADDR=tx.HADDR+h_size;

vif.HADDR<=tx.HADDR;
vif.HTRANS<=2'b11;
end

endtask

task ahb_incr(ahb_tx tx,int h_size,int i);
repeat(i-1)
begin
@(posedge vif.HCLK)
tx.HADDR=tx.HADDR+h_size;
vif.HADDR<=tx.HADDR;
vif.HTRANS<=2'b11;
end
endtask

task ahb_data_phase(ahb_tx tx);
int i;

case(tx.HBURST)
3'b000:i=1;
3'b010,3'b011:i=4;
3'b100,3'b101:i=8;
3'b110,3'b111:i=16;
3'b001:i=incr_count;

endcase



@(posedge vif.HCLK);
repeat(i)
begin
@(posedge vif.HCLK);
vif.HWDATA<=$random(h_wdata);

end
endtask





endclass
