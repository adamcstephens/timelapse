#!/bin/bash

export CAPDIR=$HOME/timelapse/images

if [[ "`date +%s`" -ge "`cat /tmp/daylight_sunrise`" && "`date +%s`" -le "`cat /tmp/daylight_sunset`" ]]
then

  D1=`date +%Y-%m-%d`
  D2=`date +%Y%m%d_%H-%M-%S`

  # If the date directory does not exist, create it
  if [ ! -d $CAPDIR/$D1 ] ; then
  mkdir -p $CAPDIR/$D1
  fi

  #cd to this new directory
  cd $CAPDIR/$D1

  # fswebcam seems to solve the problems with streamer and vlc. The -S option
  # is 'skip' which brilliantly discards the first N frames before
  # saving the final one. The -r option is for 'resolution' i.e. size of
  # recorded frame in pixels

  fswebcam -d /dev/video0 -S 10 $D2.jpg
fi
