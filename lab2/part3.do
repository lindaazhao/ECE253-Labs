# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

# load simulation using mux as the top level simulation module
vsim hex_decoder

# log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {c[0]} 0, 1 {10 ns} -r {20 ns}
force {c[1]} 0, 1 {20 ns} -r {40 ns}
force {c[2]} 0, 1 {40 ns} -r {80 ns}
force {c[3]} 0, 1 {80 ns} -r {160 ns}
run 160ns
