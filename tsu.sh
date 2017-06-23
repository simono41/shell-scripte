ROOT_HOME=$HOME/.suroot
ROOT_SHELL=$PREFIX/bin/bash
mkdir $HOME/.suroot

su --preserve-environment -c "LD_LIBRARY_PATH=$PREFIX/lib HOME=$ROOT_HOME $ROOT_SHELL"
