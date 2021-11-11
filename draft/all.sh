for file in $(ls | grep '^[0-9]\+.txt.temp$');
do
  cp $file ${file/.temp/.clean};
done

for file in $(ls | grep '^[0-9]\+.txt.clean$');
do
  # Delete all sentences that does not end with ?!.
  sed -i -e '/[^\.!?]$/d' $file
  ### Remove all sentences with capitals in between.
  # And capitalize all sentences.
  sed -i -e 's/\(^[[:alpha:]]\)/\L\1/' -e '/[[:upper:]]/d'  $file
  sed -i -e 's/^\([[:alpha:]]\)/\U\1/' $file
  # Remove all but the following symbols
  grep -v -i '[^ !,-\.\?аәбвгӷдежзӡикқҟлмнопԥрстҭуфхҳцҵчҷҽҿџшыьҩ]' $file | \
  # Remove stuff like С а с р ы ҟ ә а
  grep -v -i '[[:alpha:]] [[:alpha:]] ' | \
  grep -v -i '^[^[:alpha:]]' > $file.temp;
  cp  $file.temp  $file;
  # Keep and remove sentences that have the following
  grep '\(н\|т\|м\|п\|зеи\|уеи\|ама\|ома\|ума\|зма\|ои\|ми\|зи\)[ \.?!,]' $file | \
  grep -v 'Ҳәа \|[ИСРШЛҲ]ҳә[аое]' > $file.temp
  cp  $file.temp  $file;
  # Remove and clean up sentences with .. ...
  grep -v '[^\.]\.\.' $file.temp > $file
  grep '[^\.]\.\.' $file.temp | \
  grep '\(н\|т\|м\|п\|зеи\|уеи\|ама\|ома\|ума\|зма\|ои\|ми\|зи\)[ \.?!,]' >> $file
  sed -i -r 's/(зеи|уеи|ама|ома|ума|зма|ои|ми|зи)[\.]+\./\1?/g' $file
  sed -i -r 's/[\.]+\.$/./g' $file
  sed -i -r 's/(зеи|уеи|ама|ома|ума|зма|ои|ми|зи)[\.]+\./\1?/g' ${file/.clean/.temp}
  sed -i -r 's/[\.]+\.$/./g' ${file/.clean/.temp}
  ### Remove sentences with most common Russian words
  sed -i -r '/\b(и|в|не|он|на|я|что|тот|быть|с|а|весь|это|как|она|по|но|они|к|у|ты|из|мы|за|вы|так|же|от|сказать|этот|который|мочь|человек|о|один|ещё|бы|такой|только|себя|своё|какой|когда|уже|для|вот|кто|да|говорить|год|знать|мой|до|или|если|время|рука|нет|самый|ни|стать|большой|даже|другой|наш|свой|ну|под|где|дело|есть|сам|раз|чтобы|два|там|чем|глаз|жизнь|первый|день|тут|во|ничто|потом|очень|со|хотеть|ли|при|голова|надо|без|видеть|идти|теперь|тоже|стоять|друг|дом|сейчас|можно|после|слово|здесь|думать|место|спросить|через|лицо|что|тогда|ведь|хороший|каждый|новый|жить|должный|смотреть|почему|потому|сторона|просто|нога|сидеть|понять|иметь|конечный|делать|вдруг|над|взять|никто|сделать|дверь|перед|нужный|понимать|казаться|работа|три|ваш|уж|земля|конец|несколько|час|голос|город|последний|пока|хорошо|давать|вода|более|хотя|всегда|второй|куда|пойти|стол|ребёнок|увидеть|сила|отец|женщина|машина|случай|ночь|сразу|мир|совсем|остаться|об|вид|выйти|дать|работать|любить|старый|почти|ряд|оказаться|начало|твой|вопрос|много|война|снова|ответить|между|подумать|опять|белый|деньги|значить|про|лишь|минута|жена|посмотреть|правда|главный|страна|свет|ждать|мать|будто|никогда|товарищ|дорога|однако|лежать|именно|окно|никакой|найти|писать|комната|Москва|часть|вообще|книга|маленький|улица|решить|далекий|душа|чуть|вернуться|утро|некоторый|считать|сколько|помнить|вечер|пол|таки|получить|народ|плечо|хоть|сегодня|бог|вместе|взгляд|ходить|зачем|советский|русский|бывать|полный|прийти|палец|Россия|любой|история|наконец|мысль|узнать|назад|общий|заметить|словно|прошлый|уйти|известный|давно|слышать|слушать|бояться|сын|нельзя|прямо|долго|быстро|лес|похожий|пора|пять|глядеть|оно|сесть|имя|ж|разговор|тело|молодой|стена|красный|читать|право|старик|ранний|хотеться|мама|оставаться|высокий|путь|поэтому|совершенно|кроме|тысяча|месяц|брать|написать|целый|огромный|начинать|спина|настоящий|пусть|язык|точно|среди|чувствовать|сердце|вести|иногда|мальчик|успеть|небо|живой|смерть|продолжать|девушка|образ|ко|забыть|вокруг|письмо|власть|чёрный|пройти|появиться|воздух|разный|выходить|просить|брат|собственный|отношение|затем|пытаться|показать|вспомнить|система|четыре|квартира|держать|также|любовь|солдат|откуда|чтоб|называть|третий|хозяин|вроде|уходить|подойти|поднять|особенно|спрашивать|начальник|оба|бросить|школа|парень|кровь|двадцать|солнце|неделя|послать|находиться|ребята|поставить|встать|например|шаг|мужчина|равно|нос|мало|внимание|капитан|ухо|туда|сюда|играть|следовать|рассказать|великий|действительно|слишком|тяжёлый|спать|оставить|войти|длинный|чувство|молчать|рассказывать|отвечать|становиться|остановиться|берег|семья|искать|генерал|момент|десять|начать|следующий|личный|труд|верить|группа|немного|впрочем|видно|являться|муж|разве|движение|порядок|ответ|тихо|знакомый|газета|помощь|сильный|скорый|собака|дерево|снег|сон|смысл|смочь|против|бежать|двор|форма|простой|приехать|иной|кричать|возможность|общество|зелёный|грудь|угол|открыть|происходить|ладно|чёрный|век|карман|ехать|немец|наверное|губа|дядя|приходить|часто|домой|огонь|писатель|армия|состояние|зуб|очередь|кой|подняться|камень|гость|показаться|ветер|собираться|попасть|принять|сначала|либо|поехать|услышать|уметь|случиться|странный|единственный|рота|закон|короткий|море|добрый|тёмный|гора|врач|край|стараться|лучший|река|военный|мера|страшный|вполне|звать|произойти|вперед|медленно|возле|никак|заниматься|действие|довольно|вещь|необходимый|ход|боль|судьба|причина|положить|едва|черта|девочка|лёгкий|волос|купить|номер|основной|широкий|умереть|далеко|плохо|глава|красивый|серый|пить|командир|обычно|партия|проблема|страх|проходить|ясно|снять|бумага|герой|пара|государство|деревня|речь|начаться|средство|положение|связь|скоро|небольшой|представлять|завтра|объяснить|пустой|произнести|человеческий|нравиться|однажды|мимо|иначе|существовать|класс|удаться|толстый|цель|сквозь|прийтись|чистый|знать|прежний|профессор|господин|счастье|худой|дух|план|чужой|зал|представить|особый|директор|бывший|память|близкий|сей|результат|больной|данный|кстати|назвать|след|улыбаться|бутылка|трудно|условие|прежде|ум|улыбнуться|процесс|картина|вместо|старший|легко|центр|подобный|возможно|около|смеяться|сто|будущее|хватать|число|всякое|рубль|почувствовать|принести|вера|вовсе|удар|телефон|колено|согласиться|мало|коридор|мужик|правый|автор|холодный|хватить|многие|встреча|кабинет|документ|самолёт|вниз|принимать|игра|рассказ|хлеб|развитие|убить|родной|открытый|менее|предложить|жёлтый|приходиться|выпить|крикнуть|трубка|враг|показывать|двое|доктор|ладонь|вызвать|спокойно|попросить|наука|лейтенант|служба|оказываться|привести|сорок|счёт|возвращаться|золотой|местный|кухня|крупный|решение|молодая|тридцать|роман|требовать|компания|частый|российский|рабочий|потерять|течение|синий|столько|тёплый|метр|достать|железный|институт|сообщить|интерес|обычный|появляться|упасть|остальной|половина|московский|шесть|получиться|качество|бой|шея|вон|идея|видимо|достаточно|провести|важный|трава|дед|сознание|родитель|простить|бить|чай|поздний|кивнуть|род|исчезнуть|тонкий|немецкий|звук|отдать|магазин|президент|поэт|спасибо|болезнь|событие|помочь|кожа|лист|слать|вспоминать|прекрасный|слеза|надежда|молча|сильно|верный|литература|оружие|готовый|запах|неожиданно|вчера|вздохнуть|роль|рост|природа|политический|точка|звезда|петь|садиться|фамилия|характер|пожалуйста|выше|офицер|толпа|перестать|придтись|уровень|неизвестный|кресло|баба|секунда|пожаловать|банк|опыт|тихий|поскольку|сапог|правило|стекло|получать|внутренний|дочь|называться|надеяться|член|протянуть|государственный|десяток|глубокий|цветок|ах|желание|дождь|впереди|подходить|много|лоб|улыбка|борьба|ворот|ящик|этаж|служить|вновь|голубой|нечего|революция|впервые|сосед|сестра|долгий|чей|поверить|ситуация|взглянуть|слабый|количество|вызывать|уверенный|выход|совет|дурак|любимый|союз|лето|ожидать|пришлый|висеть|граница|цвет|серьёзный|создать|интересно|свобода|зато|стул|уехать|поезд|музыка|быстрый|тень|лошадь|поле|выглядеть|учиться|левый|разговаривать|детский|тип|суд|связанный|горячий|площадь|помогать|счастливый|повернуться|позволить|встретить|радость|острый|возраст|орган|карта|входить|обнаружить|король|слава|полковник|мелкий|бок|цена|информация|мозг|удовольствие|воля|область|крыша|нести|обратно|современный|дама|семь|весёлый|прислать|сад|правительство|милый|относиться|возникать|мол|повторить|название|средний|пример|невозможно|зеркало|погибнуть|американский|дым|гореть|плакать|весьма|факт|двигаться|рыба|добавить|удивиться|бабушка|вино|ибо|учитель|действовать|осторожно|круг|папа|правильно|недавно|держаться|причём|лететь|носить|повод|лагерь|птица|корабль|мнение|ночной|здоровый|зима|сухой|километр|кровать|привыкнуть|прочее|свободный|лестница|неужели|обязательно|вверх|детство|остров|статья|позвонить|столь|мешать|водка|темнота|возникнуть|способный|станция|желать|попробовать|получаться|гражданин|странно|вскоре|интересный|команда|заболевание|живот|ставить|ради|тишина|понятно|фронт|щека|страшно|район|наверно|проводить|выражение|слегка|мешок|обещать|дорогой|судить|большинство|собраться|управление|колоть|мокрый|приказ|прямой|закричать|кончиться|куст|стрелять|художник|знак|завод|кулак|использовать|стакан|пахнуть|отсюда|рот|пора)\b/Id' $file
  ### Remove more than 14 words and 10-90 characters.
  awk 'NF < 15' $file > $file.temp
  awk 'length($0)<90' $file.temp | awk 'length($0)>10' > $file
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
### Sorting and removing duplicates, dirty text
cat all.txt all.txt.clean > all.txt.temp
file="all.txt.temp"
cut -f2 $file | sed -e 's/[[:punct:]]//g' | sed 's/./\L&/g' | \
paste $file - > $file.temp;
sort -t$'\t' -k3 -u $file.temp | cut -f1,2 | shuf > ${file/.temp/.dirty};
# Remove all temp files
rm *.temp $(ls | grep '^[0-9]\+.txt.clean$')
