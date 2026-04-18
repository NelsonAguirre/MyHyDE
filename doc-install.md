# HyDE install.sh — Documentación

## Resumen

`install.sh` es el script principal de instalación de HyDE (Hyprland Dotfiles Environment). Orquesta todo el proceso: desde la configuración del bootloader hasta la restauración de temas, pasando por la instalación de paquetes y la habilitación de servicios del sistema.

```
./install.sh [opciones]
```

**Sin opciones** equivale a `-irs` (instalar + restaurar + servicios) — instalación completa.

---

## Opciones

| Flag | Nombre | Descripción |
|------|--------|-------------|
| `-i` | Install | Instalar paquetes de Hyprland SIN restaurar configs |
| `-d` | Default | Instalar con `--noconfirm` (sin interacción, usa defaults) |
| `-r` | Restore | Restaurar archivos de configuración |
| `-s` | Services | Habilitar servicios del sistema |
| `-n` | No Nvidia | Ignorar detección y acciones de Nvidia |
| `-h` | Shell | Re-evaluar la configuración de shell |
| `-m` | No Theme | No reinstalar temas (evita sobreescribir temas custom) |
| `-t` | Test Run | Dry run — simula sin ejecutar nada real |

### Combinaciones comunes

```sh
./install.sh                  # Instalación completa (equivale a -irs)
./install.sh -irs             # Lo mismo, explícito
./install.sh -irsn            # Completa SIN Nvidia
./install.sh -d               # Default sin interacción
./install.sh -irt             # Simulación completa (dry run)
./install.sh -r               # Solo restaurar configs (sin reinstalar paquetes)
./install.sh -s               # Solo habilitar servicios
./install.sh -irm             # Instalar + restaurar, pero NO tocar temas
```

### ⚠️ Error común

```sh
./install.sh -n    # ❌ NO funciona — -n solo ignora Nvidia, pero no activa -i -r -s
```

Los flags `-i`, `-r`, `-s` deben estar presentes para que esas fases se ejecuten. `-n` es un modificador, no un activador.

---

## Fases de ejecución

El script ejecuta **5 fases** secuenciales. Cada una depende de los flags activos:

```
┌─────────────────────┐
│  1. PRE-INSTALL     │  Solo si -i Y -r están activos
│  install_pre.sh     │
├─────────────────────┤
│  2. INSTALL         │  Solo si -i está activo
│  install_pkg.sh     │
├─────────────────────┤
│  3. RESTORE         │  Solo si -r está activo
│  restore_fnt.sh     │
│  restore_cfg.sh     │
│  restore_thm.sh     │
├─────────────────────┤
│  4. POST-INSTALL    │  Solo si -i Y -r están activos
│  install_pst.sh     │
├─────────────────────┤
│  5. SERVICES        │  Solo si -s está activo
│  restore_svc.sh     │
└─────────────────────┘
```

---

## Fase 1: Pre-Install (`install_pre.sh`)

Prepara el sistema antes de instalar paquetes. Se ejecuta solo cuando `-i` y `-r` están ambos activos (instalación completa).

### Bootloader (GRUB o systemd-boot)

**Si detecta GRUB:**
- Hace backup de `/etc/default/grub` y `/boot/grub/grub.cfg`
- Si hay GPU Nvidia y no se usó `-n`, agrega `nvidia_drm.modeset=1` a los parámetros del kernel
- Ofrece elegir tema GRUB:
  - `[1]` Retroboot (oscuro)
  - `[2]` Pochita (claro)
  - `[Enter]` Saltar

**Si detecta systemd-boot con Nvidia:**
- Agrega `nvidia_drm.modeset=1` a las entradas de boot en `/boot/loader/entries/`

### Pacman

- Hace backup de `/etc/pacman.conf`
- Habilita: `Color`, `ILoveCandy`, `VerbosePkgLists`, `ParallelDownloads = 5`
- Habilita repositorio `[multilib]` (para apps 32-bit)
- Ejecuta `pacman -Syyu` (actualización completa)
- Ejecuta `pacman -Fy` (actualiza cache de archivos)

