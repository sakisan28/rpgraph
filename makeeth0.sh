#!/bin/bash

cd `dirname $0` || exit 1
. rpgraph.conf

cat $APPDIR/header.html > $OUTPUTFILE

echo "          ['Time','Rx', 'Tx']," >> $OUTPUTFILE

tail -n 150 $DATAFILEDIFF | awk '
{
  if(NR>1)
    printf(",\n");
  printf("          [new Date(%s",$1);
  printf("000),%d,%d]",$10,$11);
}
END{
  printf("\n        ]);\n");
}' >> $OUTPUTFILE

cat << EOF >> $OUTPUTFILE
        var options = {
          title: '`hostname` eth0 usage',
          hAxis: {title: 'Date/Time',  titleTextStyle: {color: '#333'}},
          vAxis: {}
        };
EOF

cat $APPDIR/footer.html >> $OUTPUTFILE
