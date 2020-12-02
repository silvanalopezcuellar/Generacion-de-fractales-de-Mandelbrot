onerror {quit -f}
vlib work
vlog -work work mandelbrot.vo
vlog -work work mandelbrot.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.controlDibujo_vlg_vec_tst
vcd file -direction mandelbrot.msim.vcd
vcd add -internal controlDibujo_vlg_vec_tst/*
vcd add -internal controlDibujo_vlg_vec_tst/i1/*
add wave /*
run -all
