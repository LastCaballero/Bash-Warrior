#! /usr/bin/gawk -f

BEGIN {
    ext_cmd = "file --extension "file" | cut -f 2 -d \" \" | cut -f 1 -d \"/\""
	service = "/inet/tcp/4000/0/0"
	fileprefix = "datei"
	number = 1

	while ( 1 ) {
		file = fileprefix number
		while ( service |& getline ) {
			print >> file 
		}

		getExtension( file ) | getline extension
		close( getExtension( file ) )
 
		system( rename_cmd( extension ) )
		
        number++
		
        close(service)
	}
}

function getExtension ( file ) {
    return "file --extension "file" | cut -f 2 -d \" \" | cut -f 1 -d \"/\""
}

function rename_cmd ( extension ) {
    return "mv " file " " file "." extension
}