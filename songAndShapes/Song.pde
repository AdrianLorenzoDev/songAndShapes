public class Song {
  boolean repetition = false;
  
  final float maxPulses = 32;
  final float rythmDynamic = 100;
  final float leadDynamic = 120;
  
  final float[] Fbass = {getNote(Notes.F, 3)};
  final float[] Fmaj = {getNote(Notes.C, 4), getNote(Notes.F, 4), getNote(Notes.A, 4), getNote(Notes.C, 5), getNote(Notes.F, 5)};

  final float[] Cbass = {getNote(Notes.C, 4)};
  final float[] Cmaj = {getNote(Notes.E, 4), getNote(Notes.G, 4), getNote(Notes.C, 5), getNote(Notes.E, 5)};

  final float[] Dbass = {getNote(Notes.D, 4)};
  final float[] Dmin = {getNote(Notes.A, 4), getNote(Notes.D, 5), getNote(Notes.F, 5)};

  final float[] Bbbass = {getNote(Notes.Asharp, 3)};
  final float[] Bb = {getNote(Notes.F, 4), getNote(Notes.Asharp, 4), getNote(Notes.D, 5), getNote(Notes.F, 5)};

  float getNote(float baseNote, float octave) {
    return octave * 12 + baseNote;
  }
  
  float strummingPattern(float[] bass, float[] chord, float pulse) {
    for (int i = 0; i < 2; i++) {
      score.addChord(pulse, bass, rythmDynamic, random(2, 2.5));
      score.addCallback(pulse, SongState.bass);
      pulse += 1;
      score.addChord(pulse, chord, rythmDynamic, random(0.75, 0.95));
      score.addCallback(pulse, SongState.rhythm);
      pulse += 1;
      score.addChord(pulse, bass, rythmDynamic, random(2, 2.5));
      score.addCallback(pulse, SongState.bass);
      pulse += .5;
      score.addChord(pulse, chord, rythmDynamic, random(0.75, 0.95));
      score.addCallback(pulse, SongState.rhythm);
      pulse += 1;
      score.addChord(pulse, chord, rythmDynamic, random(0.75, 0.95));
      score.addCallback(pulse, SongState.rhythm);
      pulse += .5;
    }
  
    return pulse;
  }
  
  void rhythmTrack() {
    float pulse = 0;
    pulse = strummingPattern(Fbass, Fmaj, pulse);
    pulse = strummingPattern(Cbass, Cmaj, pulse);
    pulse = strummingPattern(Dbass, Dmin, pulse);
    pulse = strummingPattern(Bbbass, Bb, pulse);
  }
  
  void soloTrack() {
    float pulse = 7.5;
    score.addNote(pulse, getNote(Notes.G, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.G, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.E, 5), leadDynamic, 5.5);
    while(pulse < 14.5) {
      score.addCallback(pulse, SongState.leadSustain);
      pulse += .1;
    }
    
    pulse += 1;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.E, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.D, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, 5);
    while(pulse < 22.5) {
      score.addCallback(pulse, SongState.leadSustain);
      pulse += .1;
    }
    
    pulse += 1;
    score.addNote(pulse, getNote(Notes.G, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, 3.5);
    while(pulse < 27.5) {
      score.addCallback(pulse, SongState.leadSustain);
      pulse += 1;
    }
    
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.9, 1.1));
    score.addCallback(pulse, SongState.lead);
    pulse += 1;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.F, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += 1;
        
   
    score.addNote(pulse, getNote(Notes.E, 5), leadDynamic, random(0.9, 1.1));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
    score.addNote(pulse, getNote(Notes.E, 5), leadDynamic, random(0.4, 0.6));
    score.addCallback(pulse, SongState.lead);
    pulse += .5;
  }
  
  void drumsTrack() {
    float pulse = 0;
    for (int i = 0; i < 4; i++) {
      score.addNote(pulse, 9, 0, SCScore.BASS_DRUM, 100, 0.25, 0.8, 64);
      pulse += 1;
      score.addNote(pulse, 9, 0, SCScore.ACOUSTIC_SNARE, 100, 0.25, 0.8, 64);
      score.addCallback(pulse, SongState.snare);
      pulse += 1.5;
      
      score.addNote(pulse, 9, 0, SCScore.BASS_DRUM, 100, 0.25, 0.8, 64);
      pulse += 0.5;
      score.addNote(pulse, 9, 0, SCScore.ACOUSTIC_SNARE, 100, 0.25, 0.8, 64);
      score.addCallback(pulse, SongState.snare);
      pulse += 0.5;
      
      score.addNote(pulse, 9, 0, SCScore.BASS_DRUM, 100, 0.25, 0.8, 64);
      pulse += 0.5;
      score.addNote(pulse, 9, 0, SCScore.BASS_DRUM, 100, 0.25, 0.8, 64);
      pulse += 1;
      
      score.addNote(pulse, 9, 0, SCScore.ACOUSTIC_SNARE, 100, 0.25, 0.8, 64);
      score.addCallback(pulse, SongState.snare);
      pulse += 1.5;
      
      score.addNote(pulse, 9, 0, SCScore.BASS_DRUM, 100, 0.25, 0.8, 64);
      pulse += 0.5;
      score.addNote(pulse, 9, 0, SCScore.ACOUSTIC_SNARE, 100, 0.25, 0.8, 64);
      score.addCallback(pulse, SongState.snare);
      pulse += 1;
    }
  }
  
  void playTrack(){
    score.empty();
    rhythmTrack();
    if (repetition) {
      soloTrack();
      repetition = false;
    } else {
      repetition = true; 
    }
    drumsTrack();
    score.addCallback(maxPulses, SongState.finished);
    score.play(); 
  }
}
