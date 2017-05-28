#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

cat $APPDIR/header.html > $OUTPUTFILE

echo "          ['Time','use', 'avail']," >> $OUTPUTFILE

tail -n 150 $DATAFILERAW | awk '
{
  if($1=="utime") next;
  if(OFLAG!=0)
    printf(",\n");
  printf("          [new Date(%s",$1);
  printf("000),%d,%d]",$28,$27-$28);
  OFLAG=1;
}
END{
  printf("\n        ]);\n");
}' >> $OUTPUTFILE

cat << EOF >> $OUTPUTFILE
        var options = {
          isStacked: true,
          title: '`hostname` /boot usage',
          hAxis: {title: 'Date/Time',  titleTextStyle: {color: '#333'}},
          vAxis: {}
        };
EOF

cat $APPDIR/footer.html >> $OUTPUTFILE
