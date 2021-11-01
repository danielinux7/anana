rm all.txt all.txt.temp
cat *.txt.temp > all.txt
### Remove all sentences with capitals in between.
sed -i -e 's/\(^[[:alpha:]]\)/\L\1/' -e '/[[:upper:]]/d'  all.txt
sed -i -e 's/^\([[:alpha:]]\)/\U\1/' all.txt
### Sorting and removing duplicates
sed -e 's/[[:punct:]]//g' all.txt | paste all.txt - > all.txt.temp
sort all.txt.temp | uniq -f1 | cut -f1 > all.txt
# Remove all but the following symbols
grep -v -i '[^ !,-\.\?аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ]' all.txt | \
# Remove stuff like С а с р ы ҟ ә а
grep -v -i '[[:alpha:]] [[:alpha:]] ' | \
grep -v -i '^[^[:alpha:]]' > all.txt.temp;
cp  all.txt.temp  all.txt;
# Remove and clean up sentences with .. ...
grep -v '[^\.]\.\.' all.txt.temp > all.txt
grep '[^\.]\.\.' all.txt.temp | \
grep '\(н\|т\|м\|п\|зеи\|уеи\|ама\|ома\|ума\|зма\|ои\|ми\|зи\)[ \.?!,]' >> all.txt
sed -i -r 's/(зеи|уеи|ама|ома|ума|зма|ои|ми|зи)[\.]+\./\1?/g' all.txt
sed -i -r 's/[\.]+\.$/./g' all.txt
### Remove more than 14 words and 10-90 characters.
awk 'NF < 15' all.txt > all.txt.temp
awk 'length($0)<90' all.txt.temp | awk 'length($0)>10' | shuf > all.txt
rm *.txt.temp;
