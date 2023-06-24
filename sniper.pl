#! /usr/bin/perl

use strict ;
use warnings ;
use IO::Socket::INET ;

sub try_connect ;

my $target = shift ;
my @ports = @ARGV[0..$#ARGV] ;
my @opened ;
my @closed ;

for my $port ( @ports ) {
	try_connect $port , "\n" ;	
}

sub try_connect {
	my $port = shift ;
	my $sock = IO::Socket::INET -> new (
		Type => SOCK_STREAM,
		PeerAddr => $target,
		PeerPort => $port
	) ;
	if ( $sock ) {
		push @opened, $port ;	
		$sock->shutdown(0);
	} else {
		push @closed, $port ;
	}
}

for ( @opened ) {
	printf "%8d %s\n", $_, "open" ;
}
for ( @closed ) {
	printf "%8d %s\n", $_, "closed" ;
}

