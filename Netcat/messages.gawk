#! /usr/bin/gawk -f

BEGIN {
	server = "/inet/tcp/4000/0/0"
	while ( ( server |& getline netcatmsg ) > 0 ) {
		print netcatmsg
		getline message < "/dev/stdin"
		print message |& server
	}
	close(server)
}
