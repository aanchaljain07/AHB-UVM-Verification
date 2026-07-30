class ahb_test extends uvm_test;

`uvm_component_utils(ahb_test)

ahb_env env_h;
ahb_sequence seq_h;

function new (string name ="test",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env_h=ahb_env::type_id::create("env_h",this);
seq_h=ahb_sequence::type_id::create("seq_h");
endfunction





function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction



task run_phase(uvm_phase phase);
phase.raise_objection(this);
$display("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
seq_h.start(env_h.agent_h.seqcr_h);
$display("yoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
#20;
phase.drop_objection(this);

endtask
endclass 
