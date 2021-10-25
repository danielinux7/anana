rm all.txt
cat *.txt > all.txt
for file in all.txt;
do
  ### Remove all sentences with capitals in between.
  sed -i -e 's/\(^[[:alpha:]]\)/\L\1/' -e '/[[:upper:]]/d'  $file
  sed -i -e 's/^\([[:alpha:]]\)/\U\1/' $file
  ### Sorting and removing duplicates
  sed -e 's/[[:punct:]]//g' $file | paste $file - > $file+2
  sort $file+2 | uniq -f1 | cut -f1 > $file
  sort $file | uniq > $file+2;
  cat $file+2 | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > $file;
  ### Remove more than 14 words and 50 characters.
  awk 'NF < 15' $file > $file+2
  awk 'length($0)<80' $file+2 | awk 'length($0)>10' | shuf > $file
  rm $file+2;
  ### Show all printed symbols in the files
  # sed -e 's/\(.*\)/\L\1/' $file | grep -o '[[:print:]]' | sort | uniq
done
