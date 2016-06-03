#!/bin/sh

while read LINE
do
  if [[ ! "$LINE" =~ ^# ]]; then
    NU=`echo ${LINE} |awk '{print $1;}'`
    RE=`echo ${LINE} |awk '{print $2;}'`
    CASE="Re`printf %05d $RE`"
    NEWCASE="cavity$CASE"
    foamCloneCase cavityRe00100 $NEWCASE
    cp cavityRe00100/Allrun $NEWCASE/
    cd $NEWCASE
    sed -i constant/transportProperties -e "s/0.01/$NU/"
#    ./Allrun
    cd ..
  fi
done < condition.dat
