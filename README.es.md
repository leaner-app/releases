<p align="right"><a href="README.md">English</a> · <b>Español</b></p>

<h1 align="center">Leaner</h1>

<p align="center">
  <strong>Recupera el disco que se comen Xcode, Gradle, Maven, node y los simuladores.</strong><br>
  App nativa para macOS 14 o posterior. Firmada con Developer ID y notarizada por Apple.
</p>

<p align="center">
  <a href="https://github.com/leaner-app/releases/releases/latest/download/Leaner.dmg"><b>Descargar .dmg</b></a> ·
  <a href="https://github.com/leaner-app/path-policy"><b>Auditar qué borra</b></a> ·
  <a href="https://github.com/leaner-app/releases/releases"><b>Todas las versiones</b></a>
</p>

<p align="center">
  <img src="docs/img/resumen.png" alt="Resumen de Leaner: disco, espacio recuperable y actualizaciones" width="820">
  <br><br>
  <img src="docs/img/limpieza.png" alt="Lista de categorías de limpieza con su tamaño y nivel de riesgo" width="820">
</p>

## Instalar

```bash
brew install --cask leaner-app/tap/leaner
```

O descarga el [.dmg](https://github.com/leaner-app/releases/releases/latest/download/Leaner.dmg)
y arrastra Leaner a Aplicaciones. También hay instalador por terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/leaner-app/releases/main/install.sh | zsh
```

## Por qué existe

Los limpiadores de disco para Mac buscan cachés de navegador y archivos de idioma. En una
máquina de desarrollo eso es calderilla: lo que ocupa son los repositorios de dependencias, las
distribuciones descargadas, los índices de compilación y los simuladores.

En el equipo donde se desarrolla Leaner, la primera medición dio esto:

| | |
|---|---|
| Cachés de apps Chromium y Electron (Chrome, VS Code, Slack, Spotify…) | 11,5 GB |
| Repositorio local de Maven | 7,1 GB |
| Distribuciones de Gradle y JDKs | 5,2 GB |
| Cachés de herramientas de terminal (`~/.cache`) | 2,2 GB |
| Cachés de gestores de paquetes (npm, yarn, pnpm, pip, Homebrew, Cargo, Go…) | 1,2 GB |
| Registros del daemon de Gradle | 1,2 GB |
| Resto (cachés del sistema, papelera, descargas, datos de apps desinstaladas…) | ~1 GB |
| **Total propuesto** | **29 GB** |

Tras esa primera limpieza, el mismo equipo sigue proponiendo unos 16 GB: las cachés se
regeneran y los repositorios de dependencias vuelven a crecer. Por eso la app está pensada para
volver a pasarla, no para usarla una vez.

## Qué limpia

| Categoría | Riesgo |
|---|---|
| Cachés y registros de apps, Papelera, estado de ventanas guardado | Seguro |
| Cachés de apps Chromium y Electron | Seguro |
| Cachés de npm, yarn, pnpm, bun, pip, Homebrew, Gradle, CocoaPods, Cargo, Go, Composer, NuGet | Seguro |
| DerivedData de Xcode, cachés y simuladores sin runtime | Seguro |
| Registros del daemon de Gradle | Seguro |
| Repositorio local de Maven, distribuciones de Gradle y JDKs | Revisar |
| Cachés de herramientas de terminal y temporales antiguos | Revisar |
| DeviceSupport y Archives de Xcode, navegadores de Playwright | Revisar |
| Apps instaladas en simuladores apagados (el dispositivo se conserva) | Revisar |
| Descargas de Mail, instaladores y descargas antiguas | Revisar |
| Copias de iPhone/iPad, datos de apps ya desinstaladas | Revisar |

Lo «Seguro» viene preseleccionado; lo de «Revisar» solo se elimina si lo marcas tú. Además
desinstala apps sin uso arrastrando sus datos, y localiza archivos grandes.

## Por qué puedes fiarte

Una app que borra archivos y pide «Acceso total al disco» tiene que ganarse esa confianza:

- **La política de borrado es pública y auditable**: [leaner-app/path-policy](https://github.com/leaner-app/path-policy).
  Clónala y ejecuta `swift test`. Es el mismo archivo que compila la app, con su `sha256`.
- **Autoridad única**: esa política se consulta al escanear y **otra vez antes de cada
  eliminación**, así que un error en un escáner no puede traducirse en un borrado indebido.
- **Ámbito acotado**: solo tu carpeta de usuario, `$TMPDIR` y, al desinstalar, la app elegida.
  Nunca `/System`, `/Library`, `/usr`, ni apps de Apple o protegidas por SIP.
- **Zonas vetadas**: Mail, Mensajes, Fotos, llaveros, iCloud Drive, contenedores de Apple y
  bibliotecas de Fotos o Música: ni se borran ni se recorren.
- **Reversible donde importa**: lo marcado como «Revisar» y las desinstalaciones van a la
  Papelera.
- **Sin telemetría.** La app solo sale a la red para comprobar si hay una versión nueva.

## Permisos

Para leer la Papelera, las descargas de Mail y las copias de iPhone hace falta conceder
«Acceso total al disco» en Ajustes del Sistema → Privacidad y seguridad. La app te lleva a esa
pantalla con un botón. Sin ese permiso funciona igual, pero se salta esas categorías.

## Actualizaciones

La app avisa cuando hay versión nueva y la instala tras comprobar que está firmada por el mismo
desarrollador y que Gatekeeper la acepta. Si la instalaste con Homebrew, delega en
`brew upgrade` para no descuadrar su contabilidad.

## Apoyar Leaner

Leaner es gratuita y no tiene telemetría, anuncios ni cuentas. Si te ha ahorrado un buen pellizco
de disco y quieres agradecerlo, puedes [patrocinarla en GitHub](https://github.com/sponsors/leinier)
o [invitarme a un café por PayPal](https://paypal.me/leinieraa). Es del todo opcional: no hay
nada en la app detrás de un pago.

---

Incidencias y sugerencias en [Issues](https://github.com/leaner-app/releases/issues).
