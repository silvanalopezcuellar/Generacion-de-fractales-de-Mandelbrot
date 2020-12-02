# Generacion-de-fractales-de-Mandelbrot
Este proyecto presenta la concepción, diseño e implementación de un sistema que genera un fractal de Mandelbrot en blanco y negro y se proyecta en un monitor; este se construye a partir de una sucesión por recursión, la cual si queda acotada se dice que el punto evaluado pertenece al conjunto de Mandelbrot, y si no, queda excluido del mismo. El proyecto fue inicialmente implementado para su desarrollo en software en Matlab, y para su desarrollo en hardware en VHDL por medio del programa Quartus II 13.0, utilizando la tarjeta de desarrollo de ALTERA DE0 Cyclone III EP3C16F484C6. El sistema se diseñó de tal forma que inicialmente se visualiza el dibujo del fractal desde las posiciones cartesianas [-2,-1] a [1,1], junto con el tiempo que le tomó al programa calcular el conjunto para 480x480 pixeles dependiendo del número de iteraciones para cada sucesión. Adicionalmente en el sistema diseñado es posible realizar ‘zoom’ o acercamientos sobre el dibujo, el cual, puede ser visualizado desde cualquier pantalla con entrada VGA, por medio de un cable VGA-VGA que se conecta directamente desde la tarjeta al monitor. Para los controles del zoom se utilizaron los pulsadores de la tarjeta y para la visualización del tiempo se realizó comunicación serial entre la tarjeta y un computador, de forma que el resultado se representa en el programa RealTerm con la línea “TIEMPO DE EJECUCIÓN: XX.XX s”. 
