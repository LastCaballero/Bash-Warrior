#! /bin/bash

declare -A Networks

HOMENET=$(
	ip route show |
	sed -n '/default/,+1p' | 
	gawk 'FNR == 2 { print $2}' |
	sed -r 's/\/.+$//'
)

NWA=${1:-$HOMENET}
octets=( $(echo $NWA | tr "." " ") )
if [[ ${#octets[@]} != 4 ]]; then
	echo "an ip-address has 4 octets"
	echo "for example: 200.200.200.1"
	
fi
three=$(sed 's/ /./g' <<<${octets[*]:0:3})


dividers=( 
	[2]=$(( 2#10000000 ))
	[4]=$(( 2#11000000 ))
	[8]=$(( 2#11100000 ))
	[16]=$(( 2#11110000 ))
	[32]=$(( 2#11111000 ))
	[64]=$(( 2#11111100 ))
	[128]=$(( 2#11111110 )) 
)

echo "how many pieces?"
echo ${!dividers[@]}
read divider
divider=${dividers[$divider]} 

for ip in {1..255}
do
	key="${three}."$(( $ip & $divider))
	Networks[$key]+="${three}.$ip "	
done

for key in $( sed 's/ /\n/g' <<<${!Networks[@]} | sort -n -k 4 -t "."  )
do
	echo
	echo $key
	echo "*********************************************"
	echo ${Networks[$key]} 
done
