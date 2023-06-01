#! /bin/bash

case $# in
	0) true ;;
	1) true ;;
	*) 
		echo "we need either 0 or 1 argument"
		echo "either you provide 0 or 1 arguments."
		echo "in case of 0 arguments the network address will be provided autmatically."
		echo "in case of 1 argument you provide a network address such as: 200.200.200.0"
		exit 1
		;;
esac

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
)

echo "how many pieces?"
echo ${!dividers[@]}
read divider

case $divider in
	2|4|8|16|32|64|128) 
		divider=${dividers[$divider]}
		;;
	*) 
		echo "Error occured. Please use only suggested dividers."
		exit 1
		;;
esac
 
function collect(){
	for ip in {0..255}
	do
		key="${three}."$(( $ip & $divider))
		Networks[$key]+="${three}.$ip "	
	done
}
collect

function long_output(){
	local first=$1
	local members=( $( sed -r 's/[^ ]+$//' <<<${@:2} ) )
	local last=${@: -1}
	echo
	printf "%-22s %s\n" "base address:" "$first"
	printf "%-22s %s\n" "broadcast address:" "$last"
	printf "%-22s %s\n" "user addresses:" "${#members[@]}"
	echo "***************************************************************"
	echo ${members[*]} | sed -r 's/(([^ ]+ ){4})/\1\n/g'
}

function short_output(){
	local first=$1
	local members=( $( sed -r 's/[^ ]+$//' <<<${@:2} ) )
	local first_member=$members
	local last_member=${members[@]: -1}
	local last=${@: -1}
	echo
	printf "%-22s %s\n" "base address:" "$first"
	printf "%-22s %s\n" "broadcast address:" "$last"
	printf "%-22s %s\n" "user addresses:" "$first_member - $last_member" 
}

sorted_keys=$( sed 's/ /\n/g' <<<${!Networks[@]} | sort -n -k 4 -t "."  )

for key in $sorted_keys
do
	long_output ${Networks[$key]}
done

echo
echo "short notation/summary"
echo "***************************************************************"

for key in $sorted_keys
do
	short_output ${Networks[$key]}
done
