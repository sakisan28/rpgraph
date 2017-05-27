#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

awk '
{
    if(old[1]>0){
        printf("%s ",$1);
        for(i=2;i<=NF;i++){
            printf("%d ",$i-old[i]);
        }
        printf("\n");
    }
    for(i=1;i<=NF;i++){
        old[i]=$i;
    }
}' $DATAFILERAW > $DATAFILEDIFF
