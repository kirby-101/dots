#!/usr/bin/env bash
radeontop -d - -l 1 2>/dev/null | grep -o 'gpu [0-9.]*%' | awk '{print int($2)"%"}'