### Chaotic AUR

- Pregunta si se desea instalar el repositorio Chaotic AUR
- Si se acepta, ejecuta `chaotic_aur.sh --install`
- Si ya está en `pacman.conf`, lo salta

---

## Fase 2: Install (`install_pkg.sh`)

Instala todos los paquetes necesarios. Se ejecuta solo con `-i`.

### Selección de AUR Helper

Si no hay un AUR helper instalado, pregunta cuál instalar:

| Opción | Helper |
|--------|--------|
| 1 | `yay` |
| 2 | `paru` |
| 3 | `yay-bin` (default) |
| 4 | `paru-bin` |

El timeout es de 120 segundos. Si no se responde, usa `yay-bin`.

### Selección de Shell

Si no hay un shell configurado en la lista de HyDE:

| Opción | Shell |
|--------|-------|
| 1 | `zsh` (default) |
| 2 | `fish` |

### Preparación de lista de paquetes

1. Copia `pkg_core.lst` a `install_pkg.lst` (lista temporal)
2. Si se pasó un archivo de paquetes custom como argumento, lo agrega:
   ```sh
   ./install.sh -i my_custom_packages.lst
   ```
3. Si se detecta Nvidia (y no se usó `-n`), agrega:
   - Headers del kernel actual (`kernel-headers`)
   - Drivers Nvidia detectados automáticamente

### Instalación de paquetes

- Filtra paquetes blacklist de `pkg_black.lst`
- Clasifica cada paquete como Arch oficial o AUR
- Instala los oficiales con `pacman -S`
- Instala los AUR con el helper seleccionado
- Soporta dependencias declaradas con formato `paquete|dep1 dep2`

### Paquetes incluidos (`pkg_core.lst`)

El archivo `pkg_core.lst` contiene ~116 paquetes organizados por categoría:

| Categoría | Paquetes clave |
|-----------|----------------|
| System | pipewire, networkmanager, bluez, brightnessctl, playerctl |
| Display Manager | sddm, qt5-quickcontrols, qt5-graphicaleffects |
| Window Manager | hyprland, dunst, rofi, waybar, swww, hyprlock, wlogout |
| Screenshots | grim, slurp, satty, hyprpicker, cliphist |
| Dependencies | polkit-gnome, xdg-desktop-portal-hyprland, jq, imagemagick |
| Theming | nwg-look, qt5ct, qt6ct, kvantum |
| Applications | kitty, dolphin, neovim, obsidian, mpv, lazygit, btop |
| Shell | starship (requiere zsh), fastfetch, thefuck |
| HyDE | hypridle |

---

## Fase 3: Restore

Restaura las configuraciones desde el repo al sistema del usuario. Se ejecuta solo con `-r`.

### restore_fnt.sh — Fuentes

- Instala fuentes desde `Source/arcs/Font_*.tar.gz` a `~/.local/share/fonts`
- Reconstruye el cache de fuentes con `fc-cache`

### restore_cfg.sh — Configuraciones

- Copia archivos de configuración desde `Configs/` a sus ubicaciones destino
- Usa la primera línea de cada archivo `.theme` para determinar el destino:
  ```
  $HOME/.config/hypr/themes/theme.conf|> $HOME/.config/hypr/themes/colors.conf
  ```
  Formato: `<destino>|<post-command>`
- Ejecuta el post-command después de copiar (ej: `killall -SIGUSR1 kitty` para recargar)
- Deshabilita autoreload de Hyprland durante la restauración

### restore_thm.sh — Temas

- Extrae tarballs desde `Source/arcs/`:
  - `Gtk_*.tar.gz` → `~/.local/share/themes/`
  - `Icon_*.tar.gz` → `~/.local/share/icons/`
  - `Sddm_*.tar.gz` → `/usr/share/sddm/themes/`
  - `Cursor_*.tar.gz` → `~/.local/share/icons/`
  - `Font_*.tar.gz` → `~/.local/share/fonts/`
