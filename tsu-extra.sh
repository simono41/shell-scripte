set -ex

HOME=/storage/emulated/0
PREFIX=/data/data/com.termux/files/usr
ROOT_HOME=$HOME
ROOT_SHELL=$PREFIX/bin/bash
#mkdir -p $HOME/.suroot

su --preserve-environment -c "LD_LIBRARY_PATH=$PREFIX/lib HOME=$ROOT_HOME $ROOT_SHELL"
