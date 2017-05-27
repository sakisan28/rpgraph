#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

cat $APPDIR/header.html > $OUTPUTFILE

echo "          ['Time', 'Temp \'C']," >> $OUTPUTFILE

tail -n 150 $DATAFILERAW | awk '
{
  if($1=="utime") next;
  if(OFLAG!=0)
    printf(",\n");
  printf("          [new Date(%s",$1);
  printf("000),%s]",$36);
  OFLAG=1;
}
END{
  printf("\n        ]);\n");
}' >> $OUTPUTFILE

cat << EOF >> $OUTPUTFILE
        var options = {
          title: 'rp1 Temperature',
          hAxis: {title: 'Date/Time',  titleTextStyle: {color: '#333'}},
          vAxis: {ticks: [20,30,40,50,60,70,80,90]}
        };
EOF

cat $APPDIR/footer.html >> $OUTPUTFILE
