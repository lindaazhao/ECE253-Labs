# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

#load simulation using mux as the top level simulation module
vsim RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {ClockIn} 0,1 {1 ms} -r {2 ms}

force {Reset} 1
run 2 ms

force {Reset} 0
run 1 ms

force {started} 1
run 1000 ms
