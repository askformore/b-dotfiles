#!/bin/bash
# ====================================================
#   Copyright (C)2015 All rights reserved.
#
#   Author        : bbxytl
#   Email         : bbxytl@gmail.com
#   File Name     : install-vim.sh
#   Last Modified : 2015-10-30 14:54
#   Describe      :
#
#   Log           :
#
# ====================================================

lnif(){
    if [ -e "$1" ];then
        ln -sf "$1" "$2"
    fi
}

# 默认安装 simple 版
COMPLEX=false
if [ $# -ge 1 ];then
	if [ $1="--complex" ];then
		COMPLEX=true
	else
		echo "Error arg! no arg to rum simple , arg: --complex to use ycm and so on !"
		exit
	fi
fi

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

echo " Step 1: setting tu symlinks----------Vim"
if $COMPLEX;then
	bundlesfile=$CURRENT_DIR/vimrc.bundles_complex
else
	bundlesfile=$CURRENT_DIR/vimrc.bundles
fi

lnif $CURRENT_DIR/vimrc $HOME/.vimrc
lnif $bundlesfile $HOME/.vimrc.bundles
lnif $CURRENT_DIR/vimrc.config_base $HOME/.vimrc.config_base
lnif $CURRENT_DIR/vimrc.config_filetype $HOME/.vimrc.config_filetype

SYS_VERSION=`uname -s`
if [ $SYS_VERSION = 'Darwin' ];then
	lnif $CURRENT_DIR/tags_list_of_cpp/tags_list_mac $tags_list $HOME/.vim/tags_list
else if [ $SYS_VERSION = 'Linux' ];then
		lnif $CURRENT_DIR/tags_list_of_cpp/tags_list_linux $tags_list $HOME/.vim/tags_list
	fi
fi

mv $HOME/.vim/bundle/molokai/colors/molokai.vim $HOME/.vim/bundle/molokai/colors/molokai.vim.bk
cp $CURRENT_DIR/project_vimrc/molokai.vim $HOME/.vim/bundle/molokai/colors/molokai.vim

mv $HOME/.vim/bundle/vim-syntax-match/colors/syntaxmatch.vim $HOME/.vim/bundle/vim-syntax-match/colors/syntaxmatch.vim.bk
cp $CURRENT_DIR/project_vimrc/syntaxmatch.vim  $HOME/.vim/bundle/vim-syntax-match/colors

sudo mv /usr/share/vim/vim80/syntax/c.vim /usr/share/vim/vim80/syntax/c.vim.bk
sudo cp mv $CURRENT_DIR/project_vimrc/c.vim /usr/share/vim/vim80/syntax/c.vim

sudo mv /usr/share/vim/vim80/syntax/cpp.vim /usr/share/vim/vim80/syntax/cpp.vim.bk
sudo cp mv $CURRENT_DIR/project_vimrc/cpp.vim /usr/share/vim/vim80/syntax/cpp.vim

