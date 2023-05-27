#! /usr/bin/gawk -f

BEGIN {
	BINMODE = 3
	if ( host == "" ) {
		printf "please give me a hostname: "
		getline host < "/dev/stdin"
	}

	if ( port == "" ) {
	printf "please give me a port: "
	getline port < "/dev/stdin"
	}

}
BEGINFILE {
	server = "/inet4/tcp/0/" host "/" port
	#print FILENAME |& server
}

{	
	print |& server
}

END {
	close( server )
}
