# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.sv

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Clock} 0,1 {5 ns} -r {10 ns}

force {Reset} 1
run 10 ns

force {Reset} 0
run 5 ns

force {w} 1
run 50 ns

force {w} 0
run 10 ns

force {w} 1
run 20 ns
