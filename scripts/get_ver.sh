#!/bin/bash
curl -s  https://github.com/kubernetes/kubernetes/releases | grep '/kubernetes/kubernetes/releases/tag/' | sed -n 2p | awk -F '[<>]' '{print $3}'
