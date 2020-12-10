#!/usr/bin/bash
# -------------------------------------------------------------
#   A simple script that outputs a gif from a webm file by     
#   using FFmpeg.					       
# -------------------------------------------------------------
# Prerequisites: bash, FFmpeg				       
#   Instalation: Move the file your /usr/local/bin/ directory.   
#    How to use: webmtogif <file>				       
#	     ex: webtogif video.webm
# ------------------------------------------------------------
# Author: Rômulo Pinheiro
# Creation: 10/12/2020
# version: 1
# License: GPL
#-------------------------------------------------------------

webmtogif () {
		filename=$1
		tempfolder=$(mktemp -d)
		trap "rm -vfr $tempfolder" EXIT

		# Check if extension is webm
		if [[ ${filename##*.} == 'webm' ]];
		then
				ffmpeg -y -i "$filename" -vf palettegen "$tempfolder/palette.png"
				ffmpeg -y -i "$filename" -i "$tempfolder/palette.png" -filter_complex paletteuse -r 10 "$PWD/${filename/%webm/gif}"
		else
				echo "the file extension must be 'webm'."
		fi

}

webmtogif $1
