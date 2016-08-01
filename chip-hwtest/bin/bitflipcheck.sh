#!/bin/bash

export PATH=$PATH:/usr/bin:/usr/sbin

DEV=${1:-/dev/mtd2}

#nanddump -f /tmp/mdttmp ${DEV} 2>&1 | tee /tmp/awktmp
/usr/sbin/nanddump -f /tmp/mdttmp ${DEV} > /tmp/awktmp 2>&1 

gawk '\
BEGIN {\
  np_co=co=co2=co_max=0;\
  np_uc=uc=uc2=uc_max=0;\
}\
\
$3 == "corrected" {\
 co += $2; \
 co2 += $2 * $2; \
 np_co++;
 if($2>co_max) co_max=$2;
}\
\
$3 == "uncorrectable" {\
 uc += $2; \
}\
\
END {\
  co_mean=co/np_co; \
  co_rms =sqrt(co2/np_co - (co_mean*co_mean));
  print systime(),temp,co,co_mean,co_rms,co_max,uc; \
\
}\
' temp=0 </tmp/awktmp
