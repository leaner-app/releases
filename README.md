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
