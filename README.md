 # Proyecto I Electronica Digital I

* Camilo Prieto Gomez - 1000364337
* Tait Mozuca Tamayo - 1193560405
* Leidy Pinto Ramos - 1000787494
  
## Descripción general Y especificaciones de los sistemas que conforman el proyecto:
Un Tamagotchi es un aparato electrónico con forma de huevo en el que aparece una mascota virtual que se puede cuidar mediante generalmente tres botones. En nuestro proyecto, buscamos emular este dispositivo utilizando una FPGA Cyclone IV EP4CE6E22C8N y diversos sensores y elementos electrónicos, los cuales detallaremos en este documento.

El proyecto cuenta con cuatro botones, de los cuales cuatro estarán destinados a interactuar directamente con las necesidades del Tamagotchi (alimentar, dormir, curar y jugar), un boton cambiador de tiempo, un boton test que permite examinar cada una de las condiciones de la mascota virtual y un boton de reset completo del juego. Además, contará con dos pantallas de matriz de LEDs WS2812, cada una de 8x8 píxeles: una mostrará el personaje y la otra las barras y estados de energía. También incluye dos sensores externos: un sensor de luz y un sensor de movimiento ultrasónico para generar interacción con el juego.
![INICIO](https://github.com/user-attachments/assets/dadbe043-c4e5-4baa-ba16-1a29e510a191)



## Sistema de caja negra:


![tamaboring](https://github.com/user-attachments/assets/7ae1a630-79dd-41e6-862a-65f8cbbb5f8f)


El proyecto esta conformado por los siguientes elementos:

## Sistema de botones: 

Para los 7 botones antirrebote se usa el módulo "debounce", que se encarga de limpiar la señal del botón y eliminar los rebotes que se producen al presionarlo.
**botondebounced** es la salida del botón cuando ya se encuentra limpia; las variables internas son previous, compare, buttonneg y el contador. previous es una señal que almacena el último estado estable del botón; compare detecta si el estado actual del botón es diferente al último estado almacenado; buttonneg es la versión negada del botón. Ésta sirve para los botones normalmente abiertos. Finalmente, el contador cuenta el tiempo para estabilizar el botón después de detectar un cambio.
### Simulaciones: 
> ![Botones](https://github.com/user-attachments/assets/027c1b6b-0126-4bb8-be33-bf05a8ca8316)

## Sistema de Sensores:
Se contarán con 2 sensores, 1 sensor ultrasónico HC-SR04 y un sensor de luz
 
1. **sensor ultrasónico:** Periférico encargado de generar una única salida es 1 bit que indica una bandera de “Cercanía”, el cual se direccionara por medio del modulo especifico de driver ultrasonido.

![image](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo24-2024-1/assets/84733932/d51271f1-0765-40f9-9724-864dc0c1e111) 

2. **sensor de luz:** Periférico encargado de generar una única salida es 1 bit que indica una bandera de “claridad”. S realizara por medio de una fotoresistencia relacionada con un circuito de un amplificador operacional donde el valor de la fotoresistencia generara modificaciones en la entrada inversora modificando la salida del amplificador dependiendo la cantidad de luz que reciba.

![resis](https://github.com/unal-edigital1-lab/entrega-1-proyecto-grupo24-2024-1/assets/84733932/a12246a0-bf46-43af-95c6-a89d2cdcb4a5)


## Sistema de visualización: 

Pantallas 8x8 matriz de leds WS2812 : Esta pantalla utiliza el sistema RGB(Red,green,blue) de 24 bits, corresponderan a 2 pantallas de 8x8 que funcionaran por medio del** protocolo de comunicación unidireccional en serie de 1-wire** enviando el código RGB de cada color en binario por cada pixel, la pantalla guarda el dato del pixel y lo va desplazando de pixel a pixel, la codificación de cada bit se hace en funcion de un pulso PWM en donde un rango de porcentajes de PWM indican un uno lógico para la pantalla y otro rango diferente de porcentajes PWM indican un cero lógico. EN donde de esta manera se envían 24 bits lógicos que indican un código RGB para ese pixel, cuando se envie otro código con el único canal de datos, el código enviado anteriormente pasara al siguiente pixel y el nuevo código de almacenara en el primer pixel. Para dejar de mandar datos se deja descansar la pantalla por 0.5 segundos, asegurando que todos los LEDs reciban la información correcta para enviar por ultimo la señal reset y actualizar nuevamente la informacion de los LEDs.


![pantallas](https://github.com/user-attachments/assets/4c455579-7a71-4246-83ab-f05fd3f9658f)

Pantallas 8x8 matriz de leds RGB: la primera mostrara las imágenes del Yamaguchi reflejando con animaciones y con sus colores su estado actual según sus necesidades. La segunda mostrara 5 barras que indican el nivel de necesidad respectivo por cada ítem, para mostrar que tan necesitado se encuentra en su necesidad actual.

El control de imagen del proyecto en grosomodo va a encender pixeles específicos y asignarles un color dependiendo del estado del tamagushi. Esto se va a hacer por pasos:

<img src="img/Lectúra.png" width="500"/>

En el estado SCOLOR se asigna un color a cada estado, si el pixel no está activo se envía el color negro.

Cuando se elige el color dependiendo del estado del tamagushi se pasa al estado SENDCOLOR, sin embargo, este estado no solo funciona enviando los bits de datos del color, también elige la animación que se va a mostrar en pantalla.

Para el envío de bits de color se usó un multiplexor debido a que hay que enviar los datos de color uno por uno (se envían los bits de color verde, luego los bits de color azul y por último los bits de color rojo). Este multiplexor se puede ver en el módulo mux24. 

Para la animación,  esta animación depende del estado del tamagushi y también del tiempo que se lleva mostrando la animación actual, si se han mantenido 4 frames de la animación actual pasa a la siguiente (un frame (cframe) se completa cuando se enviaron los 127 pixeles). Por ejemplo, para el estado estado == 4'b0000 (cuando el tamagushi se encuentra en el estado "bien") la animación por defecto es la primera, si se mantiene 4 frames en este estado se pasa al estado 2, esto hace ver al tamagushi de forma más dinámica. Las animaciones se encuentran a continuación. 

<img src="img/Animación1.png" width="500"/>
<img src="img/Animación2.png" width="500"/>
<img src="img/Animación3.png" width="500"/>
<img src="img/Animación4.png" width="500"/>

Se dibujaron las visualizaciones, se escribieron en binario y luego se pasó esté código a hexadecimal.


En código hexadecimal de las animaciones queda así: (El código de las animaciones es el llamado ROMAnimation)
* 667E426A437F3F66
* 667E4256C2FEFC66
* 667E426A6B7F3F66
* 667E4256D6FEFC66
* 667E4242427E3C66

Estas animaciones van a ir a un multiplexor de 64, este, va a recibir el código de las animaciones y va a seleccionar que pixeles van a estar activos.

Para transmitir los bits para cada led se tiene que enviar un pulso, para el bit=0, la señal en alto tiene que ser muy corto, aproximadamente 350ns y una señal en bajo larga, 800ns. Para el bit=1, se necesita lo contrario, la señal en alto es de 700ns y la señal en bajo es de 600ns. (Estos valores fueron tomados del datasheet de la pantalla). Se necesitan estos valores en ciclos de reloj, debido a que la fpga tiene una frecuencia de 50mHz, 20ns, los valores para el bit 0, son de HL=17 ciclos, LL=40 ciclos, y para el bit 1, HL=35 ciclos, LL=30 ciclos. El tamaño del bit a transmitir es de 24 bits por pixel, por lo que son 3072 bits para las dos pantallas.

<img src="img/read (1).png" width="500"/>

El diagrama muestra la máquina de estados del transmisor para las pantallas.

El módulo transmisor se encarga de este trabajo. En el código se puede ver como se recibe el dato, lo convierte en ciclos y también hay un contador de cuantos datos se han recibido, así, al llegar al bit 3072 se reinicia el código.

## Visualización de velocidad y puntuación

En esta sección del proyecto, con la ayuda de un módulo covertidor BCD podemos primero asignar los valores correspondientes en la primera parte del código, y después visualizar con la ayuda del bloque **control** el número correspondiente al nivel de velocidad y a la puntuación en el display de 7 segmentos dividiéndolo en miles, centenas, decenas y unidades. Aunque usamos 8 ánodos, sólo tendremos activos 6 de ellos.

Para el caso de la velocidad, tendremos el siguiente bloque de código:
> ![image](https://github.com/user-attachments/assets/4b00287f-d20b-45b9-8975-a44c4f6d3dff)

que está encargado de asignarle un valor a numeroactual dependiendo del valor binario de 3 bits que tengamos en el momento. Por lo tanto, en vez de tener una representación del número binario a decimal en la simulación, vamos a obtener el número que se le fue asignado en el bloque de código, y luego expresarlo en decenas y unidades.

  ### Simulaciones: 
  #### Visualización de velocidad: 

  > ![Visualizacion velocidad](https://github.com/user-attachments/assets/afc9d3d5-20f3-4775-97b4-6bc328139e50)

  Como se puede ver, en vez de mostrar el equivalente del número binario en número actual o en decenas/unidades, se muestra el valor que se le fue asignado a ese número en el bloque anteriormente mencionado.

  #### Visualización de puntuación:
> ![Visualizacion puntuacion](https://github.com/user-attachments/assets/abfc1b85-e00c-423f-9691-05e9b1c0a278)

  ### Máquina de estados:
  > ![Estado 1](https://github.com/user-attachments/assets/506563cf-bcf4-4ee0-aa8e-66399df419ea)

## FPGA Altera Cyclone IV:
* Funcionalidad: Ejecutar la lógica de control y procesamiento del
Tamagotchi, incluyendo las máquinas de estados, la gestión de los estados y
necesidades de la mascota, y la generación de las señales de visualización.
* Implementación en HDL: La mayor parte de la lógica del Tamagotchi se
implementará en Verilog dentro de la FPGA, utilizando módulos y sub-
módulos para organizar el diseño.

# Especificaciones de Diseño Detalladas

## Necesidades:
El sistema tendra 4 necesidades(se mostrarán en barras de estado en la segunda pantalla led) cada una tiene un nivel de satisfacción del 1 como nivel mínimo y 8 como el máximo.
* Energía
* salud
* Comida
* Entretenimiento
* higiene

## Estados: 
La mascota virtual contara con 11 diferentes estados, cada uno sera representado con un color especifico para ser facilmente identificado por el jugador:
*	Estado cansado: la necesidad de energía se encuentra en 5 o por debajo(Azul)
*	Estado dormido: el tamaguchi se encuentra dormido(morado)
*	Estado Hambriento: la necesidad de comida se encuentra en 5 o por debajo(Amarillo)
*	Estado enfermo: la necesidad de salud se encuentra en 5 o por debajo(Rojo)
*	Estado aburrido: la necesidad de entretenimiento se encuentra en 5 o por debajo(Naranja)
*	Estado sucio: la necesidad de Higiene se encuentra en 5 o por debajo(Csfe)
*	Estado bien: Todas las necesidades se encuentran por encima del nivel 5, y la mascota se Encuentra generalmente satisfecha(Verde)
*	Estado excelente: todas las necesidades están en el máximo posible(Verde Claro)

## Control Puntuación:

Para la puntuación total, que es la suma de los valores de la salud, alimentación, energía, entretenimiento e higiene; éstas son entradas de 3 bits que van del nivel 0 al nivel 7.
**Bonus:** Es un valor que se activa en cuanto llegamos a la puntuación máxima, que es 35; el bonus es de 5 puntos.

**lostsalud, lostalimentacion, lostenergia, lostentretenimiento, losthigiene:** Son valores que representan la pérdida de puntos en la salud, energía y otras necesidades cuando su nivel está por debajo de 2. **puntosperdidos** es la salida que va a representar el total de puntos perdidos por los niveles bajos.

**deadsalud, deadalimentacion, deadenergia, deadentretenimiento, deadhigiene:** Son señales que representan cuando los niveles de salud, energía y entre otros llegaron al nivel 0. **Totalmalaracha** indica cuántos de estos indicadores están en nivel crítico y **negativebonus** penaliza al jugador por 5 punto cuando 2 o más necesidades están en 0.

**totalpuntosperdidos:** Es la suma de negativebonus y puntosperdidos.
Las banderas en el código se utilizan para evitar que se sumen puntos repetidamente dentro del mismo ciclo de reloj. La banderabus, por otro lado, funciona para que el bonus se otorgue sólo una vez en cuando se cumple la condición requerida.

  ### Simulaciones:
  ![Controlpuntuacion ](https://github.com/user-attachments/assets/334b7944-f83f-4293-833b-0aac57adf1a2)


## Interacciones
Las necesidades bajaran automáticamente con el tiempo de la siguiente manera:
* Salud: 1 nivel cada 10 minutos
* Comida: 1 nivel cada 5 minutos
* Energía: 1 Nivel cada 7 minutos
* Entretenimiento: 1 Nivel cada 3 minutos
* Higiene: 1 nivel cada 7 minutos
* Cabe aclarar que estos tiempos se modifican cuando el modo de velocidad no es X1, por lo que en los otros casos(x2,x5,x10) disminuiran proporcionalmente al valor de velocidad segun la modalidad elegida por el jugador.


# Arquitectura del sistema:
![TRABAJO](https://github.com/user-attachments/assets/84d2d35c-c763-4d6e-b344-3ef9a80ce6c7)

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
Tamagotchi en dos matrices de LEDs 8x8.
* Implementación en HDL: Se diseñará diferentes modulos en Verilog que se encarguen
de generar las señales de control y datos necesarios para actualizar la
matriz de LEDs.
## Boton reset: 
* Funcionalidad y implementacion: Cuando el botón de reset se mantiene presionado durante más de 5 segundos en el Tamagotchi, el dispositivo transiciona al estado "bien" y todas las necesidades se establecen en un valor de 7. Además, el contador de puntuación se reinicia a 0. En caso de que el Tamagotchi estuviera en modo de prueba, cambiará al modo "normal", donde las necesidades variarán con el tiempo.
* Conexión: pin de entrada/salida (I/O) en la FPGA conectado directamente al botón.
## Boton Test:
* Funcionalidad y implementacion:Al presionar el botón test por mas de 5 segundos, el tamaguchi entra en modo “test” en donde comienza a saltar entre los estados definidos anteriormente, con las condiciones especificadas ya sea el estado “hambriento” en donde todas las necesidades estarán en 7 a excepción de la necesidad “comida” que se encontrara en 5, y así sucesivamente.
* Conexión: pin de entrada/salida (I/O) en la FPGA conectado directamente al botón.
## Boton Acelerador: 
Permite acelerar el tiempo en la modalidad de juego del Tamagotchi, afectando las necesidades de forma mas rapida y haciendo que el nivel de juego sea mucho mas complicado.
## Sensor ultrasonido: 
* Funcionalidad y implementacion: Da un periférico encargado de la lectura del sensor, su única salida es 1 bit que indica una bandera de “Cercanía”, la cual tiene diferentes interacciones con los modulos diseñados de la fpga.
## Sensor de luz: 
* Funcionalidad y implementacion: Da un periférico encargado de la lectura del sensor, su única salida es 1 bit que indica una bandera de “claridad”, la cual tiene diferentes interacciones explicadas anteriormente.
