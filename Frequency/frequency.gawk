#! /usr/bin/gawk -f

BEGIN {
	time = "date +%s.%N"
}

{
	time | getline
	timecapsule[t_counter++] = $0 
	print $0, "\t", calculate_times( timecapsule )
	close( time ) 
}

function calculate_times ( t_array ) {
	sum = 0
	for ( ti = 0 ; ti < length( t_array) - 1 && length(t_array) > 1 ; ti++ ) {
		sum += t_array[ti+1] - t_array[ti]
	} 
	if ( length( t_array ) > 1 )
		return sum / length( t_array )
	else
		0
}


END {
	print "\n############################################"
	print "result: " calculate_times( timecapsule )
	print "############################################\n"
}
