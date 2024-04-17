# Entrega 1 del proyecto WP01
# Proyecto Tamagotchi FPGA

### 1. Especificación:

El objetivo de este proyecto es diseñar un Tamagotchi utilizando una FPGA Cyclone IV y una matriz LED 8x8, programando con el lenguaje Quartus. Se busca crear un dispositivo portátil con una interfaz de usuario simple que permita al usuario interactuar con una mascota virtual, satisfacer sus necesidades básicas y observar su estado.

En esta fase inicial, se han contemplado las siguientes opciones de interacción:
- **Jugar:** Permite al usuario interactuar con la mascota virtual.
- **Dormir:** Permite al usuario indicar que la mascota debe dormir.
- **Curar:** Soluciona problemas relacionados con el estado de salud de la mascota.

El estado de la mascota será visible a través de un display de 7 segmentos. Se propone también utilizar un sensor de temperatura que afectará el estado de la mascota si se detecta calor o frío extremo.

### 2. Arquitectura:

#### a. Definición clara de la funcionalidad de cada periférico y coherencia con la implementación en HDL y su conexión:

- **Matriz de puntos:** Representará la mascota virtual y su estado de ánimo utilizando patrones de luz. Se controlará mediante un módulo en Verilog y estará conectada directamente a los pines asignados en la FPGA.

- **Display de 7 segmentos:** Indicará los niveles de ánimo y salud de la mascota. Se implementará en la FPGA mediante otro módulo en Verilog.

- **Botones físicos:**
  - **Reset:** Restablece el estado del Tamagotchi después de mantenerlo presionado durante 5 segundos.
  - **Test:** Verifica todas las funciones del Tamagotchi después de mantenerlo presionado durante 5 segundos.
  - **Dormir, Jugar y Curar:** Permiten al usuario interactuar con el Tamagotchi para satisfacer sus necesidades básicas. Se desarrollará un módulo en Verilog para detectar las pulsaciones de los botones y activar las funciones correspondientes.

- **Sensor de Temperatura:** Detecta temperaturas extremas y afecta el estado de salud del Tamagotchi si se detecta frío o calor extremo. Se utilizará un módulo en Verilog para leer los datos del sensor y procesarlos. El sensor estará conectado a los pines o a través de un bus de comunicación adecuado en la FPGA.

#### b. Capacidad para decidir la arquitectura más adecuada del proyecto y replanteamiento de modelos:
