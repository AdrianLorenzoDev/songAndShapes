# Song and shapes
An application that uses a song and shapes to create an "artistic" representation, using [Processing](https://processing.org).
> **Adrián Lorenzo Melián** - *Creando Interfaces de Usuario*, [**ULPGC**](https://www.ulpgc.es).
> adrian.lorenzo101@alu.ulpgc.es

<div align="center">
 <img src=images/demo.gif alt="Demo"></img>
 <p>Figura 1 - Demostración de la ejecución de la aplicación</p>
</div>

***

## Índice
* [Introducción](#introduction)
* [Requisitos](#requirements)
* [Implementación](#implementation)
    * [Canción](#song)
    * [Eventos](#events)
    * [Formas](#shapes)
* [Herramientas y recursos utilizados](#tools-and-resources)
* [Referencias](#references)

## Introducción <a id="introduction"></a>
El objetivo de esta práctica es **hacer uso de una combinación de salida gráfica en respuesta a una entrada de sonido.** Para ello, se ha desarrollado una aplicación que genera una canción y una serie de formas que rebotan en la ventana de la aplicación al ritmo de la canción.

## Requisitos <a id="requirements"></a>
Para hacer uso de esta aplicación, es necesario **tener instaladas la librería [Sound](https://processing.org/reference/libraries/sound/index.html) de Processing**, y **la librería compilada [SoundCipher](http://explodingart.com/soundcipher/)**.  

## Implementación <a id="implementation"></a>

### Canción <a id="song"></a>
Para la creación de la canción, ha sido necesario **construir una pequeña interfaz que permita un manejo más sencillo de las notas que podrár ser utilizadas en la composición de la canción.** Para ello, se han recogido las notas como constantes de la clase ``Notes``, y se ha creado una función muy simple que dada una nota base (octava `0`) y una octava determinada, te permite obtener la nota que deseas.

```java
float getNote(float baseNote, float octave) {
  return octave * 12 + baseNote;
}

final float[] Cmaj = {
  getNote(Notes.E, 4), 
  getNote(Notes.G, 4), 
  getNote(Notes.C, 5), 
  getNote(Notes.E, 5)
};
```

La canción ha sido creada haciendo uso de los **recursos ofrecidos por la librería *SoundCipher*.** Entre ellos, la clase `SCScore`, que permite en un patrón de tiempo establecer diferentes sonidos, acordes, etc. con unas características muy específicas. **La canción está formada por un conjunto de tracks en bucle que reproducen sonidos diferentes:**

- **Strumming track.**  Es el conjunto de sonidos (en este caso, formando acordes) que realizan un patrón específico de acompañamiento ritmo-melódico de la canción. Está formado por sonidos de piano.
- **Lead track**. Conjunto de sonidos que genera una frase melódica. Se reproduce cada dos patrones completos de la canción. Está formado por sonidos de piano.
- **Drums track**. Conjunto de sonidos que genera el acompañamiento rítmico de la canción. Está formado por sonidos de bombo y caja.

La canción se encuentra **abstraída en la clase `Song`, que posee los métodos necesarios para la reproducción de la misma, y la obtención de eventos.**

### Eventos <a id="events"></a>
Estos estados/eventos son útiles para la generación aleatoria de los gráficos que aparecen en la ventana. Dependiendo de estos, **las formas se generarán y visualizarán de una determinada manera en sincronización con la canción.**

Los eventos de la canción vienen representados por las constantes de la clase `SongState`. Estos eventos pueden generar una acción gráfica determinada:

- **Canción terminada (`finished`)**.
- **Bajo (`bass`)** - Genera una forma en movimiento de tamaño grande.
- **Ritmo (`rhythm`)** - Genera dos formas en movimiento de tamaño pequeño.
- **Lead (`lead`)** - Genera de 4 a 8 formas en movimiento de tamaño muy pequeño.
- **Lead sostenido en el tiempo (`leadSustain`)** - Cambia levemente el color de fondo.
- **Caja (`snare`)** - Cambia todas las formas de círculo a cuadrado o viceversa. El tipo de forma viene representado por la clase ```ShapeType```.

```java
void handleCallbacks(int id) {
  switch (id) {
    case SongState.finished:
      score.stop();
      song.playTrack();
      break;
    case SongState.bass:
      addBigCircle();
      break;
    case SongState.rhythm:
      addSmallCircle();
      break;
    case SongState.lead:
      addMiniCircles();
      break;
    case SongState.leadSustain:
      changeBackground(random(-1, 1) >= 0);
      break;
    case SongState.snare:
      changeShape();
      break;
  }
}
```

### Shapes <a id="shapes"></a>
**Las formas están representadas por la clase `SongShape`**. La velocidad y la potencia de frenado es seleccionada aleatoriamente entre los valores comprendidos de unos intervalos determinados (valor mínimo y máximo), que son diferentes entre los tres tipos de formas (grande, pequeña y muy pequeña).

**Estas formas al llegar a los limites de la ventana, colisionan con los mismos y cambian el sentido de su trayectoria** siguiendo un simple procedimiento.

```java
if (position.x + extent/2 >= width || position.x - extent/2 <= 0) {
  diffSpeed.x *= -1;
}
    
if (position.y + extent/2 >= height || position.y - extent/2 <= 0) {
  diffSpeed.y *= -1;
}
```

## Herramientas y recursos utilizados <a id="tools-and-resources"></a>
- [SoundCipher](http://explodingart.com/soundcipher/) - Librería para la generación y manejo de sonidos en Processing.
- [Giphy](https://giphy.com) - Herramienta usada para la creación de gifs a partir de los frames de la aplicación.

## Referencias <a id="references"></a>
- ***Guión de Prácticas 2019/20**, Creando Interfaces de Usuario*. Modesto F. Castrillón Santana, J Daniel Hernández Sosa.