- Valida que el tema en `hypr.theme` coincida con el nombre dentro del tarball
- Si `FULL_THEME_UPDATE=true`, sobreescribe archivos existentes

### Cache de wallpapers

- Genera cache de wallpapers con `wallpaper.cache.sh`
- Ejecuta `theme.switch.sh` para aplicar el tema activo
- Actualiza waybar con `waybar.py --update`

---

## Fase 4: Post-Install (`install_pst.sh`)

Configuraciones post-instalación. Se ejecuta solo cuando `-i` y `-r` están ambos activos.

### SDDM (Display Manager)

- Si `sddm` está instalado:
  - Ofrece elegir tema:
    - `[1]` Candy
    - `[2]` Corners (default)
  - Extrae `Sddm_*.tar.gz` a `/usr/share/sddm/themes/`
  - Configura `/etc/sddm.conf.d/`
  - Copia avatar de usuario si existe

### Dolphin (File Manager)

- Si `dolphin` está instalado:
  - Lo configura como explorador de archivos default vía `xdg-mime`

### Shell (`restore_shl.sh`)

- Configura el shell seleccionado (zsh o fish)
- Instala plugins y configuraciones

### Flatpak

- Si flatpak NO está instalado:
  - Muestra lista de flatpaks de `extra/custom_flat.lst`
  - Pregunta si se desean instalar
  - Si sí, ejecuta `extra/install_fpk.sh`

---

## Fase 5: Services (`restore_svc.sh`)

Habilita servicios del sistema. Se ejecuta solo con `-s`.

Servicios típicos habilitados:
- `NetworkManager`
- `bluetooth`
- `sddm`
- `pipewire` / `pipewire-pulse`
- `fstrim.timer`

---

## Migraciones

Después de restaurar (si `-r` activo), el script ejecuta migraciones desde `Scripts/migrations/`. Se ejecuta el archivo más reciente (ordenado por nombre, que usa versionado semántico).

Ejemplos existentes:
- `v25.8.2.sh`
- `v25.9.1.sh`

---

## Flags internos (variables de entorno)

Estas variables pueden exportarse antes de ejecutar el script:

| Variable | Default | Efecto |
|----------|---------|--------|
| `flg_DryRun` | 0 | Si es 1, simula sin ejecutar |
| `flg_Nvidia` | 1 | Si es 0, ignora detección Nvidia |
| `flg_Shell` | 0 | Si es 1, re-evalúa shell |
| `flg_ThemeInstall` | 1 | Si es 0, no reinstala temas |
| `FULL_THEME_UPDATE` | false | Si es true, sobreescribe temas existentes |
| `use_default` | — | Si está seteado (ej: `--noconfirm`), usa modo no-interactivo |
| `HYDE_LOG` | timestamp | Nombre del directorio de logs |

---

## Logs

Todos los logs se guardan en:
```
~/.cache/hyde/logs/<timestamp>/
```

El `timestamp` usa el formato `YYMMDD_HHmmhSSs` (ej: `250417_11h42m38s`).

Al finalizar, el script muestra la ruta al log.

---

## Flujo de reinicio

Si la instalación completó alguna fase real (no dry run), el script:

1. Verifica si existe `HYPRLAND_CONFIG` — si no, es instalación nueva
2. Recomienda reiniciar el sistema
3. Pregunta: `Do you want to reboot the system? (y/N)`
4. Si `y` → `systemctl reboot`

---

## Archivos de soporte

| Archivo | Ubicación | Función |
|---------|-----------|---------|
| `global_fn.sh` | Scripts/ | Funciones comunes, variables, detectores |
| `pkg_core.lst` | Scripts/ | Lista de paquetes a instalar |
| `pkg_black.lst` | Scripts/ | Paquetes a excluir |
| `install_aur.sh` | Scripts/ | Instalador de AUR helper |
| `chaotic_aur.sh` | Scripts/ | Instalador de Chaotic AUR |
| `restore_cfg.sh` | Scripts/ | Restaura configs desde Configs/ |
| `restore_fnt.sh` | Scripts/ | Restaura fuentes |
| `restore_thm.sh` | Scripts/ | Restaura temas desde tarballs |
| `restore_svc.sh` | Scripts/ | Habilita servicios del sistema |
| `restore_shl.sh` | Scripts/ | Configura shell |
| `install_fpk.sh` | Scripts/extra/ | Instala flatpaks |
| `install_mod.sh` | Scripts/extra/ | Instala módulos opcionales |
| `migrations/` | Scripts/ | Scripts de migración por versión |

