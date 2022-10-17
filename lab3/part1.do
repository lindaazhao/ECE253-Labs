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
#add wave {/*}
add wave \
# {/part1/a[0]} \
# {/part1/a[1]} \
# {/part1/a[2]} \
# {/part1/a[3]} \
# {/part1/b[0]} \
# {/part1/b[1]} \
# {/part1/b[2]} \
# {/part1/b[3]} \
# {/part1/c_in} \
# {/part1/LEDR[0]}

force {SW[0]} 0, 1 {10 ns} -r {20 ns}
force {SW[1]} 0, 1 {20 ns} -r {40 ns}
force {SW[9]} 0, 1 {40 ns} -r {80 ns}
run 80ns