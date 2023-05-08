# ASUI

## Introduction

This script, doall.sh, is a tool for automatically downloading a YouTube video, converting it to an MP3 file, generating subtitles using a backend service, and then combining the audio and subtitles to create an MP4 video file. The resulting video file will be saved with the filename "sub+original filename".

## request

- g++
- node js
- ffmpeg

### backend:

you need to run
https://github.com/ahmetoner/whisper-asr-webservice
assume @ ip+1:39080 (ex: if u r current ip is 1.2.3.4, we'll assume the backend is @ 1.2.3.5)

### ENV

- linux
- console: UTF-8
- system font w/ Noto Sans Mono CJK TC

## Usage
To use this script, you need to provide a YouTube watch URL as the first parameter. For example:

```bash=
./doall.sh https://www.youtube.com/watch?v=dQw4w9WgXcQ
```

The script will then perform the following steps:

- Download the video using youtube-dl
- Convert the video to an MP3 file using ffmpeg
- Upload the MP3 file to a backend service for generating subtitles
- Download the generated subtitles
- Combine the audio and subtitles to create an MP4 video file using ffmpeg
- Save the resulting video file with the filename "sub+original filename" in the same directory as the original video file.

## Notes

- The generated subtitles may not be 100% accurate, and may require manual editing.
- This script is provided as-is, without any warranty or support. Use at your own risk.

## TODO

- argv:backend ip addr adj
- argv:sub. NL char. count auto
- trans.