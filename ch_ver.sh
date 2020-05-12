#!/bin/bash
old_ver=1.16.3
newer_ver=1.17.4
for i in $(find . -type f | grep Dockerfile) scripts/kubernetes-images.sh
do
    sed -i "s/$old_ver/$newer_ver/" $i
done
