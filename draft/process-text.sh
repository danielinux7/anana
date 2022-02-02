# [ёйяъюэщЁЙЯЪЮЭЩa-zA-Z]
alpha="аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ"
for file in $(ls | grep '^[0-9]\+.txt$');
do
  cp $file $file.temp;
done

for file in $(ls | grep '^[0-9]\+.txt.temp$')
do
  ### preprocess
  sed -ni '/['$alpha']/p' $file;
  sed -i -r 's/\xE2\x80\x89/ /g' $file;
  sed -i -z 's/\xCC\x81//g' $file;
  sed -i -z 's/\x0C//g' $file;
  sed -i -z 's/\xC2\xAD[\n]*//g' $file;
  sed -i -e 's/[:;]/…/g' -e 's/ҕ/ӷ/g' -e 's/Ҕ/Ӷ/g' -e 's/ҧ/ԥ/g' -e 's/Ҧ/Ԥ/g' $file;
  sed -i -r 's/[\.]{2,3}/…/g' $file;
  sed -i -r 's/[,]+/,/g' $file;
  sed -i -r 's/[!]+/!/g' $file;
  sed -i -r 's/[?]+/?/g' $file;
  sed -i -r 's/,([[:alpha:]])/, \1/g' $file;
  sed -i -r 's/([!?])[,\.]+/\1/g' $file;
  sed -i -r 's/ ([…,!?\.])/\1/g' $file;
  sed -i -e 's/- / /g' -e 's/ - / /g' $file;
  sed -i -e 's/[«»“”\(\)\*№]//g' $file;
  ### Splitting
  sed -i -z 's/[-_—−]\n//g' $file;
  sed -i -z 's/\n/ /g' $file;
  sed -i -r 's/([?!…])[\. ]/\1\n/g' $file;
  sed -i -r 's/([[:alpha:]]{3,}\.)/\1\n/g' $file;
  sed -i -r 's/[ ]–[ ]/\n/g' $file;
  sed -i -e 's/[—_–]//g' $file;
  ### postprocess
  sed -i -r 's/([[:alpha:]])[,]*$/\1…/g' $file;
  sed -i -r 's/[ ]+/ /g' $file;
  sed -i -r 's/^[ ]+//g' $file;
  sed -i -r 's/^(['$alpha'])/\U\1/' $file
  ### Sorting and removing duplicates
  sort $file | uniq > $file+2;
  cat $file+2 | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > $file;
  rm $file+2;
done
