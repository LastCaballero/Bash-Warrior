#! /bin/bash
reg_for_ip='([0-9]{1,3}\.){3}[0-9]{1,3}'

case $# in
	0) true ;;
	1) 
		grep -E -q $reg_for_ip <<<$1 ||
		{ 
			echo "not a regular ip or network address. An ip is something like that: 200.200.200.0"
			exit 1
		}
		;;
	*) 
		echo "Too much arguments provided. Only 1 will be used."
		;;
esac

declare -A Networks

HOMENET=$( ip route show | grep "/24" | gawk -F "( |/)+" '{ print $2}' )

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
