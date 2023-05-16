#/bin/bash

codes=(
	[ $(( 2#00001 )) ]="wink"
	[ $(( 2#00010 )) ]="double blink"
	[ $(( 2#00100 )) ]="close your eyes"
	[ $(( 2#01000 )) ]="jump"
	[ $(( 2#10000 )) ]="reverse"
)

get_actions(){
	local secret=$1
	local -a actions
	for action in ${!codes[@]}
	do
		actions+=( ${codes[$(($action & $1))]}  )
	done
	echo ${actions[@]}
}

get_actions 5


