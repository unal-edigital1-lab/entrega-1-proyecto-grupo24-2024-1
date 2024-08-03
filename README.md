 # Entrega 1 del proyecto Tamagotchi Electronica Digital I

* Camilo Prieto Gomez-1000364337
* Tait Mozuca Tamayo - 1193560405
* Leidy Pinto Ramos - 1000787494
# Especificación de los sistemas que conforman el proyecto:
## Sistema de caja negra:


![tamaboring](https://github.com/user-attachments/assets/7ae1a630-79dd-41e6-862a-65f8cbbb5f8f)


El proyecto esta conformado por los siguientes elementos:

## Sistema de botones: 
Se contarán con 6 botones para interacción (cabe aclarar que se utilizara botones antirrebote digitales):

 1. **Alimentar:** Al ser presionado, inicia animación de comer y sube la necesidad de alimentación 1 unidad. 
 2. **Curar:** Al ser presionado, suba la necesidad de curación 1 unidad.
 3. **Limpiar:** Al ser presionado, suba la necesidad de higiene 1 unidad.
 4. **Dormir**: Al ser presionado, pondrá al tamaguchi en el estado “dormido”, al mantenerse en dicho estado por cierto tiempo aumentara energia en 1 unidad
 5. **Reset**: Al presionar el botón reset por mas de 5 segundos el tamaguchi salta al estado “bien” con todas las necesidades en el valor 7. 
 6. **Test**: Al presionar el botón test por mas de 5 segundos, el tamaguchi entra en modo “test” en donde comienza a saltar entre todos estados del tamagushi

## Sistema de Sensores:
Se contarán con 2 sensores, 1 sensor ultrasónico HC-SR04 y un sensor de luz
 
1. **sensor ultrasónico:** Periférico encargado de generar una única salida es 1 bit que indica una bandera de “Cercanía”, el cual se direccionara por medio del modulo especifico de driver ultrasonido.

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo24-2024-1/assets/84733932/d51271f1-0765-40f9-9724-864dc0c1e111) 

2. **sensor de luz:** Periférico encargado de generar una única salida es 1 bit que indica una bandera de “claridad”.

![resis](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo24-2024-1/assets/84733932/a12246a0-bf46-43af-95c6-a89d2cdcb4a5)


## Sistema de visualización: 

Pantallas 8x8 matriz de leds RGB: la primera mostrara las imágenes del Yamaguchi reflejando con animaciones y con sus colores su estado actual según sus necesidades. La segunda mostrara 5 barras que indican el nivel de necesidad respectivo por cada ítem, para mostrar que tan necesitado se encuentra en su necesidad actual.











## FPGA Altera Cyclone IV:
* Funcionalidad: Ejecutar la lógica de control y procesamiento del
Tamagotchi, incluyendo la máquina de estados, la gestión de los estados y
necesidades de la mascota, y la generación de las señales de visualización.
* Implementación en HDL: La mayor parte de la lógica del Tamagotchi se
implementará en Verilog dentro de la FPGA, utilizando módulos y sub-
módulos para organizar el diseño.

## Necesidades:
Energía, salud, comida, Entretenimiento, higiene. (estas necesidades se mostrarán en barras de estado en la segunda pantalla led) cada una tiene un nivel de satisfacción del 1 como nivel mínimo y 8 como el máximo.

## Sistema de puntuación:

Se obtendrá puntuación por cada vez que se satisfagan las necesidades de la mascota, y se perderán si esta se descuida. La puntuación se reflejará en el display 7 segmentos. La puntuación funcionara así:

* +1 punto si una necesidad no satisfecha se sube al nivel 7 o mas
* +5 puntos bonus si todas las necesidades se encuentran satisfechas al tiempo (esto genera una especie de racha para acumular puntos en cadena)
* -1 punto cada 10 segundos si una sola necesidad se encuentra por debajo del nivel 3 de satisfacción (esto es acumulable por cada necesidad, es decir, si 4 necesidades se encuentran por debajo del nivel 3 de satisfacción, se  perderán 4 puntos cada 10 segundos)
* -1 puntos por cada segundo extra si al menos 2 necesidades se encuentran en el nivel mínimo de satisfacción.

## Estados: 
Los diferentes estados de animo q puede tener la mascota.
*	Estado cansado: la necesidad de energía se encuentra en 5 o por debajo
*	Estado dormido: el tamaguchi se encuentra dormido
*	Estado Hambriento: la necesidad de comida se encuentra en 5 o por debajo
*	Estado enfermo: la necesidad de salud se encuentra en 5 o por debajo
*	Estado aburrido: la necesidad de entretenimiento se encuentra en 5 o por debajo
*	Estado sucio: la necesidad de Higiene se encuentra en 5 o por debajo
*	Estado bien: Todas las necesidades se encuentran por encima del nivel 5, y la mascota se Encuentra generalmente satisfecha.
*	Estado excelente: todas las necesidades están en el máximo posible, entrar en este estado suma instantáneamente 5 puntos a la puntuación (explicado anteriormente).

