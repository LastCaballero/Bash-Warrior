#! /usr/bin/gawk -f

BEGIN {
	dateiprefix = "datei"
	idx = 1
	server = "/inet/tcp/4000/0/0"
	while ( 1 ) {
		dateiname = dateiprefix""idx
		while ( ( server |& getline ) > 0 ) {
			print >> dateiname 
		}
		extensioncmd = "file --extension " dateiname " | cut -f 2 -d \" \" | cut -f 1 -d \"/\" " 
		extensioncmd | getline extension
		close(extensioncmd)
		renamecmd = "mv " dateiname " " dateiname "." extension
		renamecmd | getline success
		close(renamecmd)
		idx++
	}
}
