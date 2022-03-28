sed -r 's/[^[:print:]\t]//g' [0-9]*.tsv.temp|cat - > all.tsv.temp;
cp  all.tsv.temp  all.tsv.clean.temp
file="all.tsv.clean.temp"
# Remove all but the following symbols and patterns
sed -i -r '/^[0-9+-]*\t[аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ ,?–-]*[…\.!?]\t[ёйцукенгшщзхъфывапролджэячсмитьбю ,?–-]*[…\.!?]\t0$/I!d' $file;
sed -i -r '/\tҲәа[н, ]|\t[АИСРШЛҲ]ҳә[аое]|[[:alpha:]]-[[:alpha:]]+-[[:alpha:]]|\b[[:alpha:]]\b|[[:upper:]][[:upper:]]/d' $file;
### Replace more or less than 10-90 characters.
sed -i -r '/^.{,20}$|^.{200,}$/d' $file;

cat all.tsv.clean.temp | shuf > all.tsv.clean
touch 999.tsv.temp
rm [0-9]*.tsv.temp all.tsv.clean.temp
