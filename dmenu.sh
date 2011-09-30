#!/bin/sh

##
# "dialog menu" - meant to be used as a filter / pipeline for graphically
# selecting from standard input
#
# PLEASE BE AWARE THAT QUOTING ISSUES ARE NOT TAKEN INTO CONSIDERATION!!!
#
# If you are not careful, spaces in filenames will really ruin your day.
#
# cd `ls | dmenu.sh`
##

# get stdin
ALL=`cat`

# number the lines
SPLITTED=$( echo $ALL | sed 's/ /\n/g' | awk -- '{print NR, $0 }' )

# prompt via dialog (output-fd=1 is so that dialog gui doesn't go to subshell)
OUT=$( dialog --output-fd 1 --ok-label Select --menu Choose 0 50 22 $SPLITTED )
EXIT_CODE=$?

# handle escape / cancel buttons
if [ "1" = "$EXIT_CODE" ] ; then exit 1 ; fi
if [ "255" = "$EXIT_CODE" ] ; then exit 1 ; fi

# extract text corresponding to numeric selection
CHOSEN=$( echo $ALL | sed 's/ /\n/g' | awk -- "NR==$OUT {print \$0 }" )

# print result
echo $CHOSEN

