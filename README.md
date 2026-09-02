# Leaner

Limpieza segura del disco y desinstalación de apps sin uso para macOS 14 o posterior.
Firmada con Developer ID y notarizada por Apple: se abre con doble clic, sin avisos.

## Descargar

- [Última versión (.dmg)](https://github.com/leaner-app/releases/releases/latest/download/Leaner.dmg): abre el dmg y arrastra Leaner a Aplicaciones.
- [Todas las versiones](https://github.com/leaner-app/releases/releases).

Instalación desde la Terminal, que copia la app en `/Applications`:

```bash
curl -fsSL https://raw.githubusercontent.com/leaner-app/releases/main/install.sh | zsh
```

## Qué limpia

| Categoría | Riesgo |
|---|---|
| Cachés y registros de apps, Papelera, estado de ventanas guardado | Seguro |
| Cachés de apps Chromium y Electron: Chrome, VS Code, Slack, Discord, Spotify… | Seguro |
| Cachés de npm, yarn, pnpm, bun, pip, Homebrew, Gradle, CocoaPods, Cargo, Go, Composer, NuGet | Seguro |
| DerivedData de Xcode, cachés y simuladores sin runtime | Seguro |
| Repositorio local de Maven, distribuciones de Gradle y JDKs | Revisar |
| Cachés de herramientas de terminal (`~/.cache`) y temporales antiguos | Revisar |
| DeviceSupport y Archives de Xcode, navegadores de Playwright | Revisar |
| Apps instaladas en simuladores apagados (el dispositivo se conserva) | Revisar |
| Descargas de Mail, instaladores y descargas antiguas | Revisar |
| Copias de iPhone/iPad, datos de apps ya desinstaladas | Revisar |

Lo «Seguro» viene preseleccionado; lo de «Revisar» solo se elimina si lo marcas tú. En un
equipo de desarrollo es fácil que la suma pase de 25 GB.

## Permisos

Para leer la Papelera, las descargas de Mail y las copias de iPhone, concede «Acceso total
al disco» a Leaner en Ajustes del Sistema → Privacidad y seguridad. La app te lleva a esa
pantalla con un botón.

## Qué hace y qué no

- Solo toca tu carpeta de usuario, los temporales y, al desinstalar, la app que elijas.
- Nunca entra en `/System`, `/Library`, `/usr` ni en apps de Apple o protegidas por SIP.
- Mail, Mensajes, Fotos, llaveros e iCloud Drive están vetados; las copias de iPhone y las
  descargas antiguas solo se proponen y van a la Papelera.
- Lo marcado como «Revisar» y las desinstalaciones van a la Papelera; puedes recuperarlas.

Este repositorio solo contiene las versiones publicadas. Incidencias y sugerencias en
[Issues](https://github.com/leaner-app/releases/issues).
