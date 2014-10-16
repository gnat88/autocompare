#! /bin/bash

source compare_config
if [ $# != 3 ]; then
  echo "para error!"
  exit
fi

cur=`pwd`
cmppath=$1
branch_a=$2
commitid_a=$3

cd $CMPWORK1
git checkout master
git branch -D $branch_a
git checkout -b $branch_a origin/$branch_a
git pull origin $branch_a
git checkout $commitid_a


compare.sh $cur/$cmppath $adir/$cmppath