---

## Ejemplos de uso

### Primera instalación (desde cero)
```sh
git clone https://github.com/prasanthrangan/hyprdots.git ~/HyDE
cd ~/HyDE/Scripts
./install.sh
```

### Actualizar sin tocar mis temas custom
```sh
./install.sh -irm
```

### Solo restaurar configs (paquetes ya instalados)
```sh
./install.sh -r
```

### Reinstalar todo en una máquina con Nvidia
```sh
./install.sh -irs
```

### Sin Nvidia (AMD/Intel)
```sh
./install.sh -irsn
```

### Simulación para ver qué haría
```sh
./install.sh -irst
```

### Instalación desatendida (para scripting)
```sh
./install.sh -d
```

### Agregar paquetes custom
```sh
# Crear mi_lista.lst con paquetes adicionales
echo "neofetch\nhtop\ntmux" > my_pkgs.lst
./install.sh -i my_pkgs.lst
```

---

## Solo instalar temas

`install.sh` **no tiene un flag dedicado para instalar solo temas**. El flag `-r` restaura configs, fuentes Y temas juntos — no permite seleccionar solo uno.

### Opción 1: `hydectl theme import` (recomendada)

Esta es la forma nativa de HyDE para instalar temas individuales sin tocar el resto del sistema:

```sh
# Desde una URL (repo remoto)
hydectl theme import --name "Neo-Rose" --url https://github.com/user/hyde-neo-rose

# Desde una ruta local
hydectl theme import --name "Neo-Rose" --url /home/nelson/Documents/repos/Hyde/hyde-neo-rose

# Aplicar el tema
hydectl theme set "Neo-Rose"
```

Esto hace:
1. Valida que los tarballs (`Gtk_*.tar.gz`, `Icon_*.tar.gz`, `Sddm_*.tar.gz`) coincidan con los nombres declarados en `hypr.theme`
2. Copia los archivos `.theme` a `~/.config/hyde/themes/<Nombre>/`
3. Extrae los tarballs a sus destinos (`~/.local/share/themes/`, `~/.local/share/icons/`, `/usr/share/sddm/themes/`)
4. Copia los wallpapers

**No instala paquetes, no toca configs de Hyprland, no modifica servicios.** Solo el tema.

### Opción 2: `install.sh -r` (con side effects)

```sh
./install.sh -r
```

Restaura configs + fuentes + temas. Los paquetes no se reinstalan porque `-i` no está activo. Pero **también sobreescribe las configuraciones de Hyprland y las fuentes** — no es selectivo.

### Opción 3: Extracción manual

Si se necesita control total, se pueden extraer los tarballs a mano:

```sh
# GTK theme
tar -xzf Source/arcs/Gtk_Neo-Rose.tar.gz -C ~/.local/share/themes/

# Icons
tar -xzf Source/arcs/Icon_Tela-circle-pink.tar.gz -C ~/.local/share/icons/

# SDDM (requiere sudo)
sudo tar -xzf Source/arcs/Sddm_Neo-Rose.tar.gz -C /usr/share/sddm/themes/

# Copiar configs del tema
cp -r Configs/.config/hyde/themes/Neo-Rose ~/.config/hyde/themes/

# Aplicar
hydectl theme set "Neo-Rose"
```

### Limitación conocida

No existe actualmente un flag como `-r --themes-only` en `install.sh`. Si se deseara instalar exclusivamente temas sin tocar configs ni fuentes, la herramienta correcta es `hydectl theme import`.
