# Noticias App

Aplicacion Flutter para consultar titulares de News API por categoria:
deportes, salud y ciencia.

## Requisitos

- Flutter 3.47 o superior
- Dart 3.13 o superior
- Una API key de [News API](https://newsapi.org/)

## Configuracion

La aplicacion recibe la clave mediante `--dart-define`.

```bash
flutter pub get
flutter run --dart-define=NEWS_API_KEY=TU_API_KEY
```

Para compilar, usa el mismo parametro:

```bash
flutter build apk --dart-define=NEWS_API_KEY=TU_API_KEY
```

Tambien puedes guardar la clave localmente en `env.json` como referencia, pero
Flutter no carga ese archivo automaticamente. El archivo esta incluido en
`.gitignore` y no debe versionarse.

## Ejecucion y pruebas

```bash
flutter analyze
flutter test
```

## Estructura

- `lib/models`: modelos de articulos y categorias.
- `lib/services`: acceso HTTP a News API.
- `lib/screens`: pantallas principales y listas de noticias.
- `lib/widgets`: componentes reutilizables de la interfaz.
- `lib/config`: configuracion de la API mediante variables de compilacion.

