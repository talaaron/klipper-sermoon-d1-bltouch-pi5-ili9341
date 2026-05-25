#!/bin/bash

# הגדרת נתיב זמני לריצה
XDG_RUNTIME_DIR=/run/user/$(id -u)
export XDG_RUNTIME_DIR

# הגדרת תצוגה ברירת מחדל לשרת ה-X
export DISPLAY=:0

export GDK_SCALE=2
#export GDK_DPI_SCALE=4

SCRIPTPATH=$(dirname $(realpath $0))

# בדיקה אם קיים סקריפט הרצה פנימי
if [ -f $SCRIPTPATH/launch_KlipperScreen.sh ]
then
    echo "Running $SCRIPTPATH/launch_KlipperScreen.sh"
    $SCRIPTPATH/launch_KlipperScreen.sh
    exit $?
fi

# בדיקה האם להריץ על Cage (Wayland) או על X11 רגיל
if [[ "$BACKEND" =~ ^[wW]$ ]]; then
    echo "Running KlipperScreen on Cage"
    xrdb -merge <<< "Xft.dpi: 240"
    exec /usr/bin/cage -ds $KS_XCLIENT
else
    echo "Running KlipperScreen on X in display :0 by default"
    xrdb -merge <<< "Xft.dpi: 240"
    exec /usr/bin/xinit $KS_XCLIENT
fi
