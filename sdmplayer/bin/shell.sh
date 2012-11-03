#!/bin/sh
## This version is edit by SotongDJ, base on mobileread one.
## See http://www.mobileread.com/forums/showthread.php?t=119851 for original control.sh

## /mnt/us is the root directory when mounting the Kindle via USB
INSTALLDIR=/mnt/us/extensions/sdmplayer
BINDIR=/mnt/us/extensions/sdmplayer/bin
pythonbin=/mnt/us/python/bin/python
genpl=/mnt/us/extensions/sdmplayer/py/genpl.py
gensl=/mnt/us/extensions/sdmplayer/py/gensl.py
VOLUME=/mnt/us/extensions/sdmplayer/settings/volume

## Value between -20 and 19, decrease in case of music lags
NICENESS="-10"

FIFO=/tmp/mplayer.fifo
MPLAYER="nice -n$NICENESS $BINDIR/mplayer -ao alsa -slave -input file=$FIFO"
##MPLAYER="nice -n$NICENESS $BINDIR/mplayer -ao alsa -slave -quiet -input file=$FIFO"

if [ ! -e $FIFO ]; then
  mkfifo $FIFO
fi


if [ ! -f $VOLUME ]; then
    touch $VOLUME
    echo 40 > $VOLUME
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
				$MPLAYER -playlist $1 &
				VOL=`cat $VOLUME`
				cmd "volume $VOL 1"
			fi
		}
		;;
	*)
		loadplaylist() {
			if ! cmd "loadlist $1"; then
				$MPLAYER -loop 0 -playlist $1 &
				VOL=`cat $VOLUME`
				cmd "volume $VOL 1"
			fi
		}
		;;
esac

vol() {
    VOL=`cat $VOLUME`
    VOL=$((VOL))
	case "$1" in
		up)
		    if [ $VOL -lt 100 ]; then
			VOL=$((VOL+20))
		    fi
		;;
		dn)
		    if [ $VOL -gt 20 ]; then
			VOL=$((VOL-20))
		    fi
		;;
	esac
	echo $VOL > $VOLUME
	cmd "volume $VOL 1"
}

case "$1" in
	playall)
		killall audioServer
		$pythonbin $genpl --playall
		loadplaylist /tmp/mplayer.playlist
		exit
		;;
	playrand)
		killall audioServer
		$pythonbin $genpl --playrand
		loadplaylist /tmp/mplayer.playlist
		exit
		;;
	select)
		export HOME=${INSTALLDIR}/settings
		export PATH=$PATH:${INSTALLDIR}/bin
		init_orientation=`/usr/bin/lipc-get-prop com.lab126.winmgr orientationLock`
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock U
		/usr/bin/lipc-set-prop -s com.lab126.keyboard open net.fabiszewski.leafpad:Abc:1
		cd ${INSTALLDIR}/lists
		${INSTALLDIR}/bin/leafpad ${INSTALLDIR}/lists/01-Playlist-Mode.txt
		/usr/bin/lipc-set-prop com.lab126.winmgr orientationLock ${init_orientation}
		/usr/bin/lipc-set-prop -s com.lab126.keyboard close net.fabiszewski.leafpad
		exit
		;;
	playlist)
		killall audioServer
		$pythonbin $genpl --playlist
		loadplaylist /tmp/mplayer.playlist
		exit
		;;
	pause)
		cmd "pause"
		exit
		;;
	stop)
		killall mplayer
		exit
		;;
	prev)
		cmd "pt_step -1"
		exit
		;;
	next)
		cmd "pt_step 1"
		exit
		;;
	gensl)
		$pythonbin $gensl --playlist
		exit
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
		exit
		;;
	volup)
		vol up
		;;
	voldn)
		vol dn
		;;
	*)
		echo "Usage: $0 {playall|playrec|playrand|playlist|pause|stop|prev|next}"
		exit 1
		;;
esac

exit 0
