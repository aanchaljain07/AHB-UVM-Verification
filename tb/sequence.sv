class ahb_sequence extends uvm_sequence#(ahb_tx);

`uvm_object_utils(ahb_sequence)
int temp_haddr;
int temp_bust;
function new(string name="ahb_sequence");
super.new(name);
endfunction

task body();
req=ahb_tx::type_id::create("req");

repeat(10)
begin
//$display("yooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooseq");
start_item(req);
assert(req.randomize() with{HWRITE ==1;HSIZE==3'b010; });
temp_haddr=req.HADDR;
//temp_bust=req.HBURST;

finish_item(req);

start_item(req);
assert(req.randomize() with{HWRITE ==0 ;HADDR==temp_haddr;HSIZE==3'b010;});
finish_item(req);
end
endtask
endclass
