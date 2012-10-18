#!/bin/sh
## This version is edit by SotongDJ, base on mobileread one.
## See http://www.mobileread.com/forums/showthread.php?t=119851 for original control.sh

## /mnt/us is the root directory when mounting the Kindle via USB
INSTALLDIR=/mnt/us/extensions/sdmplayer
pythonbin=/mnt/us/python/bin/python
genpl=/mnt/us/extensions/sdmplayer/py/genpl.py
gensl=/mnt/us/extensions/sdmplayer/py/gensl.py

## Value between -20 and 19, decrease in case of music lags
NICENESS="-10"

FIFO=/tmp/mplayer.fifo
##MPLAYER="nice -n$NICENESS $INSTALLDIR/mplayer -ao alsa -slave -input file=$FIFO"
MPLAYER="nice -n$NICENESS $INSTALLDIR/mplayer -ao alsa -slave -quiet -input file=$FIFO"
SHUF="$INSTALLDIR/shuf"

if [ ! -e $FIFO ]; then
  mkfifo $FIFO
fi


cmd() {
	if [ "x$(pidof mplayer)" = "x" ]; then
		return 1;
	fi
	echo "$@" > $FIFO
	return 0;
}

case "$2" in
	noneloop)
		loadplaylist() {
			if ! cmd "loadlist $1"; then
				$MPLAYER $2 0 -playlist $1 &
			fi
		}
		;;
	*)
		loadplaylist() {
			if ! cmd "loadlist $1"; then
				$MPLAYER -loop 0 -playlist $1 &
			fi
		}
		;;
esac


case "$1" in
	playall)
		$pythonbin $genpl --playall
		loadplaylist /tmp/mplayer.playlist
		;;
	playrand)
		$pythonbin $genpl --playrand
		loadplaylist /tmp/mplayer.playlist
		;;
	select)
		export HOME=${INSTALLDIR}/settings
		export PATH=$PATH:${INSTALLDIR}/bin
		init_orientation=`/usr/bin/lipc-get-prop com.lab126.winmgr orientationLock`
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock U
		/usr/bin/lipc-set-prop -s com.lab126.keyboard open net.fabiszewski.leafpad:Abc:1
		cd ${INSTALLDIR}/lists
		${INSTALLDIR}/bin/leafpad
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock ${init_orientation}
		/usr/bin/lipc-set-prop -s com.lab126.keyboard close net.fabiszewski.leafpad
		;;
	genpl)
		$pythonbin $genpl --playlist
		loadplaylist /tmp/mplayer.playlist
		;;
	pause)
		cmd "pause"
		;;
	stop)
		killall mplayer
		;;
	prev)
		cmd "pt_step -1"
		;;
	next)
		cmd "pt_step 1"
		;;
	gensl)
		$pythonbin $gensl --playlist
		;;
	settings)
		export HOME=${INSTALLDIR}/settings
		export PATH=$PATH:${INSTALLDIR}/bin
		init_orientation=`/usr/bin/lipc-get-prop com.lab126.winmgr orientationLock`
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock U
		/usr/bin/lipc-set-prop -s com.lab126.keyboard open net.fabiszewski.leafpad:Abc:1
		${INSTALLDIR}/bin/leafpad ${INSTALLDIR}/settings/sdmplayer.conf
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock ${init_orientation}
		/usr/bin/lipc-set-prop -s com.lab126.keyboard close net.fabiszewski.leafpad
		;;
	kill)
		killall audioServer
		;;
	*)
		echo "Usage: $0 {playall|playrec|playrand|playlist|pause|stop|prev|next}"
		exit 1
		;;
esac

exit 0
