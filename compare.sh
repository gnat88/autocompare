#! /bin/bash

source compare_config
# 删除历史文件
function init()
{
  if [ -d $CMPHTML ]; then
    echo exist
  else
    mkdir $CMPHTML
  fi
  if [ -d $CMPBAK ]; then
    echo exist
  else
    mkdir $CMPBAK
  fi

  ret=`ls $CMPHTML|wc -l`
  if [ $ret != 0 ]; then
    rm -vf $CMPHTML"/*.*"
  fi
}

# 打包备份
backup()
{
  strdate=`date +%Y%m%d%H%M`
  echo $strdate
  ret=`ls $CMPHTML|wc -l`
  echo $ret
  if [ $ret != 0 ]; then
    c=`pwd`
    cd $CMPHTML
    tar -zcvf $CMPBAK"/"$strdate".gz" *.html
    cd $c
  fi

}

# 比较文件差异
function compare_file()
{
  if cmp -s $1 $2
  then
    echo "same"
  else
    echo compare $1,$2
    vimdiff -e "$1" "$2" < /usr/local/bin/gen_report.vim
    mv Diff.html $CMPHTML"/"$3".html"
  fi
}

compare_path()
{
  list=`ls $1`
  curdir=`pwd`
  for f in $list
  do
    file1="$1/$f"
    file2="$2/$f"
    if [ ! -d $file1 ]; then
      echo $file1
      compare_file $file1 $file2 $f
    else
      compare_path $file1 $file2
    fi
  done
}


# $1 $2 分别表示两个对比的路径
echo "Generate diff html file begin !"
echo $1 $2
init
if [ ! -d $1 ]; then
  compare_file $1 $2 "compare_diff"
else
  compare_path $1 $2
fi
  backup
echo "Generate diff html file done !"

