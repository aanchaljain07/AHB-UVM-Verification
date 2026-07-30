interface ahb_interface(input bit HCLK,input bit rst);
//logic HRESETn;
//logic HCLK; 
logic HSEL;
logic [31:0] HADDR; 
logic [ 1:0] HTRANS; 
logic HWRITE; 
logic [ 2:0] HSIZE;
logic [ 2:0] HBURST; 
logic [31:0] HWDATA;
logic [31:0] HRDATA; 
logic [ 1:0] HRESP; 
logic HREADYin; 
logic HREADYout;



property p1;
@(posedge HCLK)
!HREADYin |-> $stable({HADDR, HTRANS, HWRITE, HSIZE, HBURST});
endproperty

property p2;
@(posedge HCLK)
HSEL && HREADYout |-> (HTRANS inside {2'b10,2'b11});
endproperty


property p3;
@(posedge HCLK)
(HTRANS == 2'b10) |=> (HTRANS ==2'b11) [*1:$];
endproperty

property p4;
@(posedge HCLK)
HWRITE && HREADYout |-> !$isunknown(HWDATA);
endproperty


property p5;
@(posedge HCLK)
!HWRITE && HREADYout |-> !$isunknown(HRDATA);
endproperty

property p6;
@(posedge HCLK)
HREADYout |-> (HRESP inside {0,1});
endproperty

P1:assert property(p1);
P2:assert property(p2);
P3:assert property(p3);
P4:assert property(p4);
P5:assert property(p5);
P6:assert property(p6);


endinterface
