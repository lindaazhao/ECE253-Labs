# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Clock} 0,1 {5 ns} -r {10 ns}

force {Reset} 1
run 15 ns

force {Reset} 0
run 5 ns

force {DataIn} 00000101
force {Go} 0, 1 {10 ns} -r {20 ns}
run 20 ns

force {DataIn} 00000100
run 200 ns

