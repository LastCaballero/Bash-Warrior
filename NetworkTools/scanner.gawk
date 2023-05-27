#! /usr/bin/gawk -f

BEGIN {
	target = ARGV[1] == "" ? "127.0.0.1" : ARGV[1]
	FS="\t+| +|/"
	get_ports()
	scan_ports()
}

function get_ports () {
	file="grep -E \"^[^#]\" /etc/services"
	idx = 1
	while ( (file | getline) )
		services[idx++] = $1 " " $2 " " $3
}
function scan_ports () {
	for ( i = 0 ; i < length(services); i++ ) {
		split(services[i], parts)
		port = parts[2]
		protocoll = parts[3]
		nc_udp = protocoll == "udp" ? "-u " : ""
		command = "netcat -z " nc_udp target " " port
		print "processing " port " ..."
		result = system( command )
		if ( result == 0 )
			print "Port " port " accessible"
		else
			print "Port " port " not accessible"
	}
}




