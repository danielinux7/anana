for file in 11.txt;
do
  ### Cleaning
  sed -i -e '/^$/d' $file;
  sed -i -e '/^[0-9]*$/d' $file;
  sed -i -e 's/−/–/g' $file;
  sed -i -r 's/^[0-9]*([[:alpha:][:punct:]])/\1/g' $file;
  sed -i -r 's/–([[:graph:]])/– \1/g' $file;
  sed -i -r 's/([[:graph:]])–/\1 –/g' $file;
  ### Splitting
  sed -i -z 's/\xCC\x81//g' $file;
  sed -i -z 's/\x0C//g' $file;
  sed -i -z 's/\xC2\xAD\n//g' $file;
  sed -i -r 's/[-_—]\n//g' $file;
  sed -i -z 's/\n/ /g' $file;
  sed -i -r 's/([:!?]) /\1\n/g' $file;
  sed -i -e 's/\.\.\. /...\n/g' -e 's/\.\. /..\n/g' -e 's/\.\.\.» /...»\n/g' -e 's/\.\.» /..»\n/g' $file;
  sed -i -r 's/([[:alpha:]][[:alpha:]][[:alpha:]]\.) /\1\n/g' $file;
  sed -i -r 's/([[:alpha:]][[:alpha:]][[:alpha:]]\.\)) /\1\n/g' $file;
  sed -i -r 's/([[:alpha:]][[:alpha:]][[:alpha:]]»\.\)) /\1\n/g' $file;
  sed -i -r 's/([?!»\)]\.) /\1\n/g' $file;
  sed -i -r 's/ –/\n–/g' $file;
  ### Cleaning
  sed -i -e 's/;/,/g' -e 's/:/./g' -e 's/“/«/g' -e 's/”/»/g' -e 's/ҕ/ӷ/g' -e 's/Ҕ/Ӷ/g' \
  -e 's/\xC2\xAD//g' -e 's/ҧ/ԥ/g' -e 's/Ҧ/Ԥ/g' -e 's/\*//g' -e 's/^– //g' -e 's/,$/./g' \
  -e 's/[«»\(\)]//g' -e 's/— //g' -e 's/…/.../g' -e 's/№//g' -e 's/_//g' -e 's/—//g' $file;
  sed -i -r 's/([[:alpha:]])$/\1./g' $file;
  sed -i -r 's/[ ]+/ /g' $file;
  sed -i -r 's/^[ ]+//g' $file;
  sed -i -r 's/^([[:alpha:]])/\U\1/g' $file;
  sed -i -e 's/^\.\.\.//g' $file
  sed -i -r 's/[\.]+$/./g' $file
  sed -i -e '/^[[:punct:] ]*$/d' $file;
  ### Sorting and removing duplicates
  sort $file | uniq > $file+2;
  cat $file+2 | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > $file;
  rm $file+2;
  ## here is more work needed.
  ##split -l 500 -d $file ${file/.txt//}
  ### Show all printed symbols in the files
  sed -e 's/\(.*\)/\L\1/' $file | grep -o '[[:print:]]' | sort | uniq
done