## Interacciones
Las necesidades bajaran automáticamente con el tiempo de la siguiente manera:
* Salud: 1 nivel cada 10 minutos
* Comida: 1 nivel cada 5 minutos
* Energía: 1 Nivel cada 7 minutos
* Entretenimiento: 1 Nivel cada 3 minutos
* Higiene: 1 nivel cada 7 minutos

## Colores:
Cada estado del tamaguchi definido se representa en el color del tamaguchi y nos muestra claramente cuál es su estado, esto se describe como sigue.
*	Estado cansado: Azul
*	Estado dormido: Morado
*	Estado Hambriento: amarillo
*	Estado enfermo: rojo
*	Estado aburrido: naranja
*	Estado sucio: café 
*	Estado bien: Verde
*	Estado excelente: Verde claro
*	Estado desolado: Gris 
*	Estado muerte: Blanco

## Lenguaje adecuado para describir el sistema:
Para la programación del sistema Tamagotchi, se utilizará el lenguaje de descripción de hardware
Verilog. Verilog es un lenguaje de alto nivel diseñado específicamente para la descripción y
síntesis de circuitos digitales, lo cual lo hace adecuado para el desarrollo de sistemas en
FPGA.



# Arquitectura del sistema:
## Trabajara con arquitectura modular
* La FPGA Cyclone IV actuará como el núcleo del sistema, integrando los diferentes módulos
funcionales.
* Cada módulo se encargará de una tarea específica, como la lógica de control, la máquina
de estados, la interfaz con los dispositivos, la visualización, etc.
* Los módulos se comunicarán entre sí a través de interfaces bien definidas, lo que permite
una mayor modularidad y flexibilidad en el diseño.
* Esta arquitectura modular facilita el desarrollo, la depuración y la posible expansión o
reemplazo de componentes en el futuro.

## FPGA Altera Cyclone IV:
* Funcionalidad: Ejecutar la lógica de control y procesamiento del
Tamagotchi, incluyendo la máquina de estados, la gestión de los estados y
necesidades de la mascota, y la generación de las señales de visualización.
* Implementación en HDL: La mayor parte de la lógica del Tamagotchi se
implementará en Verilog dentro de la FPGA, utilizando módulos y sub-
módulos para organizar el diseño.
* Conexión: La FPGA se conectará a los diversos periféricos a través de
interfaces digitales.
## Matriz de LED´s RGB:
* Funcionalidad: Visualizar de estados y barras de las animaciones del
Tamagotchi en una matriz de LEDs 8x8.
* Implementación en HDL: Se diseñará diferentes modulos en Verilog que se encarguen
de generar las señales de control y datos necesarios para actualizar la
matriz de LEDs.
## Boton reset: 
* Funcionalidad y implementacion: Cuando el botón de reset se mantiene presionado durante más de 5 segundos en el Tamagotchi, el dispositivo transiciona al estado "bien" y todas las necesidades se establecen en un valor de 7. Además, el contador de puntuación se reinicia a 0. En caso de que el Tamagotchi estuviera en modo de prueba, cambiará al modo "normal", donde las necesidades variarán con el tiempo.
* Conexión: pin de entrada/salida (I/O) en la FPGA conectado directamente al botón.
## Boton Test:
* Funcionalidad y implementacion:Al presionar el botón test por mas de 5 segundos, el tamaguchi entra en modo “test” en donde comienza a saltar entre los estados definidos anteriormente, con las condiciones especificadas ya sea el estado “hambriento” en donde todas las necesidades estarán en 7 a excepción de la necesidad “comida” que se encontrara en 5, y así sucesivamente.
* Conexión: pin de entrada/salida (I/O) en la FPGA conectado directamente al botón.
## Sensor ultrasonido: 
* Funcionalidad y implementacion: Da un periférico encargado de la lectura del sensor, su única salida es 1 bit que indica una bandera de “Cercanía”, la cual tiene diferentes interacciones con los modulos diseñados de la fpga.
## Sensor de luz: 
* Funcionalidad y implementacion: Da un periférico encargado de la lectura del sensor, su única salida es 1 bit que indica una bandera de “claridad”, la cual tiene diferentes interacciones explicadas posteriormente.
