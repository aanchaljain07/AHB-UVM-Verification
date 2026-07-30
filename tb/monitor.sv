class ahb_monitor extends uvm_monitor;
`uvm_component_utils(ahb_monitor)

virtual ahb_interface vif;
uvm_analysis_port#(ahb_tx)ap;
ahb_tx tx;

function new(string name="ahb_monitor",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
tx=ahb_tx::type_id::create("tx");
ap=new("ap",this);

if(!(uvm_config_db#(virtual ahb_interface)::get(this,"","VIF",vif)))
`uvm_info(get_type_name(),"failed",UVM_NONE)
else
`uvm_info(get_type_name(),"success",UVM_NONE)
endfunction

task run_phase(uvm_phase phase);
forever
begin
@(posedge vif.HCLK);
tx.HSEL=vif.HSEL;
tx.HADDR=vif.HADDR; 
tx.HTRANS=vif.HTRANS;
tx.HWRITE=vif.HWRITE; 
tx.HSIZE=vif.HSIZE;
tx.HBURST=vif.HBURST;
tx.HRESP=vif.HRESP;
tx.HREADYin=vif.HREADYin;
tx.HREADYout=vif.HREADYout;

if(vif.HWRITE)
begin
tx.HWDATA=vif.HWDATA;


$display("hlo this my HRDATA=%0d",tx.HWDATA);
end
else
begin
//@(posedge vif.HCLK);
//#1;
tx.HRDATA=vif.HRDATA;
end
ap.write(tx);
end

endtask
endclass
