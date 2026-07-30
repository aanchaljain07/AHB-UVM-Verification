class ahb_coverage extends uvm_subscriber#(ahb_tx);
`uvm_component_utils(ahb_coverage)

ahb_tx tx;

covergroup coverg;

c1:coverpoint tx.HADDR{
bins adr={[0:255]};
}

c2: coverpoint tx.HSEL{
bins sel={[0:1]};
}


c3: coverpoint tx.HBURST{
bins burst={[0:7]};
}


c4: coverpoint tx.HRESP{
bins resp={[0:1]};
}


c5: coverpoint tx.HSIZE{
bins hsize={[0:2]};
}

c6: coverpoint tx.HTRANS{
bins htrans={[0:3]};
}

c7: coverpoint tx.HWDATA{
bins htrans={[0:$]};
}

c8: coverpoint tx.HRDATA{
bins htrans={[0:$]};
}






endgroup









function new(string name="ahb_coverage",uvm_component parent);
super.new(name,parent);
coverg=new();

endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
tx=ahb_tx::type_id::create("tx");

endfunction

function void write(ahb_tx t);
this.tx=t;
coverg.sample();
endfunction



endclass
