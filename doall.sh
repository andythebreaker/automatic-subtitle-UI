echo "===yt-Whisper-srt=== (download translater...)"
#git clone https://github.com/Coolshanlan/HighlightTranslator
echo "===yt-Whisper-srt=== (doing yt-dlp...)"
./yt-dlp_linux -f mp4 https://www.youtube.com/watch?v=AjYdqCq2ezs | grep Destination > tmp.txt
echo "===yt-Whisper-srt=== (doing ffmpeg mp3...)"
awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//" | xargs -I {} ffmpeg -i {} -vn -qscale:a 0 {}.mp3
echo "===yt-Whisper-srt=== (doing mp3 rename...)"
sha256sum tmp.txt | awk '{print $1}' | xargs -I {} mv "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//").mp3" {}.mp3
echo "===yt-Whisper-srt=== (doing Whisper...)"
sha256sum tmp.txt | awk '{print $1}' | xargs -I {} curl -X 'POST' 'http://192.168.0.101:39080/asr?task=transcribe&language=zh&output=srt' -H 'accept: application/json' -H 'Content-Type: multipart/form-data' -F 'audio_file=@{}.mp3;type=audio/mpeg' > "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//").srt"
echo "===yt-Whisper-srt=== (srt length ADJ...)"
g++ srtn.cpp -o srtn.o && ./srtn.o "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//").srt" | tee -i utf8 "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//")_lengthADJ.srt"
echo "===yt-Whisper-srt=== (srt UTF8 ADJ...)"
iconv -f UTF-8 -t UTF-8 -c "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//")_lengthADJ.srt" > "$(awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//")_laUTF8.srt"
echo "===yt-Whisper-srt=== (ffmpeg srt+mp4...)"
awk '{$1=$2=""; print $0}' tmp.txt | sed "s/^[ \t]*//" | xargs -I {} ffmpeg -i "{}" -vf "subtitles='{}_laUTF8.srt':force_style='FontName=Noto Sans Mono CJK TC,FontSize=20,PrimaryColour=&HAA00FF00'" "SUB_{}.mp4"
echo "===yt-Whisper-srt=== (finish!)"