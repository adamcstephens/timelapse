#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/setenv.sh

if [ -e $ANSWER_FILE ]
  rm $ANSWER_FILE
fi

if [ ! -e $ANSWER_FILE ] 
then
  # get sunrise/sunset info and store it in temporary files
  curl --silent --output ${ANSWER_FILE} "http://www.wolframalpha.com/input/?i=sun"

  export sunrise=`sed -n "s/.*sunrise | \([0-9]\{1,2\}:[0-9]\{1,2\}\) am.*/\1/p" ${ANSWER_FILE} | head -n 1` 
  export sunset=`sed -n "s/.*sunset | \([0-9]\{1,2\}:[0-9]\{1,2\}\) pm.*/\1/p" ${ANSWER_FILE} | head -n 1`

  date --date "$sunrise am -1 hour" +%s > $SUNRISE_FILE
  date --date "$sunset pm +1 hour" +%s > $SUNSET_FILE

fi

if [ -d $CAPYESTERDAY ]
then
  if [ ! -e $VIDDIR/${YESTERDAY}.mp4 ]
  then 
    if [ ! -d $VIDDIR ]
    then
      mkdir -p $VIDDIR
    fi
    cd $CAPYESTERDAY

    # process fswebcam images
    #mkdir img_in_order
    #x=1;for i in *jpg; do counter=$(printf %04d $x); ln -s "$i" img_in_order/img"$counter".jpg; x=$(($x+1)); done
    #ffmpeg -i img_in_order/img%04d.jpg -r 2 -intra -qscale 1 $VIDDIR/${YESTERDAY}.mp4

    ffmpeg -i %04d.jpg -r 2 -intra -qscale 1 $VIDDIR/${YESTERDAY}.mp4
    youtube-upload --email=adamcstephens@gmail.com --password="bvmzoostaknxmmdl" --category=Education --title="${YESTERDAY}" --unlisted $VIDDIR/${YESTERDAY}.mp4
  fi
fi

