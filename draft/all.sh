cat *.txt > all
mv all all.txt
for file in all.txt;
do
  ### Sorting and removing duplicates
  sort $file | uniq > $file+2;
  cat $file+2 | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > $file;
  rm $file+2;
  ### Show all printed symbols in the files
  sed -e 's/\(.*\)/\L\1/' $file | grep -o '[[:print:]]' | sort | uniq
done
