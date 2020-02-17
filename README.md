# Solid creator
Solid of revolution creator using [Processing](https://processing.org).

> **Adrián Lorenzo Melián** - *Creando Interfaces de Usuario*, [**ULPGC**](https://www.ulpgc.es).
> adrian.lorenzo101@alu.ulpgc.es

<div align="center">
 <img src=images/demo.gif alt="Creator demo"></img>
 <p>Figura 1 - Demostración de la ejecución de la aplicación</p>
</div>

***

## Índice
* [Introducción](#introduction)
* [Instrucciones de uso](#instructions) 
* [Implementación](#implementation)
    * [Arquitectura](#architecture)
    * [Rotación de puntos](#point-rotation)
    * [Creación de bandas de triángulos](#triangle-strip)
* [Herramientas y recursos utilizados](#tools-and-resources)
* [Referencias](#references)

## Introducción <a id="introduction"></a>
El objetivo de esta práctica es **la creación de una herramienta que permita crear un solido de revolución** [1] a partir de un eje y un conjunto de vértices que formarán la silueta de sólido. A partir de estos, se deberá generar el sólido haciendo **uso de bandas de triángulos.[2]**

## Instrucciones de uso <a id="instructions"></a>
El programa **comenzará con un lienzo vacío, delimitado por el eje a partir del cuál se obtendrá el sólido de revolución.** Las instrucciones se encontrarán en la pantalla:

* **Haciendo click izquierdo**, se podrá añadir un vértice.
* **Pulsando retroceso**, se podrá eliminar el último vértice añadido.
* **Pulsando enter**, se mostrará el sólido definido por los puntos.

En el modo de visualización, existen diferentes controles que permiten visualizar de una forma diferente el sólido:

* **Moviendo el ratón**, se podrá mover el sólido a través de los ejes `X` e `Y` del lienzo.
* **Haciendo scroll**, se podrá mover el sólido a través del eje `Z`.
* **Con las teclas W, A, S, y D**, se permite rotar el sólido en el eje `X`y en el eje `Y`.
* **Al pulsar retroceso**, volverás al creador de sólidos y podrás crear una nueva figura, eliminando la anterior.

## Implementación <a id="implementation"></a>

### Arquitectura <a id="architecture"></a>

Para poder trabajar bajo el paradigma de la **programación orientada a objetos**, fue necesario analizar el comportamiento de cada uno de los componentes que vamos utilizar. 

Era claro que **todos los elementos que aparecen en la pantalla compartían el mismo comportamiento**: todos eran **dibujables** en la pantalla. Por tanto, era necesario abstraer ese comportamiento en una interfaz, la cuál finalmente fue denominada `Drawable`.

```java
public interface Drawable {
    public void draw();
}
```

Todos las clases de los elementos que aparecen en la pantalla **implementan la interfaz `Drawable`**. Las clases de estos componentes son:

- `Key`. Clase que representa una figura de tecla.
- `SolidOfRevolution`. Clase que representa el sólido de revolución, y permite crear nuevas formas a partir de un conjunto de puntos.

Para el control del juego, se ha implementado la clase `CreatorController`. Esta **se encarga de controlar el bucle que compone el programa y de encuestar a los registros** que contienen información a cerca de **las teclas que han sido pulsadas**, para así realizar las acciones correspondiente.

Además, se han creado una serie de clases auxiliares que nos permiten manejar de forma los componentes y el controlador de la aplicación, como:

- `Point`. Que representa un punto en el espacio de 3 dimensione.
- `ScrollEvent`. Que representa un evento de scroll, de forma que pueda ser fácilmente manejable por el `CreatorController`

### Rotación de puntos <a id="point-rotation"></a>

Para obtener el sólido de revolución, es necesario **obtener los puntos resultantes de la rotación del mismo un número determinado de veces hasta 2π**, formando un meridiano. Esta rotación es necesaria realizarla en el eje.

Para ello, primero trasladamos los puntos a un origen en `(0, 0)` a partir del punto de origen del eje del lienzo. Luego, simplemente es necesario **iterar sobre todos los ángulos a los que se quiere rotar, calculando el punto resultante de esa rotación y añadiéndolo el nuevo vértice al objeto `PShape`.**

```java
Point currentPoint = points.get(i+1).getTranslatedPoint(origin);

for (float rad = 0; rad < 2*PI; rad += PI/64) {
  solid.vertex(
    currentPoint.getX() * cos(rad) - zValue * sin(rad), 
    currentPoint.getY(), 
    currentPoint.getX() * sin(rad) + zValue * cos(rad)
  );
}
```

### Creación de bandas de triángulos <a id="triangle-strip"></a>

Para la creación de las bandas de triángulos, se debe seguir un algoritmo en el que, **a partir de los puntos determinados por el usuario**, se obtengan **vértices que al rotar formen entre sí un conjunto de triángulos.** 

Para ello, la estrategia será **iterar en pares de puntos**, de tal manera de que **se insertan los puntos rotados de forma intercalada, formando dos meridianos que a su vez forman un conjunto de triángulos.** De esta manera, nos aseguraremos de que siempre se produzcan triángulos.

```java
for (int i = 0; i < points.size()-1; i++) {
  Point currentPoint = points.get(i+1).getTranslatedPoint(origin);
  Point previusPoint = points.get(i).getTranslatedPoint(origin);

  for (float rad = 0; rad < 2*PI; rad += PI/64) {
    solid.vertex(
      previusPoint.getX() * cos(rad) - zValue * sin(rad), 
      previusPoint.getY(), 
      previusPoint.getX() * sin(rad) + zValue * cos(rad)
    );

    solid.vertex(
      currentPoint.getX() * cos(rad) - zValue * sin(rad), 
      currentPoint.getY(), 
      currentPoint.getX() * sin(rad) + zValue * cos(rad)
    );
  }
}
```

## Herramientas y recursos utilizados <a id="tools-and-resources"></a>
- [GifAnimation](https://github.com/extrapixel/gif-animation) - Librería usada para la creación de gifs a partir de los frames de la aplicación.
- [Remix Icon](https://remixicon.com) - Set de iconos Open Source desde donde se obtuvo el icono del ratón.

## Referencias <a id="references"></a>
- [1] [Sólido de revolución](https://es.wikipedia.org/wiki/Sólido_de_revolución)
- [2] [Triangle strip](https://en.wikipedia.org/wiki/Triangle_strip)



