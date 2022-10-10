lines = []
with open("ab.po", "r") as f:
  lines = f.readlines();
mark = False;  
for i, line in enumerate(lines):
  if "msgstr[1]" in line:
    mark = True
  if mark and "msgid" in line:
    lines[i] = line.replace("msgid", "[stop]\nmsgid")
    mark = False
  if mark and i == len(lines)-1:
    lines.append("[stop]")
    mark = False
mark = False;  
for i, line in enumerate(lines):
  if "msgstr \"" in line:
    mark = True
  if mark and "msgid" in line:
    lines[i] = line.replace("msgid", "[ok]\nmsgid")
    mark = False
  if mark and i == len(lines)-1:
    lines.append("[ok]")
    mark = False
for i, line in enumerate(lines):
  lines[i] = line.replace("msgid \"", "[start]\nmsgid \"")
with open("ab.po", "w+") as f:
  f.writelines(lines);
  
lines = []
with open("ru.po", "r") as f:
  lines = f.readlines();
mark = False;  
for i, line in enumerate(lines):
  if "msgstr[1]" in line:
    mark = True
  if mark and "msgid" in line:
    lines[i] = line.replace("msgid", "[stop]\nmsgid")
    mark = False
  if mark and i == len(lines)-1:
    lines.append("[stop]")
    mark = False
mark = False;  
for i, line in enumerate(lines):
  if "msgstr \"" in line:
    mark = True
  if mark and "msgid" in line:
    lines[i] = line.replace("msgid", "[ok]\nmsgid")
    mark = False
  if mark and i == len(lines)-1:
    lines.append("[ok]")
    mark = False
for i, line in enumerate(lines):
  lines[i] = line.replace("msgid \"", "[start]\nmsgid \"")
with open("ru.po", "w+") as f:
  f.writelines(lines);
  
  
