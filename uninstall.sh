#! /bin/bash
echo "enter yes to unistall > "
read input
if [ $input != "yes" ]; then
  echo "abort"
  exit
fi

source compare_config

C=`pwd`
rm -f /usr/local/bin/auto_compare.sh
rm -f /usr/local/bin/compare.sh
rm -f /usr/local/bin/gen_report.vim
rm -f /usr/local/bin/compare_config

rm -rf $CMPHOME
rm -rf $CMPWORK1
rm -rf $CMPREPORT
rm -rf $CMPHTML
rm -rf $CMPBAK

echo done
