#!/bin/bash

sudo apt remove clinfo -y
$HOME/driver/amdgpu-pro-21.30-1290604-ubuntu-20.04/amdgpu-install --uninstall -y
rm -r $HOME/driver $HOME/miner
rm $HOME/setup.sh $HOME/uninstall.sh