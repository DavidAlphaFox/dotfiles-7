#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#081021/g' \
         -e 's/rgb(100%,100%,100%)/#c7c7c7/g' \
    -e 's/rgb(50%,0%,0%)/#081021/g' \
     -e 's/rgb(0%,50%,0%)/#8fadcc/g' \
 -e 's/rgb(0%,50.196078%,0%)/#8fadcc/g' \
     -e 's/rgb(50%,0%,50%)/#081021/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#081021/g' \
     -e 's/rgb(0%,0%,50%)/#c7c7c7/g' \
	$@
