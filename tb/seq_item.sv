class ahb_tx extends uvm_sequence_item;
`uvm_object_utils(ahb_tx)
bit HSEL;
rand bit [31:0] HADDR; 
bit [ 1:0] HTRANS; 
rand bit HWRITE; 
rand bit [ 2:0] HSIZE;
randc bit [ 2:0] HBURST; 
rand bit [31:0] HWDATA;
bit [31:0] HRDATA; 
bit [ 1:0] HRESP;
bit HREADYout;
bit HREADYin;

function new(string name="ahb_tx");
super.new(name);
endfunction

constraint c1{HADDR<256;}

constraint c2{HSIZE<3;}
constraint c3{if(HSIZE==3'b001)
               HADDR%2==0;
           if(HSIZE==3'b010)
               HADDR%4==0;
}

constraint c4{if(HBURST==3'b011)
              HADDR%4==0;
              }
constraint c5{if(HBURST==3'b101)
              HADDR%8==0;
              }
constraint c6{if(HBURST==3'b111)
              HADDR%16==0;
              } 
constraint c7{if(!HBURST==3'b000)
              HADDR%2==0;
              }  



endclass 

