import json;
from tqdm import tqdm;

f = open('caption.json')
data = json.load(f)

for i, sub in tqdm(enumerate(data)):
  clip = AudioSegment.from_file(sub["clip"]);
  after = AudioSegment.silent(duration=(data[i+1]["start_sec"]-sub["start_sec"]+sub["duration"])*1000);
  final_sound = clip+after;
pad = AudioSegment.silent(duration=data[0];
final_sound = pad + final_sound;
final_sound.export("audio.m4a", format="mp4")
