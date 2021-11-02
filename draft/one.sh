for file in *.txt.temp;
do
  cp $file $file.clean
  ### Remove all sentences with capitals in between.
  sed -i -e 's/\(^[[:alpha:]]\)/\L\1/' -e '/[[:upper:]]/d'  $file.clean
  sed -i -e 's/^\([[:alpha:]]\)/\U\1/' $file.clean
  ### Sorting and removing duplicates
  sed -e 's/[[:punct:]]//g' $file.clean | paste $file.clean - > $file.clean.temp
  sort $file.clean.temp | uniq -f1 | cut -f1 > $file.clean
  # Remove all but the following symbols
  grep -v -i '[^ !,-\.\?аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ]' $file.clean | \
  # Remove stuff like С а с р ы ҟ ә а
  grep -v -i '[[:alpha:]] [[:alpha:]] ' | \
  grep -v -i '^[^[:alpha:]]' > $file.clean.temp;
  cp  $file.clean.temp  $file.clean;
  # Remove and clean up sentences with .. ...
  grep -v '[^\.]\.\.' $file.clean.temp > $file.clean
  grep '[^\.]\.\.' $file.clean.temp | \
  grep '\(н\|т\|м\|п\|зеи\|уеи\|ама\|ома\|ума\|зма\|ои\|ми\|зи\)[ \.?!,]' >> $file.clean
  ### Remove more than 14 words and 10-90 characters.
  awk 'NF < 15' $file.clean > $file.clean.temp
  awk 'length($0)<90' $file.clean.temp | awk 'length($0)>10' | shuf > $file.clean
  cat $file $file.clean > $file.temp
  sed -i -e 's/^\([[:alpha:]]\)/\U\1/' $file.temp
  sed -e 's/[[:punct:]]//g' $file.temp | paste $file.temp - | \
  sort | uniq -f1 -u | cut -f1 > $file.dirty
  sed -i -r 's/(зеи|уеи|ама|ома|ума|зма|ои|ми|зи)[\.]+\./\1?/g' $file.clean
  sed -i -r 's/[\.]+\.$/./g' $file.clean
  sed -e 's/[[:punct:]]//g' $file.clean | paste $file.clean - > $file.clean.temp
  sort $file.clean.temp | uniq -f1 | cut -f1 > $file.clean
  rm $file.clean.temp $file.temp
done
