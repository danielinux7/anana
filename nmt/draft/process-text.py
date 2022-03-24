from tempfile import NamedTemporaryFile
import shutil, csv, re, os

p = re.compile('#')
f = re.compile('[0-9]*.tsv')
tempfile = NamedTemporaryFile('w+t', newline='', delete=False)

for file in os.scandir('.'):
    if file.is_file() & bool(f.match(file.name)):
        with open(file.name, 'r', newline='') as tsvFile:
            reader = csv.reader(tsvFile, delimiter='\t')
            with open(tempfile.name, 'w', newline='') as tempfile:
                writer = csv.writer(tempfile, delimiter='\t')
                for row in reader:
                    row[0] = p.split(row[0])
                    row[1] = p.split(row[1])
                    max = len(row[0]) if len(row[0]) > len(row[1]) else len(row[1])
                    for i in range(max):
                        value1 = row[0][i].strip() if i < len(row[0]) else ""
                        value2 = row[1][i].strip() if i < len(row[1]) else ""
                        writer.writerow([value1, value2])
            shutil.move(tempfile.name, file.name+'.temp')
