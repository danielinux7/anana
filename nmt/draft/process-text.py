from tempfile import NamedTemporaryFile
import shutil, csv, re

filename = 'test.tsv'
tempfile = NamedTemporaryFile('w+t', newline='', delete=False)

with open(filename, 'r', newline='') as tsvFile, tempfile:
    reader = csv.reader(tsvFile, delimiter='\t')
    writer = csv.writer(tempfile, delimiter='\t')

    for row in reader:
        row[1] = row[1].title()
        print(row[0])
        writer.writerow(row)

shutil.move(tempfile.name, 'test2.tsv')
