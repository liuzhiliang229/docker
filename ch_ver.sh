#!/bin/bash
old_ver=1.17.4
newer_ver=1.21.2
for i in $(find . -type f | grep Dockerfile) scripts/kubernetes-images.sh
do
    sed -i "s/$old_ver/$newer_ver/" $i
done
