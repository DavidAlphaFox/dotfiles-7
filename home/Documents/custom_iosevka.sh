#!/bin/zsh
yaourt -S --needed --noconfirm otfcc ttfautohint
npm install
for DESIGN in term termlig type; do
  CUSTOM_CONFIG="$DESIGN sans ligset-ml v-l-zshaped v-i-zshaped v-f-tailed v-a-singlestorey v-m-shortleg v-tilde-low v-asterisk-low v-caret-low v-brace-straight v-dollar-open"
  make custom-config set=$DESIGN design=$CUSTOM_CONFIG weights='medium bold'
  make custom set=$DESIGN
done
for i in `find dist -iname '*.ttf'`; do
  cp $i ~/.dotfiles/misc/.fonts/;
done
