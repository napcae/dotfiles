function vid2audio
    ffmpeg -i $argv -vn -ar 44100 -ac 2 -ab 192k -f mp3 sound.mp3
end
