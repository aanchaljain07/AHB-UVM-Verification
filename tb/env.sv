class ahb_env extends uvm_env;

`uvm_component_utils(ahb_env)

ahb_agent agent_h;
ahb_scoreboard scbd_h;
ahb_coverage cov_h;

function new(string name="env",uvm_component parent);
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
super.build_phase(phase);
agent_h=ahb_agent::type_id::create("agent_h",this);
scbd_h=ahb_scoreboard::type_id::create("scbd_h",this);
cov_h=ahb_coverage::type_id::create("cov_h",this);

endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);


agent_h.mon_h.ap.connect(scbd_h.scbd_imp);
agent_h.mon_h.ap.connect(cov_h.analysis_export);
endfunction 









endclass
