#!/bin/bash

NVIM_ROOT=$(realpath $(dirname $0)/nvim)
CONFIG_DIR=$(realpath ${XDG_CONFIG_HOME:-$HOME/.config}/nvim)

echo $NVIM_ROOT
echo $CONFIG_DIR

if [ ! -d $CONFIG_DIR ]; then
    echo "$CONFIG_DIR is not exists!"
    echo "Make it"
    mkdir -p $CONFIG_DIR
fi

function make_link(){
    cd $CONFIG_DIR
    echo "Make symlink to $1"
    ln -s $1
}

for config in $NVIM_ROOT/*; do
    make_link $(realpath $config)
done
