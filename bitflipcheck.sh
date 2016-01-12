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
#  print "total",co,"corrected bitflips, mean:",co_mean,"rms:",co_rms,"max:",co_max; \
#  print "total",uc,"uncorrectable bitflips"; \
  print systime(),temp,co,co_mean,co_rms,co_max,uc; \
  printf "{ \"time\":        \"%d\",\n\
  \"temp\":        \"%f\",\n\
  \"corrected\":   \"%d\",\n\
  \"mean\":        \"%f\",\n\
  \"rms\":         \"%f\",\n\
  \"max\":         \"%d\",\n\
  \"uncorrected\": \"%d\" \n\
}\n\n",systime(),temp,co,co_mean,co_rms,co_max,uc >"/root/bitflipcheck_last.json"; \
}\
' temp=$(/usr/sbin/axp209 --temperature | cut -d\  -f1) </tmp/awktmp
