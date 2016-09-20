export PATH=$PATH:$HOME/linux-configs/bin
export PYTHONSTARTUP=$HOME/linux-configs/python_startup.py


# Copies text to the X11 clip board:
copy() {
  xclip -sel clip
}

# Convienient little awk scripts:
function sumn() {
  awk '{s+=$1}END{print s}'
}

function counts() {
  awk '{x[$0]+=1;} END{for (i in x) {print x[i], i}}' | sort -r -n
}
