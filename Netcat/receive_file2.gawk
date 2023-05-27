#! /usr/bin/gawk -f

function read_file_name () {
	sender = "/inet/tcp/4000/0/0"
	sender |& getline filename 
	if ( filename )
		read_and_write()
	else {
		print "all files received!"
		exit 1
	}
}

function read_and_write () {
	while ( service |& getline )
		print >> filename
	stop_service()
}

BEGIN {
	while ( 1 ) 
		read_file_name()
}

function stop_service () {
	close( service )
	close( filename )
}
