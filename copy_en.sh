#!/bin/bash
FILES=$(find content/source -printf "%P\n" | grep .adoc)

for file in $FILES
do
  basepath=$(echo $file | sed "s|.adoc||")
  translated_adoc="$basepath.en.adoc"

  echo "Generating source/localizable/$translated_adoc from content/source/$basepath.adoc"
  cp content/source/$file source/localizable/$translated_adoc
done

FILES=$(find blog/source -printf "%P\n" | grep .adoc)

for file in $FILES
do
  basepath=$(echo $file | sed "s|.adoc||")
  translated_adoc="$basepath.en.adoc"

  echo "Generating source/$translated_adoc from blog/source/$basepath.adoc"
  cp blog/source/$file source/$translated_adoc
done
