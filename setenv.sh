#!/bin/bash

export SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CAPDIR=$SCRIPTDIR/timelapse/images

export YESTERDAY=`date --date="-1 day" +%Y-%m-%d`
export TODAY=`date +%Y-%m-%d`

export ANSWER_FILE='/tmp/daylight_grab.tmp'
export SUNRISE_FILE='/tmp/daylight_sunrise'
export SUNSET_FILE='/tmp/daylight_sunset'
export CAPDIR=$HOME/timelapse/images
export CAPYESTERDAY=$CAPDIR/$YESTERDAY
export VIDDIR=$HOME/timelapse/videos

export TEST=TRUE
