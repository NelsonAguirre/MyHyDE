#!/bin/env bash

#  ██████╗ ██████╗ ██████╗ ██╗   ██╗     ██████╗  █████╗ ███████╗███████╗██╗    ██╗ ██████╗ ██████╗ ██████╗
# ██╔════╝██╔═══██╗██╔══██╗╚██╗ ██╔╝     ██╔══██╗██╔══██╗██╔════╝██╔════╝██║    ██║██╔═══██╗██╔══██╗██╔══██╗
# ██║     ██║   ██║██████╔╝ ╚████╔╝█████╗██████╔╝███████║███████╗███████╗██║ █╗ ██║██║   ██║██████╔╝██║  ██║
# ██║     ██║   ██║██╔═══╝   ╚██╔╝ ╚════╝██╔═══╝ ██╔══██║╚════██║╚════██║██║███╗██║██║   ██║██╔══██╗██║  ██║
# ╚██████╗╚██████╔╝██║        ██║        ██║     ██║  ██║███████║███████║╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝
#  ╚═════╝ ╚═════╝ ╚═╝        ╚═╝        ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝ ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝

# ┬─┐┬ ┬┌┬┐┌─┐┌─┐
# ├┬┘│ │ │ ├─┤└─┐
# ┴└─└─┘ ┴ ┴ ┴└─┘

personal_home="/home/$(whoami)/"
path_pass="$personal_home.password-store"
time_per_copy=4

# ┌┬┐┬┌─┐┌┬┐┌─┐┌─┐  ┌┬┐┌─┐  ┌─┐┌─┐┌─┐┬┌─┐┌┬┐┌─┐
#  │ │├┤ │││├─┘│ │   ││├┤   │  │ │├─┘│├─┤ │││ │
#  ┴ ┴└─┘┴ ┴┴  └─┘  ─┴┘└─┘  └─┘└─┘┴  ┴┴ ┴─┴┘└─┘

export PASSWORD_STORE_CLIP_TIME=8

# ┌─┐┌┐ ┬─┐┬┬─┐  ┌─┐┌─┐┌─┐┌─┐
# ├─┤├┴┐├┬┘│├┬┘  ├─┘├─┤└─┐└─┐
# ┴ ┴└─┘┴└─┴┴└─  ┴  ┴ ┴└─┘└─┘

export PASSWORD_STORE_DIR="$path_pass"

# NOTE: Esta condicional está presente para que al momento de cancelar el ingreso de contraseña, solo se cancele una sola vez y no por cada carpeta pass(passp y passo)

PASSWORD_STORE_DIR=$path_pass pass open
sleep 3

# ┌─┐┌─┐┬  ┌─┐┌─┐┌─┐┬┌─┐┌┐┌  ┌─┐  ┌─┐┌─┐┌─┐┬┌─┐┬─┐
# └─┐├┤ │  ├┤ │  │  ││ ││││  ├─┤  │  │ │├─┘│├─┤├┬┘
# └─┘└─┘┴─┘└─┘└─┘└─┘┴└─┘┘└┘  ┴ ┴  └─┘└─┘┴  ┴┴ ┴┴└─
# almacena la ruta relativa a '.pass' y elimina la extensión '.gpg'
# NOTE: Se coloca el `[^tar]` con el objetivo de que no se filtre el archivo .tar que se crea una vez se usa `pass close`
list_pass="$(find $path_pass -type f -name "*[^tar].gpg"| sed "s|$path_pass/||g"| sed "s/.gpg//")"

