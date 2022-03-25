sed -i -r 's/[^[:print:]\t]//g' [0-9]*.tsv.temp;
for file in $(ls | grep '^[0-9]\+.tsv.temp$');
do
  cp $file ${file/temp/clean};
done

for file in $(ls | grep '^[0-9]\+.tsv.clean$');
do
  # Remove all but the following symbols and patterns
  sed -i -r '/^[0-9+-]*\t[аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ ,?–-]*[…\.!?]\t[ёйцукенгшщзхъфывапролджэячсмитьбю ,?–-]*[…\.!?]\t0$/I!d' $file;
  sed -i -r '/\tҲәа[н, ]|\t[АИСРШЛҲ]ҳә[аое]|[[:alpha:]]-[[:alpha:]]+-[[:alpha:]]|\b[[:alpha:]]\b|[[:upper:]][[:upper:]]/d' $file;
  ### Replace more or less than 10-90 characters.
  sed -i -r '/^.{,20}$|^.{200,}$/d' $file;
done

cat [0-9]*.tsv.temp > all.tsv.temp
cat [0-9]*.tsv.clean | shuf > all.tsv.clean
rm [0-9]*.tsv.clean [0-9]*.tsv.temp
