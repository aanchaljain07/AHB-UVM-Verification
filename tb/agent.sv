class ahb_agent extends uvm_agent;
`uvm_component_utils(ahb_agent)

ahb_driver driv_h;
ahb_monitor mon_h;
ahb_sequencer seqcr_h;

function new(string name="agent",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
driv_h=ahb_driver::type_id::create("driv_h",this);
mon_h=ahb_monitor::type_id::create("mon_h",this);
seqcr_h=ahb_sequencer::type_id::create("seqcr_h",this);
endfunction


function void connect_phase(uvm_phase phase);
$display("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo con");

driv_h.seq_item_port.connect(seqcr_h.seq_item_export);
endfunction
endclass
