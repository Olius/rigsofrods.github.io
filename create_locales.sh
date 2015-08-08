#!/bin/bash
NEW_LINGUAS=$1
FOLDERS=$2

for lang in $NEW_LINGUAS
do
  for folder in $FOLDERS
  do
    mkdir $folder/po/$lang
    echo ""
    cp -r $folder/pot/* $folder/po/$lang
    
    FILES=$(find $folder/po/$lang -printf "%P\n" | grep .pot)
    for file in $FILES
    do
      basepath=$(echo $file | sed "s|.pot||")
      echo "Moving file $basepath.pot to $basepath.po"
      mv $folder/po/$lang/$basepath.pot $folder/po/$lang/$basepath.po
    done
  done
done
