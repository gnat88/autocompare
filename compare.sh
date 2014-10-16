#! /bin/bash

# 删除历史文件
function init()
{
  if [ -d ~/Documents/diffhtml ]; then
    echo exist
  else
    `mkdir ~/Documents/diffhtml`
  fi
  if [ -d ~/Documents/diffbak ]; then
    echo exist
  else
    `mkdir ~/Documents/diffbak`
  fi

  ret=`ls ~/Documents/diffhtml|wc -l`
  if [ $ret != 0 ]; then
    rm -vf ~/Documents/diffhtml/*.*
  fi
}

# 打包备份
backup()
{
  strdate=`date +%Y%m%d%H%M`
  echo $strdate
  ret=`ls ~/Documents/diffhtml|wc -l`
  echo $ret
  if [ $ret != 0 ]; then
    c=`pwd`
    cd ~/Documents/diffhtml/
    tar -zcvf ~/Documents/diffbak/$strdate".gz" *.html
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
    vimdiff -e "$1" "$2" < /usr/local/bin/generate_diff_html.vim
    mv Diff.html ~/Documents/diffhtml/$3".html"
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

