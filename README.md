 # Entrega 1 del proyecto WP01

* Camilo Prieto Gomez-1000364337
* Tait Mozuca Tamayo - 1193560405
* Leidy Pinto Ramos - 1000787494
# Especificación de los sistemas que conforman el proyecto:
## Sistema de visualización: 

Pantallas 8x8 LED: la primera mostrara las imágenes del Yamaguchi reflejando con animaciones y con sus colores su estado actual según sus necesidades. La segunda mostrara 5 barras que indican el nivel de necesidad respectivo por cada ítem, para mostrar que tan necesitado se encuentra en su necesidad actual.
## Sistema de botones: 
Se contarán con 4 botones para interacción (“dormir”, “curar”, “alimentar”, “limpiar”), además de los botones de reset y test.

## Sensores:
Se contarán con 2 sensores, 1 sensor ultrasónico HC-SR04 y un sensor de luz que es simplemente una Fotorresistencia en un divisor de tensión que pasara al ADC del Arduino.

## Necesidades:
Energía, salud, comida, Entretenimiento, higiene. (estas necesidades se mostrarán en barras de estado en la segunda pantalla led) cada una tiene un nivel de satisfacción del 1 como nivel mínimo y 8 como el máximo.

## Sistema de puntuación:

Se obtendrá puntuación por cada vez que se satisfagan las necesidades de la mascota, y se perderán si esta se descuida. La puntuación se reflejará en el display 7 segmentos. La puntuación funcionara así:

* +1 punto si una necesidad no satisfecha se sube al nivel 7 o mas
* +5 puntos bonus si todas las necesidades se encuentran satisfechas al tiempo (esto genera una especie de racha para acumular puntos en cadena)
* -1 punto cada 10 segundos si una sola necesidad se encuentra por debajo del nivel 3 de satisfacción (esto es acumulable por cada necesidad, es decir, si 4 necesidades se encuentran por debajo del nivel 3 de satisfacción, se  perderán 4 puntos cada 10 segundos)
* -1 puntos por cada segundo extra si al menos 2 necesidades se encuentran en el nivel mínimo de satisfacción.
