#!/usr/bin/gawk -f

BEGIN {
 limit=100;
 rms_limit=100;
 n=0.0;

 # we looking at the max number of bitflips observed
 column=6;
 avg_max=0.0;
 rms_max=0.0;
 min_max=2^53-1;
 max_max=-2^53-1;

 # we also watch out for uncorrectable bitflips
 uc=0;
}

{
 if($column>max_max) { max_max=$column; }
 if($column<min_max) { min_max=$column; }
 avg_max += $column;
 rms_max += $column * $column;
 n++;

 uc += $7;
}

END {
 if(n>0) {
   avg_max /= n;
   rms_max /= n;
 }
 rms_max = sqrt( rms_max-(avg_max*avg_max) );

 if((uc>0) || (avg_max>limit) || (rms_max>rms_limit))
 {
	exit 1;
 }
}
