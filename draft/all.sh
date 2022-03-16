regex_rus=$(tr '\n' '|' < rus.txt | sed 's/|$//g');
regex_dirty=$(tr '\n' '|' < dirty.txt | sed 's/|$//g');
for file in $(ls | grep '^[0-9]\+.txt.temp$');
do
  cp $file ${file/.temp/.clean};
done

for file in $(ls | grep '^[0-9]\+.txt.clean$');
do
  # Remove all but the following symbols and patterns
  sed -i -r '/^[АБВГӶДЕЖЗӠИКҚҞЛМНОПԤРСТҬУФХҲЦҴЧҶҼҾЏШЫҨ][аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ ,?-]*[…\.!?]$/I!d' $file
  sed -i -r '/'$regex_dirty'/d' $file;
  ### Remove sentences with most common Russian words
  sed -i -z -r '/\b('$regex_rus')\b/Id' $file;
  ### Remove more than 14 words and 10-90 characters.
  awk 'NF < 15' $file > $file.temp
  cp $file.temp $file
  sed -i -r '/^.{10,90}$/!d' $file;
  ### add the file name
  sed -i -r 's/^/'${file/.txt.clean/}'\t/g' $file;
  sed -i -r 's/^/'${file/.txt.clean/}'\t/g' ${file/.clean/.temp};
done

### Sorting and removing duplicates, clean text
cat $(ls | grep '^[0-9]\+.txt.temp$') > all.txt
cat $(ls | grep '^[0-9]\+.txt.clean$') > all.txt.clean
file="all.txt.clean"
cut -f2 $file | sed -e 's/[[:punct:]]//g' | sed 's/./\L&/g' | \
paste $file - > $file.temp;
sort -t$'\t' -k3 -u $file.temp | cut -f1,2 | shuf > $file;
file="all.txt"
cut -f2 $file | sed -e 's/[[:punct:]]//g' | sed 's/./\L&/g' | \
paste $file - > $file.temp;
sort -t$'\t' -k3 -u $file.temp | cut -f1,2 | shuf > $file;
### Dirty text
grep -F -x -v -f all.txt.clean all.txt | shuf > all.txt.dirty
### Ready text
batches="../астатистика/common-voice/batch1/batch1.92k.ab.txt"
grep -F -x -v -f $batches all.txt.clean > batch2.500k.ab.txt
# Remove all temp files
rm *.temp $(ls | grep '^[0-9]\+.txt.clean$')
