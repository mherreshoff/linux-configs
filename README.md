# linux-configs

This repository is intented to be checked out as ~/linux-configs on whichever
machine I'm using.  To set it up:

Add the line:
source ~/linux-configs/vimrc
to .vimrc


Add

source $HOME/linux-configs/shellrc.sh

To your .zshrc

Finally make links for all the dot files like this:

for i in $(ls linux-configs | grep dot); do ln -s linux-configs/$i $(echo $i | sed 's/dot//') ; done
