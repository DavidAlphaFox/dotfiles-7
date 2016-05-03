#!/bin/bash

cd ~/src
for i in *; do cd $i; git gc; git remote prune origin; git pull; cd ..; done
