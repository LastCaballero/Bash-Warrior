# if nmap doesn´t work in your wsl, install it at windows side
# the windows exectuable runs also ata wsl side
alias nmap="nmap.exe"

# some useful environment variables
export HOMENETWORK=$(ip route show | grep "/24" | cut -f 2 -d " ")
export GATEWAY=$(ip route show | grep default | cut -f 4 -d " ")
export MYIP=$( ip addr show | grep "/24" | sed -r 's/ +//;s/\/24//' | cut -f 2 -d " " )
