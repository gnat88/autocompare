#! /bin/bash

# 设置对比路径
adir=/Users/tangwei/Documents/workspace/___gs_a
# b=/Users/tangwei/Documents/workspace/___gs_b

cur=`pwd`
cmppath=$1
branch_a=$2
commitid_a=$3

cd $adir
git checkout master
git branch -D $branch_a
git checkout -b $branch_a origin/$branch_a
git pull origin $branch_a
git checkout $commitid_a


compare.sh $cur/$cmppath $adir/$cmppath

