#! /bin/bash

declare -A Networks

NWA=$1
oct=$(echo $NWA | sed -r 's/[0-9]{1,3}$//')
MASK=$2

echo $oct

binary=( 
	$(( 2#10000000 ))
	$(( 2#11000000 ))
	$(( 2#11100000 ))
	$(( 2#11110000 ))
	$(( 2#11111000 ))
	$(( 2#11111100 ))
	$(( 2#11111110 )) 
)

declare_pieces(){
	declare -g pieces=$1
}

select_pieces(){
	select piece in "2 pieces" "4 pieces" "6 pieces" "8 pieces" "16 pieces" "32 pieces" "64 pieces" "128 pieces"
		do
			case $(grep -Eo "[0-9]+" <<<$piece) in
				2) 		declare_pieces ${binary[0]}; break ;;
				4) 		declare_pieces ${binary[1]}; break ;;
				8) 		declare_pieces ${binary[2]}; break ;;
				16) 	declare_pieces ${binary[3]}; break ;;
				32) 	declare_pieces ${binary[4]}; break ;;
				64) 	declare_pieces ${binary[5]}; break ;;
				128) 	declare_pieces ${binary[6]}; break ;;
			esac ;
		break
	done
}


calculate(){
	for num in {1..255}
	do
		key=$((pieces & num))
		Networks[$key]+="${oct}${num} "
	done
}

select_pieces
calculate

for key in ${!Networks[@]}
do
	echo "Nethwork: ${oct}${key}:"
	echo "****************************"
	echo "${Networks[$key]}"
done

