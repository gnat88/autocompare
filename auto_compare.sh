#! /bin/bash
# $1-对比路径，$2-分支名称, $commit_id可选

source compare_config
if [ $# -lt 2 ]; then
  echo "para error!"
  exit
fi

cur=`pwd`
cmppath=$1
branch_a=$2


cd $CMPWORK1
# 新建分支
cur_branch=`git branch | grep "*"`
if [ "$cur_branch" == "* $branch_a" ]; then
  git checkout master
  git branch -D $branch_a
  git checkout -b $branch_a origin/$branch_a
fi

# 拉取更新
git pull origin $branch_a
if [ $# -ge 3 ]; then
  commitid_a=$3 
  git checkout $commitid_a
fi

# 比较
compare.sh $cur/$cmppath $CMPWORK1/$cmppath

