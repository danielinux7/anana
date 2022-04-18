for file in $(ls | grep '^[0-9]\+.txt.temp$');
do
  cp $file ${file/.temp/.clean};
done

for file in $(ls | grep '^[0-9]\+.txt.clean$');
do
  # Remove all but the following symbols and patterns
  sed -i -r '/^[АБВГӶДЕЖЗӠИКҚҞЛМНОПԤРСТҬУФХҲЦҴЧҶҼҾЏШЫҨ][аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ ,?–-]*[…\.!?]$/I!d' $file
  sed -i -r '/^Ҳәа[н, ]|^[АИСРШЛҲ]ҳә[аое]|[[:alpha:]]-[[:alpha:]]+-[[:alpha:]]|\b[[:alpha:]]\b|[[:upper:]][[:upper:]]|[цнзфвпрдчсмтб]ь|ыу|ыи|уы|иы/d' $file;
  ### Remove sentences with most common Russian words
  sed -i -r '/\b(и|в|все[[:alpha:]]{0,1}|не|он|на|что|тот|быть|с|а|весь|как|она|по|но|они|к|у|ты|из|мы|за|вы|так|же|от|сказать|мочь|человек|о|один|бы|только|когда|уже|вот|кто|да|говорить|год|знать|до|или|если|рука|нет|ни|стать|даже|наш|ну|под|где|дело|есть|сам|раз|чтобы|два|там|чем|глаз|жизнь|день|тут|во|ничто|потом|очень|со|хотеть|ли|при|голова|надо|без|видеть|идти|теперь|тоже|друг|дом|можно|после|слово|здесь|думать|место|спросить|через|лицо|что|тогда|ведь|жить|смотреть|почему|потому|сторона|просто|нога|сидеть|иметь|делать|вдруг|над|никто|сделать|дверь|перед|понимать|работа|три|ваш|уж|конец|несколько|час|голос|город|пока|хорошо|давать|вода|более|всегда|куда|стол|увидеть|сила|отец|машина|ночь|сразу|мир|совсем|об|вид|дать|работать|почти|начало|вопрос|много|снова|ответить|между|подумать|деньги|значить|про|лишь|минута|жена|посмотреть|правда|страна|свет|ждать|мать|будто|никогда|дорога|однако|лежать|именно|окно|писать|комната|Москва|часть|книга|улица|решить|душа|чуть|утро|считать|сколько|помнить|вечер|пол|таки|получить|народ|плечо|хоть|бог|вместе|ходить|зачем|бывать|палец|наконец|мысль|узнать|назад|заметить|словно|давно|слышать|слушать|сын|долго|быстро|лес|пора|оно|сесть|ж|разговор|тело|стена|читать|право|старик|мама|путь|совершенно|кроме|брать|написать|начинать|спина|пусть|точно|среди|чувствовать|сердце|вести|иногда|мальчик|успеть|небо|смерть|продолжать|девушка|образ|ко|забыть|вокруг|письмо|власть|воздух|выходить|просить|брат|отношение|затем|показать|вспомнить|система|четыре|квартира|держать|также|солдат|откуда|чтоб|называть|вроде|уходить|особенно|спрашивать|начальник|оба|бросить|школа|парень|кровь|двадцать|солнце|послать|поставить|встать|например|шаг|мужчина|равно|нос|мало|внимание|капитан|ухо|туда|играть|следовать|рассказать|слишком|спать|оставить|чувство|молчать|рассказывать|отвечать|берег|искать|генерал|момент|начать|труд|верить|группа|немного|впрочем|видно|муж|разве|движение|ответ|тихо|газета|собака|дерево|снег|сон|смысл|смочь|против|бежать|двор|форма|приехать|кричать|возможность|грудь|угол|открыть|происходить|ладно|век|карман|ехать|немец|наверное|губа|приходить|часто|огонь|писатель|зуб|очередь|камень|гость|ветер|попасть|сначала|либо|поехать|услышать|уметь|рота|закон|море|гора|врач|река|мера|вполне|звать|вперед|медленно|возле|никак|довольно|ход|боль|судьба|причина|положить|едва|черта|девочка|волос|купить|номер|умереть|далеко|плохо|глава|пить|командир|обычно|проблема|страх|проходить|бумага|пара|государство|речь|средство|положение|скоро|завтра|произнести|однажды|мимо|иначе|класс|цель|сквозь|знать|профессор|господин|счастье|дух|план|зал|представить|директор|результат|кстати|назвать|след|бутылка|трудно|условие|прежде|ум|процесс|картина|вместо|легко|центр|возможно|около|сто|хватать|число|рубль|почувствовать|принести|вера|вовсе|удар|телефон|колено|мало|коридор|мужик|автор|хватить|многие|встреча|кабинет|документ|вниз|принимать|игра|рассказ|хлеб|развитие|убить|менее|предложить|выпить|крикнуть|трубка|враг|показывать|двое|доктор|ладонь|вызвать|попросить|наука|служба|привести|сорок|решение|тридцать|роман|требовать|течение|столько|метр|достать|институт|интерес|упасть|половина|шесть|качество|вон|видимо|достаточно|провести|трава|дед|сознание|родитель|простить|бить|кивнуть|род|исчезнуть|звук|отдать|магазин|президент|спасибо|болезнь|событие|помочь|кожа|лист|слать|вспоминать|слеза|надежда|молча|сильно|литература|оружие|запах|неожиданно|вчера|вздохнуть|роль|рост|природа|точка|звезда|петь|характер|выше|офицер|толпа|перестать|придтись|уровень|кресло|баба|секунда|пожаловать|банк|опыт|поскольку|сапог|правило|стекло|получать|дочь|член|цветок|ах|желание|дождь|впереди|подходить|много|лоб|улыбка|борьба|ворот|служить|вновь|нечего|впервые|сосед|сестра|поверить|количество|вызывать|выход|совет|дурак|лето|ожидать|висеть|граница|цвет|создать|интересно|свобода|зато|стул|уехать|поезд|музыка|тень|лошадь|поле|разговаривать|тип|суд|помогать|позволить|встретить|радость|возраст|орган|карта|входить|обнаружить|король|слава|полковник|бок|цена|мозг|удовольствие|область|крыша|нести|обратно|дама|семь|прислать|сад|правительство|возникать|мол|повторить|название|пример|невозможно|зеркало|погибнуть|дым|гореть|плакать|весьма|факт|рыба|добавить|бабушка|вино|ибо|учитель|осторожно|круг|папа|правильно|недавно|лететь|носить|повод|лагерь|птица|корабль|мнение|зима|километр|кровать|привыкнуть|прочее|лестница|неужели|вверх|детство|остров|позвонить|столь|мешать|водка|темнота|возникнуть|желать|попробовать|гражданин|странно|вскоре|команда|заболевание|живот|ставить|ради|тишина|фронт|страшно|наверно|проводить|выражение|слегка|мешок|судить|большинство|управление|колоть|приказ|закричать|куст|художник|знак|завод|кулак|использовать|стакан|пахнуть|рот|пора)\b/Id' $file
  ### Keep between 10-100 characters.
  sed -i -r '/^.{10,100}$/!d' $file;
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