if [ "$(echo "$list_pass" | wc -l)" -gt 1 ]; then

  # Se guarda la sección con rofi y se modifica el "/" con "-" de la entrada
  selection="$(echo -e "${list_pass//\//-}" | rofi -dmenu -theme-str "listview {columns: 9;}" -theme-str "* {font: \"${font_name:-"JetBrainsMono Nerd Font"} 12\";}" -theme "clipboard" -matching fuzzy -no-custom)"
  selection=${selection//-/\/} #Cambia los guiones con "/"
  selection="$selection"
  # ┌─┐┌─┐┌─┐┌─┐┌─┐  ┌┬┐┌─┐  ┌─┐┌─┐┬  ┌─┐┌─┐┌─┐┬┌─┐┌┐┌
  # │  ├─┤└─┐│ │└─┐   ││├┤   └─┐├┤ │  ├┤ │  │  ││ ││││
  # └─┘┴ ┴└─┘└─┘└─┘  ─┴┘└─┘  └─┘└─┘┴─┘└─┘└─┘└─┘┴└─┘┘└┘

  case "$selection" in *pass)
    # ┌─┐┌─┐┌─┐┌─┐  ┌─┐┌─┐┌─┐┌─┐┬ ┬┌─┐┬─┐┌┬┐
    # │  ├─┤└─┐│ │  ├─┘├─┤└─┐└─┐││││ │├┬┘ ││
    # └─┘┴ ┴└─┘└─┘  ┴  ┴ ┴└─┘└─┘└┴┘└─┘┴└──┴┘
    options="Pass\nUser+Pass\n"
    #Reconstruyendo el path, para colocar las opciones
    if [ -n "$(find "$path_pass/${selection%pass*}$(echo "${selection##*pass}")" -type f -name "otp.gpg")" ]; then #El comando todo raro de find, es para eliminar el último "pass" de la variable Selection.
      options+="Pass+OTP\nU+P+O"
    fi
    option="$(echo -e "$options" | rofi -dmenu -theme-str "listview {columns: 9;}" -theme-str "* {font: \"${font_name:-"JetBrainsMono Nerd Font"} 12\";}" -theme "clipboard" -matching fuzzy -no-custom)"
    case "$option" in
    "Pass")
      pass -c "$selection"
      dunstify "Copy Password" "Copied Password" -u normal
      ;;
    "User+Pass")
      pass -c2 "$selection"
      dunstify "Copy Password" "Copied Username" -u normal
      sleep $time_per_copy
      pass -c "$selection"
      dunstify "Copy Password" "Copied Password" -u normal
      ;;
    "Pass+OTP")
      pass -c "$selection"
      dunstify "Copy Password" "Copied Password" -u normal
      sleep $time_per_copy
      pass otp -c "${selection/pass/otp}"
      dunstify "Copy Password" "Copied OTP Code" -u normal
      ;;
    "U+P+O")
      pass -c2 "$selection"
      dunstify "Copy Password" "Copied Username" -u normal
      sleep $time_per_copy
      pass -c "$selection"
      dunstify "Copy Password" "Copied Password" -u normal
      sleep $time_per_copy
      pass otp -c "${selection/pass/otp}"
      dunstify "Copy Password" "Copied OTP Code" -u normal
      ;;
    esac

    ;;
  *otp)
    # ┌─┐┌─┐┌─┐┌─┐  ┌─┐┌┬┐┌─┐
    # │  ├─┤└─┐│ │  │ │ │ ├─┘
    # └─┘┴ ┴└─┘└─┘  └─┘ ┴ ┴
    echo -e "$list_pass" | grep "$selection"
    pass otp -c "$selection"
    dunstify "Copy Password" "Copied OTP Code" -u normal
    ;;
  *)
    # ┌─┐┌─┐┌─┐┌─┐  ┌─┐┌─┐┌┐┌┌─┐┬─┐┌─┐┬
    # │  ├─┤└─┐│ │  │ ┬├┤ │││├┤ ├┬┘├─┤│
    # └─┘┴ ┴└─┘└─┘  └─┘└─┘┘└┘└─┘┴└─┴ ┴┴─┘
    pass -c "$selection"
    dunstify "Copy Password" "Copied Password" -u normal
    ;;
  esac
  # ┌─┐┌─┐┬─┐┬─┐┌─┐┬─┐  ┌─┐┌─┐┌─┐┌─┐
  # │  ├┤ ├┬┘├┬┘├─┤├┬┘  ├─┘├─┤└─┐└─┐
  # └─┘└─┘┴└─┴└─┴ ┴┴└─  ┴  ┴ ┴└─┘└─┘
  pass close &>/dev/null
  exit 0
else
  exit 1
fi
