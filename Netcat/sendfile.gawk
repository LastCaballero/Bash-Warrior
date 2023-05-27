#! /usr/bin/gawk -f
BEGIN {
        service = "/inet4/tcp/0/localhost/4000"
        while ( getline < "file.jpg" )
                print |& service
}
