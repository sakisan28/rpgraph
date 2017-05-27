#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

cat $APPDIR/header.html > $OUTPUTFILE

echo "          ['Time','read', 'write']," >> $OUTPUTFILE

tail -n 150 $DATAFILEDIFF | awk '
{
  if(NR>1)
    printf(",\n");
  printf("          [new Date(%s",$1);
  printf("000),%d,%d]",$30,$31);
}
END{
  printf("\n        ]);\n");
}' >> $OUTPUTFILE

cat << EOF >> $OUTPUTFILE
        var options = {
          title: 'rp1 mmcblk0 read/write',
          hAxis: {title: 'Date/Time',  titleTextStyle: {color: '#333'}},
          vAxis: {minValue: 0}
        };
EOF

cat $APPDIR/footer.html >> $OUTPUTFILE
