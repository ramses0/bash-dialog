Best(?) way to make a popup menu for semi-portable shell scripts
================================================================

Basically there are a lot of times I would love to say:

    echo `grep ^foo /usr/share/dict/words | popup_menu`

...and have some type of keyboard navigable menu popup or selection tool, very similar to how vim's ":Explore" mechanism works.

After thorough investigation, the winner of best(?) way to make a popup menu is with the "select" builtin as follows:

    select f in aaa bbb ccc ddd ; do echo $f ; break ; done

    $ ls /usr | ~/bin/menu.sh
    1) bin      3) include    5) lib64    7) sbin    9) src
    2) games    4) lib        6) local    8) share
    #? 2
    games

It isn’t actually a popup menu per-se but you get the best bang for your buck as far as using standard unix-isms and it is pretty much universally available since it’s a bash builtin.

In actuality though, you only want to use the "select f in ..." idiom as a fallback for when the dialog command isn’t available. The following shell / dialog script is kindof ugly but gets the job done as far as providing the same inputs and outputs as above but with a more comfortable user interface.

Please see the: dmenu.sh and dmenu.opt for my take on this useful little bash tool.

They both depend on the "dialog" command being available, usually `apt-get install dialog`

Slightly more discussion here:

http://www.robertames.com/blog.cgi/entries/ascii-popup-menu-shell-script-bash.html

http://stackoverflow.com/questions/3609230/best-way-to-make-a-popup-menu-for-semi-portable-shell-scripts/3620335
