#!/usr/bin/env bash

vid=${1} # URL ID

output="${HOME}/video/${vid}"
yt-dlp --write-auto-sub --write-subs --sub-langs en,ru --convert-subs srt --output "$output" --skip-download --ignore-errors "${vid}"

toTXT() {
  sed -r -e 's/^\xef\xbb\xbf//' -e 's/\r//' -e 's/^[0-9]*$//' -e '/^[0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3} --> [0-9]{2}:[0-9]{2}:[0-9]{2},[0-9]{3}$/d' -e 's/^\s*$//' -e '/^$/d;s/<[^>]*>//g' "${1}" | uniq > "${2}"
}

toTXT "${output}.en.srt" "${output}.en.txt"
toTXT "${output}.ru.srt" "${output}.ru.txt"
