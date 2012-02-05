require 'rubygems'
require 'midilib'                                   # => false

class Array
  def to_midi(file, note_length='eighth') 

    midi_max = 108.0
    midi_min = 21.0    

    low, high = min, max
    song = MIDI::Sequence.new

    # Create a new track to hold the melody, running at 120 beats per minute.
    song.tracks << (melody = MIDI::Track.new(song))
    melody.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(120))

    # Tell channel zero to use the "piano" sound.
    melody.events << MIDI::ProgramChange.new(0, 0)

    # Create a series of note events that play on channel zero.
    each do |number|
      midi_note = (midi_min + ((number-midi_min) * (midi_max-low)/high)).to_i
      melody.events << MIDI::NoteOnEvent.new(0, midi_note, 127, 0)
      melody.events << MIDI::NoteOffEvent.new(0, midi_note, 127, 
                                              song.note_to_delta(note_length))
    end

    open(file, 'w') { |f| song.write(f) }
  end
end
#---
((1..100).collect { |x| x ** 2 }).to_midi('squares.mid')
#---
class TimedTrack < MIDI::Track
  MIDDLE_C = 60
  @@channel_counter=0

  def initialize(number, song)
    super(number)
    @sequence = song
    @time = 0
    @channel = @@channel_counter
    @@channel_counter += 1
  end

  # Tell this track's channel to use the given instrument, and
  # also set the track's instrument display name.
  def instrument=(instrument)
    @events << MIDI::ProgramChange.new(@channel, instrument)
    super(MIDI::GM_PATCH_NAMES[instrument])
  end

  # Add one or more notes to sound simultaneously. Increments the per-track
  # timer so that subsequent notes will sound after this one finishes.
  def add_notes(offsets, velocity=127, duration='quarter')
    offsets = [offsets] unless offsets.respond_to? :each
    offsets.each do |offset|
      event(MIDI::NoteOnEvent.new(@channel, MIDDLE_C + offset, velocity))
    end   
    @time += @sequence.note_to_delta(duration)
    offsets.each do |offset|
      event(MIDI::NoteOffEvent.new(@channel, MIDDLE_C + offset, velocity))
    end
    recalc_delta_from_times
  end

  # Uses add_notes to sound a chord (a major triad in root position), using the
  # given note as the low note. Like add_notes, increments the per-track timer.
  def add_major_triad(low_note, velocity=127, duration='quarter')
    add_notes([0, 4, 7].collect { |x| x + low_note }, velocity, duration)
  end

  private

  def event(event)    
    @events << event
   event.time_from_start = @time
  end
end
#---
song = MIDI::Sequence.new
song.tracks << (melody = TimedTrack.new(0, song))
song.tracks << (background = TimedTrack.new(1, song))

melody.instrument = 56                 # Trumpet
background.instrument = 19             # Church organ

melody.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(120))
melody.events << MIDI::MetaEvent.new(MIDI::META_SEQ_NAME, 
                                    'A random Ruby composition')

# Some musically pleasing intervals: thirds and fifths.
intervals = [-5, -1, 0, 4, 7]

# Start at middle C.
note = 0
# Create 8 measures of music in 4/4 time
(8*4).times do |i|
  note += intervals[rand(intervals.size)]

  #Reset to middle C if we go out of the MIDI range
  note = 0 if note < -39 or note > 48

  # Add a quarter note on every beat.
  melody.add_notes(note, 127, 'quarter')

  # Add a chord of whole notes at the beginning of each measure.
  background.add_major_triad(note, 50, 'whole') if i % 4 == 0
end

open('random.mid', 'w') { |f| song.write(f) }
#---
