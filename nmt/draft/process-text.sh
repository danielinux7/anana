# Manual cleanup
# [_—−–]$ and [_]
# [ёйщъэяю]
# 4: Chane Alpha to ALPHA for misplaced single words in a line.
rm *.txt
alpha="аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ"
for file in $(ls | grep '^[0-9]\+.tsv$');
do
  sed -r 's/\t.*//' $file > ${file/.tsv/}.ab.txt
  sed -r 's/.*\t//' $file > ${file/.tsv/}.ru.txt
done

for file in $(ls | grep '^[0-9]\+.ab.txt$')
do
  ### preprocess
  sed -ni '/['$alpha']/p' $file;
  sed -i -r 's/([[:alpha:]])[,]*$/\1…/g' $file;
  # 4
  sed -i -r '/^[АӘБВГӶДЕЖЗӠИКҚҞЛМНОПԤРСТҬУФХҲЦҴЧҶҼҾЏШЫЬҨ ]+$/d' $file;
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
  sed -i -e 's/[«»"“”\(\)\*№]//g' $file;
  sed -i -r 's/([[:alpha:]])–([[:alpha:]])/\1-\2/g' $file;
  ### Splitting
  sed -i -z 's/[-]\n//g' $file;
  # 1
  sed -i -z 's/\n/ /g' $file;
  sed -i -r 's/([?!…][!]*)|–[ ]*([[:upper:]])/\1\n\2/g' $file;
  sed -i -r 's/([[:alpha:]]{3,}\.)/\1\n/g' $file;
  ### postprocess
  # 2
  sed -i -r 's/–/ /g' $file;
  sed -i -r 's/,[ ]*\b([аисршлҳ]ҳә[аое][и]*[нтп])\b/, – \1/g' $file;
  # 3
  sed -i -r 's/^.*[0-9]+[ ,]*([[:upper:]])/\1/g' $file;
  #
  sed -i -r 's/^[ ]+|[ ]+$//g' $file;
  sed -i -r 's/([[:alpha:]])[,]*$/\1…/g' $file;
  sed -i -r 's/[ ]+/ /g' $file;
  sed -i -r 's/^(['$alpha'])/\U\1/' $file
done

alpha2="ёйцукенгшщзхъфывапролджэячсмитьбю"
for file in $(ls | grep '^[0-9]\+.ru.txt$')
do
  ### preprocess
  sed -ni '/['$alpha2']/p' $file;
  sed -i -r 's/([[:alpha:]])[,]*$/\1…/g' $file;
  # 4
  sed -i -r '/^[ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ ]+$/d' $file;
  sed -i -r 's/\xE2\x80\x89/ /g' $file;
  sed -i -z 's/\xCC\x81//g' $file;
  sed -i -z 's/\x0C//g' $file;
  sed -i -z 's/\xC2\xAD[\n]*//g' $file;
  sed -i -e 's/[:;]/…/g' $file;
  sed -i -r 's/[\.]{2,3}/…/g' $file;
  sed -i -r 's/[,]+/,/g' $file;
  sed -i -r 's/[!]+/!/g' $file;
  sed -i -r 's/[?]+/?/g' $file;
  sed -i -r 's/,([[:alpha:]])/, \1/g' $file;
  sed -i -r 's/([!?])[,\.]+/\1/g' $file;
  sed -i -r 's/ ([…,!?\.])/\1/g' $file;
  sed -i -e 's/- / /g' -e 's/ - / /g' $file;
  sed -i -e 's/[«»"“”\(\)\*№]//g' $file;
  sed -i -r 's/([[:alpha:]])–([[:alpha:]])/\1-\2/g' $file;
  ### Splitting
  sed -i -z 's/[-]\n//g' $file;
  # 1
  sed -i -z 's/\n/ /g' $file;
  sed -i -r 's/([?!…][!]*)|–[ ]*([[:upper:]])/\1\n\2/g' $file;
  sed -i -r 's/([[:alpha:]]{3,}\.)/\1\n/g' $file;
  ### postprocess
  # 2
  sed -i -r 's/–/ /g' $file;
  # 3
  sed -i -r 's/^.*[0-9]+[ ,]*([[:upper:]])/\1/g' $file;
  #
  sed -i -r 's/^[ ]+|[ ]+$//g' $file;
  sed -i -r 's/([[:alpha:]])[,]*$/\1…/g' $file;
  sed -i -r 's/[ ]+/ /g' $file;
  sed -i -r 's/^(['$alpha2'])/\U\1/' $file
done
