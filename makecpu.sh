#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

cat $APPDIR/header.html > $OUTPUTFILE

echo "          ['Time', 'CPU load']," >> $OUTPUTFILE

tail -n 150 $DATAFILEDIFF | awk '
{
  if(NR>1)
    printf(",\n");
  printf("          [new Date(%s",$1);
  printf("000),%d]",(($3+$4+$5) != 0) ? ($3+$4)*100/($3+$4+$5) : 0);
}
END{
  printf("\n        ]);\n");
}' >> $OUTPUTFILE

cat << EOF >> $OUTPUTFILE
        var options = {
          title: '`hostname` CPU load',
          hAxis: {title: 'Date/Time',  titleTextStyle: {color: '#333'}},
          vAxis: {ticks: [0,25,50,75,100]}
        };
EOF

cat $APPDIR/footer.html >> $OUTPUTFILE
