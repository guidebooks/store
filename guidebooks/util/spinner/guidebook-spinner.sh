#!/bin/bash
# Shows a spinner while another command is running. Randomly picks one of 12 spinner styles.
# @args command to run (with any parameters) while showing a spinner. 
#       E.g. ‹spinner sleep 10›

function shutdown() {
  printf "\x1b[0" # reset colors
  printf "\x1b[?25h" # cursor visible
}
trap shutdown EXIT

function spinner() {
  # make sure we use non-unicode character type locale 
  # (that way it works for any locale as long as the font supports the characters)
  local LC_CTYPE=C

  local pid=$1 # Process Id of the previous running command

  case 7 in
  0)
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local charwidth=3
    ;;
  1)
    local spin='-\|/'
    local charwidth=1
    ;;
  2)
    local spin="▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
    local charwidth=3
    ;;
  3)
    local spin="▉▊▋▌▍▎▏▎▍▌▋▊▉"
    local charwidth=3
    ;;
  4)
    local spin='←↖↑↗→↘↓↙'
    local charwidth=3
    ;;
  5)
    local spin='▖▘▝▗'
    local charwidth=3
    ;;
  6)
    local spin='┤┘┴└├┌┬┐'
    local charwidth=3
    ;;
  7)
    local spin='◢◣◤◥'
    local charwidth=3
    ;;
  8)
    local spin='◰◳◲◱'
    local charwidth=3
    ;;
  9)
    local spin='◴◷◶◵'
    local charwidth=3
    ;;
  10)
    local spin='◐◓◑◒'
    local charwidth=3
    ;;
  11)
    local spin='⣾⣽⣻⢿⡿⣟⣯⣷'
    local charwidth=3
    ;;
  12)
    local spin='▓▒░'
    local charwidth=3
    ;;
  esac

  local i=0
  printf "\x1b[?25l" # cursor invisible
  while kill -0 $pid 2>/dev/null; do
    local i=$(((i + $charwidth) % ${#spin}))
    printf "\b\033[33m%s" "${spin:$i:$charwidth}"
    tput sgr0 # reset colors

    sleep .1
  done
  printf "\x1b[?25h" # cursor visible
  wait $pid # capture exit code
  printf "\b"
  return $?
}

eval "$@" &

spinner $!
