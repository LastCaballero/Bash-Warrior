#! /usr/bin/gawk -f

BEGIN {

        service = "/inet/tcp/4000/0/0"
        while ( service |& getline )
                print >> "file.jpg"
}
