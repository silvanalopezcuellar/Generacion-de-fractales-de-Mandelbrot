transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/contm.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/register_color.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/register_file.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/register_c.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/RAM.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/controlFractal.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/my_package.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/contv.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/controlvertical.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/controlhorizontal.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/conth.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/cont.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/vertical.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/Operacion.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/horizontal.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/Escape.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/Suma.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/proof.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/controlDibujo.vhd}
vcom -93 -work work {C:/Users/Usuario/Downloads/mandelbrot/mandelbrot.vhd}

