csplit -sk gnome.txt '/po header/' {*} -f ""
rm 00
for file in $(ls | grep '^[0-9]*$'); 
do 
 echo $file
 sed '1i location\tsource\ttarget' $file > ${file}.tsv
 tsv2csv ${file}.tsv > ${file}.csv
 csv2po ${file}.csv > ${file}.po
done
sed -i -r 's/newline/\\n"\n"/g' *.po
sed -i -z -r 's/1"\n".0/1.0/' *.po 
sed -i -z -r 's/;\\n"\n""/;\\n"/' *.po
sed -i -z -r 's/Transfer-"\n"Encoding/Transfer-Encoding/' *.po
sed -i -z -r 's/.*msgid "po header"/msgid ""/' *.po
sed -i -r 's/"msgid_plural: /msgid_plural "/g' *.po
sed -i -z -r 's/msgstr ""\n"msgstr\[0\]: /msgstr\[0\] "/g' *.po
sed -i -r 's/"msgstr\[1\]: /msgstr\[1\] "/g' *.po
sed -i -r '/msgstr\[2\]:/d' *.po
rm *.tsv *.csv *[0-9]
grep 'msgstr\[0\]' *.po
