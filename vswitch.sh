#!/bin/sh

##
# Simple "git branch switcher" that uses the included "dmenu.sh" script to pop
# up a menu to switch between branches.
#
# It has a few neat tricks, such as "vswitch ...partial..." will limit the
# popup menu to only branches containing that term, and if there is only one
# term that contains that partial term it won't bother showing the menu.
#
#  vswitch.sh      => full menu
#  vswitch.sh bug  => will popup any branches with the word "bug" in them
#  vswitch.sh mast => will likely switch you directly to the master branch
#
##

DMENU_LOCATION=~/bin/dmenu.sh

if [ "$1" == "" ] ; then
	git checkout $( git branch | grep -v \*  |  $DMENU_LOCATION )
else
	COUNT=$( git branch | grep -v \* | grep $1 | wc -l )
	if [ "0" == "$COUNT" ] ; then
		echo "$0: No branch matching '$1' found." 1>&2
		exit 1
	elif [ "1" == "$COUNT" ] ; then
		git checkout $( git branch | grep -v \* | grep $1 )
	else
		git checkout $( git branch | grep -v \*  | grep $1 | $DMENU_LOCATION )
	fi
fi
