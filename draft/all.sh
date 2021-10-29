rm all.txt
cat *.txt.temp > all.txt
### Remove all sentences with capitals in between.
sed -i -e 's/\(^[[:alpha:]]\)/\L\1/' -e '/[[:upper:]]/d'  all.txt
sed -i -e 's/^\([[:alpha:]]\)/\U\1/' all.txt
### Sorting and removing duplicates
sed -e 's/[[:punct:]]//g' all.txt | paste all.txt - > all.txt.temp
sort all.txt.temp | uniq -f1 | cut -f1 > all.txt
sort all.txt | uniq > all.txt.temp;
cat all.txt.temp | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > all.txt;
### Remove more than 14 words and 50 characters.
awk 'NF < 15' all.txt > all.txt.temp
awk 'length($0)<90' all.txt.temp | awk 'length($0)>10' | shuf | \
# Remove all but the following symbols
grep -v -i '[^ !,-\.\?аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ]' | \
# Remove stuff like С а с р ы ҟ ә а
grep -v -i '[[:alpha:]] [[:alpha:]] ' | \
grep -v -i '^[^[:alpha:]]' > all.txt;
rm *.txt.temp;
### Show all printed symbols in the files
sed -e 's/\(.*\)/\L\1/' all.txt | grep -o '[[:print:]]' | sort | uniq
