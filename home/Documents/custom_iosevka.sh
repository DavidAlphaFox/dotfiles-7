#!/bin/zsh

for DESIGN in term termlig type; do
  CUSTOM_CONFIG="$DESIGN sans ligset-ml v-l-zshaped cv05 v-a-singlestorey v-m-shortleg v-tilde-low v-asterisk-low v-caret-low v-brace-straight v-dollar-open"
  make custom-config set=$DESIGN design=$CUSTOM_CONFIG weights='medium'
  make custom set=$DESIGN
done

