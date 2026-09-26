#!/usr/bin/env bash
ps -axo %cpu,comm | sort -rn | sed -n '2p'
