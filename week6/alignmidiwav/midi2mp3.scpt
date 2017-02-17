-- midi2mp3.scpt
-- 
-- Script to convert a midi file into an MP3 using iTunes.
-- Note: You must provide a *full* posix path as the input midi file;
-- output file is the same stem but with a .mp3 extension.
--
-- 2000-02-25 Dan Ellis dpwe@ee.columbia.edu

on run argv
  set theMidiFile to posix file (item 1 of argv) as alias

  tell application "Finder"
    set theOutputDir to (folder of theMidiFile)
    set newFileName to (text 1 thru -5 of (get name of theMidiFile)) & ".mp3"
  end

  tell application "iTunes"
    -- Import MIDI
    set theOriginaliTunesFile to (add theMidiFile)
    -- Prepare encoder
    set lastEncoder to current encoder
    set newEncoder to (item 1 of (every encoder whose format is "MP3"))
    set current encoder to newEncoder
    -- Convert to audio
    set theAudioFile to item 1 of (convert theOriginaliTunesFile)
    set current encoder to lastEncoder
    -- Remove original
    delete theOriginaliTunesFile
    set fileLocation to location of theAudioFile
    -- Set as audio book type
    tell application "Finder"
	  set newFile to (duplicate file fileLocation to theOutputDir)
	  set name of newFile to newFileName
	end tell
    -- Remove from iTunes
    delete theAudioFile
  end tell
end run
