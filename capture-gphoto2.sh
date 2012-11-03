#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/setenv.sh

if [[ $TEST || "`date +%s`" -ge "`cat /tmp/daylight_sunrise`" && "`date +%s`" -le "`cat /tmp/daylight_sunset`" ]]
then

  # If the date directory does not exist, create it
  if [ ! -d $CAPDIR/$TODAY ] ; then
  mkdir -p $CAPDIR/$TODAY
  fi

  #cd to this new directory
  cd $CAPDIR/$TODAY

  # fswebcam seems to solve the problems with streamer and vlc. The -S option
  # is 'skip' which brilliantly discards the first N frames before
  # saving the final one. The -r option is for 'resolution' i.e. size of
  # recorded frame in pixels

  gphoto2 --set-config flashmode=0 --set-config beep=0 --set-config syncdatetime=1 --interval=60 --capture-image-and-download --filename "%04n.%C"
fi
