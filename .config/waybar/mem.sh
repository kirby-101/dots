#!/usr/bin/env bash

pagesize=$(sysctl -n hw.pagesize)
physmem=$(sysctl -n hw.physmem)

free=$(($(sysctl -n vm.stats.vm.v_free_count) * pagesize))
inactive=$(($(sysctl -n vm.stats.vm.v_inactive_count) * pagesize))
cache=$(($(sysctl -n vm.stats.vm.v_cache_count) * pagesize))

avail=$((free + inactive + cache))
used=$((physmem - avail))

awk -v used="$used" -v total="$physmem" '
BEGIN {
    printf "%.1f/%.1fGB\n", used/1024/1024/1024, total/1024/1024/1024
}'
