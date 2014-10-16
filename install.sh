#! /bin/bash
source compare_config

#set -x #echo on
C=`pwd`
ln -s $C/auto_compare.sh /usr/local/bin/auto_compare.sh
ln -s $C/compare.sh /usr/local/bin/compare.sh
ln -s $C/gen_report.vim /usr/local/bin/gen_report.vim
ln -s $C/compare_config /usr/local/bin/compare_config

if [ ! -d ~/Applications/autocompare ]; then
  mkdir $CMPHOME
  mkdir $CMPWORK1
  mkdir $CMPREPORT
  mkdir $CMPHTML
  mkdir $CMPBAK
fi

if [ $# = 1 ]; then
  git clone "$1" "$CMPWORK1"
fi



