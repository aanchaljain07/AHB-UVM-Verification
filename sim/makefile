.ONESHELL:

RTL = ../rtl/rtl.v

TB = ../tb/top.sv

PKG = ../tb/package.sv

INTF = ../tb/interface.sv

INCDIR = +incdir+../tb

COV = -coverage all -covoverwrite -covtest $(test) -covworkdir cov_work

#TESTLIST = ./test.list

test =ahb_test
	

run:
	irun -sv -uvm -access +rwc ${INCDIR} ${INTF} ${PKG} ${TB} ${RTL} ${COV}  -timescale 1ns/1ps 

clean:
	rm -rf *.trn *.dsn *.vcd INC* cov*

sim:
	simvision &
