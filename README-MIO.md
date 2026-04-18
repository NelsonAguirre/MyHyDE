# MyHyDE — Notas personales

Configuración personal de HyDE (Hyprland Dotfiles Environment).

---

## Cambiar el tema de la pantalla de login (SDDM)

HyDE **no cambia automáticamente** el tema de SDDM al seleccionar un tema. Es un gap conocido — los temas instalan los archivos del SDDM pero no actualizan la configuración que dice cuál tema usar.

### Archivo que controla el tema activo

```
/etc/sddm.conf.d/the_hyde_project.conf
```

Línea a modificar: `Current=<nombre-del-tema>`

### Comando para cambiar el tema

```sh
sudo sed -i 's/^Current=.*/Current=Neo-Rose/' /etc/sddm.conf.d/the_hyde_project.conf
```

Reemplazar `Neo-Rose` por el tema deseado. El cambio aplica en el próximo inicio de sesión.

### Temas disponibles

Los temas SDDM instalados viven en:

```
/usr/share/sddm/themes/
```

Para ver cuáles hay:

```sh
ls /usr/share/sddm/themes/
```

Cada tema que tenga un tarball `Sddm_*.tar.gz` en su repo se instala automáticamente al importar el tema. Pero la config de SDDM debe cambiarse manualmente con el comando de arriba.

### Verificar qué tema está activo

```sh
grep '^Current=' /etc/sddm.conf.d/the_hyde_project.conf
```

### Por qué no es automático

SDDM requiere permisos de root (`/etc/sddm.conf.d/` y `/usr/share/sddm/themes/` son del sistema). Los scripts de HyDE que cambian tema (`theme.switch.sh`, `hydectl theme set`) se ejecutan como usuario normal y no pueden modificar archivos de sistema sin `sudo`.

La línea `exec = Hyde sddm set $SDDM_THEME` que aparece en algunos `hypr.theme` es un vestigio del comando viejo `Hyde` que ya no existe — `hydectl` no tiene subcomando equivalente.

### Previsualizar sin apagar

Se puede ver cómo queda un tema SDDM sin cerrar sesión ni reiniciar:

```sh
QML2_IMPORT_PATH=/usr/lib/qt5/qml sddm-greeter --test-mode --theme /usr/share/sddm/themes/<nombre>
```

Abre una ventana con el preview del login. Cerrala normalmente y volvés a tu escritorio.

**Nota**: algunos temas pueden fallar con error `Library import requires a version` — es incompatibilidad de versiones Qt/QML entre el tema y tu sistema. Los temas oficiales de HyDE (Candy, Corners) suelen funcionar. Los temas custom pueden requerir ajustes en `Main.qml`.
