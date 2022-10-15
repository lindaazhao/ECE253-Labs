# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim mux

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
#add wave {/*}
add wave \
{/mux/SW[9]} \
{/mux/SW[1]} \
{/mux/SW[0]} \
{/mux/LEDR[0]}

force {SW[0]} 0, 1 {10 ns} -r {20 ns}
force {SW[1]} 0, 1 {20 ns} -r {40 ns}
force {SW[9]} 0, 1 {40 ns} -r {80 ns}
run 80ns