#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

sleep 5s

OUTPUTFILE=$OUTPUTDIR/chartcpu.html ./makecpu.sh
OUTPUTFILE=$OUTPUTDIR/chartmem.html ./makemem.sh
OUTPUTFILE=$OUTPUTDIR/chartswap.html ./makeswap.sh
OUTPUTFILE=$OUTPUTDIR/charttemp.html ./maketemp.sh
OUTPUTFILE=$OUTPUTDIR/charteth0.html ./makeeth0.sh
OUTPUTFILE=$OUTPUTDIR/chartwlan0.html ./makewlan0.sh
OUTPUTFILE=$OUTPUTDIR/chartlo.html ./makelo.sh
OUTPUTFILE=$OUTPUTDIR/chartroot.html ./makeroot.sh
OUTPUTFILE=$OUTPUTDIR/chartboot.html ./makeboot.sh
OUTPUTFILE=$OUTPUTDIR/chartmmc.html ./makemmc.sh
OUTPUTFILE=$OUTPUTDIR/chartsda.html ./makesda.sh

