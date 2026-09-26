#!/usr/bin/env bash

swapinfo -k | awk '
NR>1 {
    used += $3
    total += $2
}
END {
    if (total > 0)
        printf "%.1f/%.1fGB\n", used/1024/1024, total/1024/1024
    else
        print "? / ?GB"
}'
